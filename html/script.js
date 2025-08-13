const el = {
  root: document.getElementById('v1'),
  front: document.getElementById('frontArrow'),
  side: document.getElementById('sideArrow'),
  rear: document.getElementById('rearArrow'),
  bx: document.getElementById('band-x'),
  bk: document.getElementById('band-k'),
  bka: document.getElementById('band-ka'),
  bl: document.getElementById('band-laser'),
  leds: document.getElementById('signal'),
  alert: document.getElementById('alert'),
  beep: document.getElementById('beep')
};

function setArrows(dir) {
  el.front.classList.toggle('active', dir === 'front');
  el.side.classList.toggle('active', dir === 'side');
  el.rear.classList.toggle('active', dir === 'rear');
}

function setBand(band) {
  const map = { x: el.bx, k: el.bk, ka: el.bka, laser: el.bl };
  [el.bx, el.bk, el.bka, el.bl].forEach(e => e.classList.remove('active'));
  const key = (band || 'ka').toLowerCase();
  (map[key] || el.bka).classList.add('active');
}

function setLeds(strength) {
  const num = Math.floor(Math.max(0, Math.min(1, strength)) * 8);
  el.leds.innerHTML = '';
  for (let i = 0; i < 8; i++) {
    const d = document.createElement('div');
    d.className = 'led';
    if (i < num) {
      let cls = 'low';
      if (strength > 0.6) cls = 'high';
      else if (strength > 0.3) cls = 'medium';
      d.classList.add('on', cls);
    }
    el.leds.appendChild(d);
  }
}

function maybeBeep(strength) {
  // If you want authentic sounds, put files in this folder and set their src here.
  // Example: el.beep.src = 'v1_beep.mp3'
  if (!strength || strength <= 0) return;
  const now = Date.now();
  window.__lastBeep = window.__lastBeep || 0;
  const min = 900, max = 140; // ms
  const period = min + (max - min) * strength;
  if (now - window.__lastBeep > period) {
    // Default: use game front-end beep via postMessage to client playSound (handled in Lua) OR simple HTML5 stub
    try { el.beep.currentTime = 0; el.beep.play().catch(()=>{}); } catch(e){}
    window.__lastBeep = now;
  }
}

window.addEventListener('message', (event) => {
  const data = event.data;
  if (data.type === 'show') {
    el.root.classList.remove('hidden');
  }
  if (data.type === 'hide') {
    el.root.classList.add('hidden');
  }
  if (data.type === 'update') {
    setBand(data.band);
    setArrows(data.direction);
    setLeds(data.strength);
    if (data.strength > (data.alertThreshold || 0.75)) {
      el.alert.style.display = 'block';
    } else {
      el.alert.style.display = 'none';
    }
    // Optional sound
    if (data.useSounds) maybeBeep(data.strength);
  }
});
