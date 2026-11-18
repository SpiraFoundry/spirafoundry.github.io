(function () {
  function initShader() {
    const canvas = document.getElementById('shader-canvas-ANIMATION_13');
    if (!canvas || canvas.dataset.shaderInit === 'true') return;
    canvas.dataset.shaderInit = 'true';

    let onResize = null;
    function syncSize() {
      const w = canvas.clientWidth || 1280;
      const h = canvas.clientHeight || 720;
      if (canvas.width !== w || canvas.height !== h) {
        canvas.width = w;
        canvas.height = h;
        if (onResize) onResize();
      }
    }

    let resizeObserver = null;
    if (typeof ResizeObserver !== 'undefined') {
      resizeObserver = new ResizeObserver(syncSize);
      resizeObserver.observe(canvas);
    }
    syncSize();

    const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
    if (!gl) return;

    const vs = `attribute vec2 a_position;
varying vec2 v_texCoord;
void main() {
  v_texCoord = a_position * 0.5 + 0.5;
  gl_Position = vec4(a_position, 0.0, 1.0);
}`;

    const fs = `precision highp float;
uniform float u_time;
uniform vec2 u_resolution;
varying vec2 v_texCoord;

float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

mat2 rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}

float vNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.55;
    mat2 r = rot(0.52);
    for (int i = 0; i < 4; i++) {
        v += a * vNoise(p);
        p = r * p * 2.08;
        a *= 0.48;
    }
    return v;
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / u_resolution.y;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    vec3 col = mix(vec3(0.008, 0.018, 0.045), vec3(0.004, 0.009, 0.024), st.y);

    float drift = sin(uv.y * 3.2 - u_time * 1.3) * 0.12 + cos(uv.y * 1.6 + u_time * 0.7) * 0.08;
    float conduitDist = abs(uv.x - drift);

    float columnGlow = 0.045 / (conduitDist + 0.18);
    float atmosphericBloom = 0.12 / (conduitDist + 0.55);

    vec3 energyCyan = vec3(0.0, 0.94, 1.0);
    vec3 energyElectricBlue = vec3(0.18, 0.52, 1.0);
    vec3 energyPrismViolet = vec3(0.60, 0.35, 1.0);
    vec3 powderSparkle = vec3(0.88, 0.97, 1.0);

    vec2 mistCoord1 = vec2(uv.x * 3.0 + drift * 0.8, uv.y * 1.8 - u_time * 0.85);
    vec2 mistCoord2 = vec2(uv.x * 5.0 - drift * 0.5, uv.y * 2.6 - u_time * 1.25);
    float powderCloud1 = fbm(mistCoord1);
    float powderCloud2 = fbm(mistCoord2);
    float finePowderCloud = pow(powderCloud1 * powderCloud2 * 2.2, 1.8);

    col += energyElectricBlue * atmosphericBloom * 0.45;
    col += energyCyan * columnGlow * 0.28 * (0.85 + 0.15 * sin(u_time * 2.0));
    col += mix(energyCyan, energyPrismViolet, sin(uv.y * 2.5 - u_time * 1.2) * 0.5 + 0.5) * finePowderCloud * 0.40;

    for (float i = 0.0; i < 64.0; i++) {
        float seed1 = hash(vec2(i, i * 4.31));
        float seed2 = hash(vec2(i * 7.89, i * 2.17));
        float seed3 = hash(vec2(i * 13.11, i * 5.73));

        float speed = 0.22 + seed1 * 0.38;
        float xSpread = (seed2 - 0.5) * (1.6 + (uv.y + 0.5) * 0.6);
        float yPos = mod(u_time * speed + seed1 * 16.0, 1.8) - 0.9;

        float swirl = sin(yPos * 4.5 + u_time * 1.4 + seed3 * 6.28) * (0.05 + seed1 * 0.08);
        float microJitter = cos(yPos * 8.0 - u_time * 2.0 + seed2 * 6.28) * 0.02;
        vec2 particlePos = vec2(xSpread * 0.65 + drift * 0.7 + swirl + microJitter, yPos);

        vec2 p = uv - particlePos;
        float dist = length(p);

        float lifeAlpha = smoothstep(-0.88, -0.45, yPos) * smoothstep(0.85, 0.25, yPos);
        float radius = 0.0018 + seed3 * 0.0035;

        float core = smoothstep(radius, 0.0, dist);
        float halo = (radius * 1.8) / (dist + radius * 0.9);
        float aura = (radius * 0.8) / (dist * dist * 35.0 + 0.015);

        float twinkle = sin(u_time * (4.0 + seed2 * 6.0) + seed1 * 20.0) * 0.35 + 0.65;

        vec3 grainColor = mix(energyCyan, powderSparkle, seed1);
        if (seed2 > 0.72) {
            grainColor = mix(grainColor, energyPrismViolet, 0.55);
        } else if (seed2 < 0.25) {
            grainColor = mix(grainColor, energyElectricBlue, 0.4);
        }

        vec3 powderMote = (grainColor * core * 1.8 + grainColor * halo * 0.9 + grainColor * aura * 0.4) * lifeAlpha * twinkle;
        col += powderMote;
    }

    for (float j = 0.0; j < 48.0; j++) {
        float r1 = hash(vec2(j * 9.17, j * 3.41));
        float r2 = hash(vec2(j * 15.3, j * 8.79));

        float spd = 0.15 + r1 * 0.25;
        float xOff = (r2 - 0.5) * 1.8 + sin(u_time * 0.9 + j) * 0.05;
        float y = mod(u_time * spd + r1 * 14.0, 1.7) - 0.85;
        vec2 microPos = vec2(xOff * 0.75 + drift * 0.4, y);
        float microDist = length(uv - microPos);

        float microTwinkle = sin(u_time * 5.0 + j * 3.1) * 0.5 + 0.5;
        float microAlpha = smoothstep(-0.85, -0.4, y) * smoothstep(0.8, 0.2, y);

        vec3 microCol = mix(energyCyan, powderSparkle, r1);
        col += microCol * (0.0015 / (microDist + 0.003)) * microTwinkle * microAlpha * 0.55;
    }

    col *= clamp(1.2 - length(uv * 0.55), 0.0, 1.0);
    gl_FragColor = vec4(col, 1.0);
}`;

    function compileShader(type, src) {
      const s = gl.createShader(type);
      gl.shaderSource(s, src);
      gl.compileShader(s);
      return s;
    }

    const prog = gl.createProgram();
    gl.attachShader(prog, compileShader(gl.VERTEX_SHADER, vs));
    gl.attachShader(prog, compileShader(gl.FRAGMENT_SHADER, fs));
    gl.linkProgram(prog);
    gl.useProgram(prog);

    const buf = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, buf);
    gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 1, -1, -1, 1, 1, 1]), gl.STATIC_DRAW);

    const pos = gl.getAttribLocation(prog, 'a_position');
    gl.enableVertexAttribArray(pos);
    gl.vertexAttribPointer(pos, 2, gl.FLOAT, false, 0, 0);

    const uTime = gl.getUniformLocation(prog, 'u_time');
    const uRes = gl.getUniformLocation(prog, 'u_resolution');

    const motionQuery = window.matchMedia
      ? window.matchMedia('(prefers-reduced-motion: reduce)')
      : null;
    let rafId = null;
    let lastTimeSeconds = 0;

    function cleanup() {
      if (rafId !== null) {
        cancelAnimationFrame(rafId);
        rafId = null;
      }
      if (resizeObserver) {
        resizeObserver.disconnect();
        resizeObserver = null;
      }
      if (motionQuery && motionQuery.removeEventListener) {
        motionQuery.removeEventListener('change', onMotionChange);
      }
    }

    function drawFrame(timeSeconds) {
      if (!canvas.isConnected) {
        cleanup();
        return false;
      }
      lastTimeSeconds = timeSeconds;
      gl.viewport(0, 0, canvas.width, canvas.height);
      if (uTime) gl.uniform1f(uTime, timeSeconds);
      if (uRes) gl.uniform2f(uRes, canvas.width, canvas.height);
      gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
      return true;
    }

    onResize = function () {
      if (motionQuery && motionQuery.matches) {
        drawFrame(lastTimeSeconds);
      }
    };

    function render(t) {
      rafId = null;
      if (typeof ResizeObserver === 'undefined') syncSize();
      if (!drawFrame(t * 0.001)) return;
      if (!motionQuery || !motionQuery.matches) {
        rafId = requestAnimationFrame(render);
      }
    }

    function onMotionChange() {
      if (!canvas.isConnected) {
        cleanup();
        return;
      }
      if (motionQuery && motionQuery.matches) {
        if (rafId !== null) {
          cancelAnimationFrame(rafId);
          rafId = null;
        }
        drawFrame(lastTimeSeconds);
      } else if (rafId === null) {
        rafId = requestAnimationFrame(render);
      }
    }

    if (motionQuery && motionQuery.addEventListener) {
      motionQuery.addEventListener('change', onMotionChange);
    }

    if (motionQuery && motionQuery.matches) {
      drawFrame(lastTimeSeconds);
    } else {
      rafId = requestAnimationFrame(render);
    }
  }

  function startObserver() {
    initShader();
    if (typeof MutationObserver !== 'undefined' && document.body) {
      new MutationObserver(initShader).observe(document.body, {
        childList: true,
        subtree: true,
      });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', startObserver);
  } else {
    startObserver();
  }
})();
