<!doctype html>
<html lang="ja">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>3D After Effects - Visible Fix</title>
  <style>
    html,body{height:100%;margin:0;overflow:hidden;background:#000;}
    canvas{display:block;}
  </style>
</head>
<body>
  <script type="module">
    import * as THREE from 'https://unpkg.com/three@0.152.2/build/three.module.js';
    import { FontLoader } from 'https://unpkg.com/three@0.152.2/examples/jsm/loaders/FontLoader.js';
    import { TextGeometry } from 'https://unpkg.com/three@0.152.2/examples/jsm/geometries/TextGeometry.js';

    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0x000010);

    const camera = new THREE.PerspectiveCamera(45, window.innerWidth/window.innerHeight, 0.1, 2000);
    camera.position.set(0, 10, 90);

    const renderer = new THREE.WebGLRenderer({antialias:true});
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    const light = new THREE.PointLight(0x00ffff, 2, 400);
    light.position.set(30, 50, 100);
    scene.add(light);
    scene.add(new THREE.AmbientLight(0x99ffff, 0.6));

    const group = new THREE.Group();
    scene.add(group);

    // トーラス（光る輪）
    const torusMat = new THREE.MeshStandardMaterial({
      color:0x004455,
      emissive:0x00ffff,
      emissiveIntensity:2,
      metalness:0.8,
      roughness:0.1
    });
    const torus = new THREE.Mesh(new THREE.TorusGeometry(40, 2.5, 32, 128), torusMat);
    torus.rotation.x = Math.PI/2;
    group.add(torus);

    // パーティクル
    const particles = new THREE.Group();
    const geo = new THREE.SphereGeometry(0.3, 6, 6);
    for(let i=0;i<300;i++){
      const p = new THREE.Mesh(geo, new THREE.MeshBasicMaterial({color:new THREE.Color().setHSL(Math.random(),1,0.6)}));
      p.position.set((Math.random()-0.5)*200, (Math.random()-0.5)*100, (Math.random()-0.5)*200);
      particles.add(p);
    }
    group.add(particles);

    // フォント読み込み後に文字を追加
    const loader = new FontLoader();
    loader.load('https://unpkg.com/three@0.152.2/examples/fonts/helvetiker_regular.typeface.json', font => {
      const geo = new TextGeometry('UNREAL FX', {
        font: font,
        size: 12,
        height: 3,
        bevelEnabled: true,
        bevelThickness: 0.6,
        bevelSize: 0.4
      });
      geo.center();
      const mat = new THREE.MeshStandardMaterial({
        color:0x00ffff,
        emissive:0x00ffff,
        emissiveIntensity:1.5,
        metalness:0.9,
        roughness:0.1
      });
      const text = new THREE.Mesh(geo, mat);
      group.add(text);
    });

    // アニメーション
    let start = performance.now();
    function animate(){
      const t = (performance.now() - start) / 1000;
      const u = (t % 20) / 20; // 20秒ループ

      const radius = 70;
      camera.position.x = Math.cos(u*Math.PI*2)*radius;
      camera.position.z = Math.sin(u*Math.PI*2)*radius;
      camera.lookAt(0,0,0);

      torus.rotation.z += 0.02;
      particles.rotation.y += 0.002;
      group.rotation.y += 0.001;

      renderer.render(scene, camera);
      requestAnimationFrame(animate);
    }
    animate();

    window.addEventListener('resize',()=>{
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
    });
  </script>
</body>
</html>
