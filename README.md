import React, { useState, useEffect, useRef } from 'react';
import * as THREE from 'three';

const FortniteFPS = () => {
  const containerRef = useRef(null);
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const rendererRef = useRef(null);
  const gameStateRef = useRef('login');
  
  const [gameUI, setGameUI] = useState({
    gameState: 'login',
    health: 100,
    ammo: 30,
    kills: 0,
    deaths: 0,
    score: 0,
    online: 0,
  });

  const [playerName, setPlayerName] = useState('');

  const playerRef = useRef({
    position: { x: 0, y: 10, z: 0 },
    velocity: { x: 0, y: 0, z: 0 },
    angle: 0,
    pitch: 0,
    health: 100,
    ammo: 30,
    kills: 0,
    deaths: 0,
    score: 0,
    isJumping: false,
  });

  const keysRef = useRef({});
  const mouseRef = useRef({ x: 0, y: 0 });
  const bulletsRef = useRef([]);
  const botsRef = useRef([]);
  const gameLoopRef = useRef(null);
  const weaponRef = useRef(null);
  const weaponMuzzleRef = useRef(null);

  // スキンデータ
  const skinData = [
    { color: 0xff6b6b, name: 'Raider Red' },
    { color: 0x4ecdc4, name: 'Icy Blue' },
    { color: 0xf7b731, name: 'Golden' },
    { color: 0x5f27cd, name: 'Purple Knight' },
    { color: 0x00d2d3, name: 'Cyan' },
    { color: 0xff6348, name: 'Sunset' },
    { color: 0xa29bfe, name: 'Lavender' },
    { color: 0x74b9ff, name: 'Sky' },
  ];

  const startGame = () => {
    if (!playerName.trim()) return;
    gameStateRef.current = 'playing';
    setGameUI(prev => ({ ...prev, gameState: 'playing', online: 8 }));
    setTimeout(() => initScene(), 100);
  };

  // プレイヤーメッシュ作成
  const createPlayerMesh = (skin) => {
    const group = new THREE.Group();

    // 胴体
    const bodyGeo = new THREE.BoxGeometry(1.5, 2.5, 1);
    const bodyMat = new THREE.MeshPhongMaterial({ color: skin.color });
    const body = new THREE.Mesh(bodyGeo, bodyMat);
    body.castShadow = true;
    body.receiveShadow = true;
    group.add(body);

    // 頭
    const headGeo = new THREE.BoxGeometry(1.2, 1.5, 1);
    const headMat = new THREE.MeshPhongMaterial({ color: 0xf4a460 });
    const head = new THREE.Mesh(headGeo, headMat);
    head.position.y = 2.2;
    head.castShadow = true;
    head.receiveShadow = true;
    group.add(head);

    // 左腕
    const leftArmGeo = new THREE.BoxGeometry(0.6, 2.2, 0.7);
    const armMat = new THREE.MeshPhongMaterial({ color: skin.color });
    const leftArm = new THREE.Mesh(leftArmGeo, armMat);
    leftArm.position.set(-1.2, 0.5, 0);
    leftArm.castShadow = true;
    leftArm.receiveShadow = true;
    group.add(leftArm);

    // 右腕
    const rightArm = new THREE.Mesh(leftArmGeo, armMat);
    rightArm.position.set(1.2, 0.5, 0);
    rightArm.castShadow = true;
    rightArm.receiveShadow = true;
    group.add(rightArm);

    // 左足
    const legGeo = new THREE.BoxGeometry(0.7, 2.2, 0.7);
    const legMat = new THREE.MeshPhongMaterial({ color: 0x2c3e50 });
    const leftLeg = new THREE.Mesh(legGeo, legMat);
    leftLeg.position.set(-0.5, -1.6, 0);
    leftLeg.castShadow = true;
    leftLeg.receiveShadow = true;
    group.add(leftLeg);

    // 右足
    const rightLeg = new THREE.Mesh(legGeo, legMat);
    rightLeg.position.set(0.5, -1.6, 0);
    rightLeg.castShadow = true;
    rightLeg.receiveShadow = true;
    group.add(rightLeg);

    return group;
  };

  // 武器メッシュ作成
  const createWeapon = (camera) => {
    const group = new THREE.Group();
    group.position.set(0.5, -0.7, -1.5);

    // メインバレル
    const barrelGeo = new THREE.CylinderGeometry(0.2, 0.18, 2.5, 16);
    const barrelMat = new THREE.MeshPhongMaterial({ color: 0x1a1a1a });
    const barrel = new THREE.Mesh(barrelGeo, barrelMat);
    barrel.rotation.z = Math.PI / 2;
    barrel.position.x = 0.2;
    barrel.castShadow = true;
    group.add(barrel);

    // ストック（銃床）
    const stockGeo = new THREE.BoxGeometry(0.25, 0.25, 1.8);
    const stockMat = new THREE.MeshPhongMaterial({ color: 0x654321 });
    const stock = new THREE.Mesh(stockGeo, stockMat);
    stock.position.set(-0.3, 0, -1.5);
    stock.castShadow = true;
    group.add(stock);

    // グリップ
    const gripGeo = new THREE.BoxGeometry(0.35, 0.5, 0.4);
    const gripMat = new THREE.MeshPhongMaterial({ color: 0x2c3e50 });
    const grip = new THREE.Mesh(gripGeo, gripMat);
    grip.position.set(0, -0.2, -0.3);
    grip.castShadow = true;
    group.add(grip);

    // マガジン
    const magGeo = new THREE.BoxGeometry(0.4, 1.2, 0.5);
    const magMat = new THREE.MeshPhongMaterial({ color: 0x1a1a1a });
    const magazine = new THREE.Mesh(magGeo, magMat);
    magazine.position.set(0, -0.8, -0.2);
    magazine.castShadow = true;
    group.add(magazine);

    // サイト
    const sightGeo = new THREE.BoxGeometry(0.08, 0.4, 0.4);
    const sightMat = new THREE.MeshPhongMaterial({ color: 0x555555 });
    const sight = new THREE.Mesh(sightGeo, sightMat);
    sight.position.set(0.2, 0.3, 0.3);
    sight.castShadow = true;
    group.add(sight);

    // マズル（銃口）
    const muzzleGeo = new THREE.CylinderGeometry(0.15, 0.15, 0.3, 16);
    const muzzle = new THREE.Mesh(muzzleGeo, barrelMat);
    muzzle.rotation.z = Math.PI / 2;
    muzzle.position.set(0.2, 0, 1.5);
    weaponMuzzleRef.current = muzzle;
    group.add(muzzle);

    camera.add(group);
    return group;
  };

  const initScene = () => {
    if (!containerRef.current) return;

    try {
      if (rendererRef.current && rendererRef.current.domElement.parentNode) {
        rendererRef.current.domElement.parentNode.removeChild(rendererRef.current.domElement);
      }

      const scene = new THREE.Scene();
      scene.background = new THREE.Color(0x87ceeb);
      scene.fog = new THREE.Fog(0x87ceeb, 600, 2000);
      sceneRef.current = scene;

      const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
      scene.add(ambientLight);

      const directionalLight = new THREE.DirectionalLight(0xffffff, 0.9);
      directionalLight.position.set(150, 250, 150);
      directionalLight.castShadow = true;
      directionalLight.shadow.mapSize.width = 4096;
      directionalLight.shadow.mapSize.height = 4096;
      directionalLight.shadow.camera.left = -400;
      directionalLight.shadow.camera.right = 400;
      directionalLight.shadow.camera.top = 400;
      directionalLight.shadow.camera.bottom = -400;
      directionalLight.shadow.camera.far = 1500;
      scene.add(directionalLight);

      const camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        2000
      );
      camera.position.set(0, 10, 0);
      cameraRef.current = camera;

      const renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(window.innerWidth, window.innerHeight);
      renderer.shadowMap.enabled = true;
      renderer.shadowMap.type = THREE.PCFShadowShadowMap;
      containerRef.current.appendChild(renderer.domElement);
      rendererRef.current = renderer;

      // 地面
      const groundGeo = new THREE.PlaneGeometry(800, 800);
      const groundMat = new THREE.MeshLambertMaterial({ color: 0x4a7c4e });
      const ground = new THREE.Mesh(groundGeo, groundMat);
      ground.rotation.x = -Math.PI / 2;
      ground.position.y = 0;
      ground.receiveShadow = true;
      scene.add(ground);

      // 草地テクスチャ効果
      const grassGeo = new THREE.BufferGeometry();
      const positions = [];
      for (let i = 0; i < 1000; i++) {
        positions.push(
          (Math.random() - 0.5) * 800,
          0.05,
          (Math.random() - 0.5) * 800
        );
      }
      grassGeo.setAttribute('position', new THREE.BufferAttribute(new Float32Array(positions), 3));
      const grassMat = new THREE.PointsMaterial({ color: 0x228b22, size: 2 });
      const grass = new THREE.Points(grassGeo, grassMat);
      scene.add(grass);

      // 建物1（大塔）
      const tower1Geo = new THREE.CylinderGeometry(30, 30, 200, 32);
      const tower1Mat = new THREE.MeshPhongMaterial({ color: 0xa0522d });
      const tower1 = new THREE.Mesh(tower1Geo, tower1Mat);
      tower1.position.set(180, 100, 180);
      tower1.castShadow = true;
      tower1.receiveShadow = true;
      scene.add(tower1);

      // 建物2（大ビル）
      const build2Geo = new THREE.BoxGeometry(120, 180, 100);
      const build2Mat = new THREE.MeshPhongMaterial({ color: 0xb0c4de });
      const build2 = new THREE.Mesh(build2Geo, build2Mat);
      build2.position.set(-180, 90, -180);
      build2.castShadow = true;
      build2.receiveShadow = true;
      scene.add(build2);

      // 建物3
      const build3Geo = new THREE.BoxGeometry(100, 150, 150);
      const build3Mat = new THREE.MeshPhongMaterial({ color: 0xdaa520 });
      const build3 = new THREE.Mesh(build3Geo, build3Mat);
      build3.position.set(180, 75, -180);
      build3.castShadow = true;
      build3.receiveShadow = true;
      scene.add(build3);

      // 建物4
      const build4Geo = new THREE.BoxGeometry(150, 120, 120);
      const build4Mat = new THREE.MeshPhongMaterial({ color: 0x8b4513 });
      const build4 = new THREE.Mesh(build4Geo, build4Mat);
      build4.position.set(-180, 60, 180);
      build4.castShadow = true;
      build4.receiveShadow = true;
      scene.add(build4);

      // ランダムな小建物
      for (let i = 0; i < 20; i++) {
        const w = 40 + Math.random() * 80;
        const h = 80 + Math.random() * 120;
        const d = 40 + Math.random() * 80;
        const geo = new THREE.BoxGeometry(w, h, d);
        const colors = [0xff6b6b, 0x4ecdc4, 0xf7b731, 0xa29bfe, 0xc0392b];
        const mat = new THREE.MeshPhongMaterial({ color: colors[Math.floor(Math.random() * colors.length)] });
        const mesh = new THREE.Mesh(geo, mat);
        mesh.position.set(
          (Math.random() - 0.5) * 500,
          h / 2,
          (Math.random() - 0.5) * 500
        );
        mesh.castShadow = true;
        mesh.receiveShadow = true;
        scene.add(mesh);
      }

      // 武器作成
      createWeapon(camera);

      // ボット生成
      createBots(scene, 8);

      // イベント
      window.addEventListener('keydown', (e) => {
        keysRef.current[e.key.toLowerCase()] = true;
      });

      window.addEventListener('keyup', (e) => {
        keysRef.current[e.key.toLowerCase()] = false;
      });

      window.addEventListener('mousemove', (e) => {
        const movementX = e.movementX || e.mozMovementX || e.webkitMovementX || 0;
        const movementY = e.movementY || e.mozMovementY || e.webkitMovementY || 0;

        playerRef.current.angle -= movementX * 0.005;
        playerRef.current.pitch -= movementY * 0.005;
        playerRef.current.pitch = Math.max(-Math.PI / 3, Math.min(Math.PI / 3, playerRef.current.pitch));
      });

      window.addEventListener('click', () => {
        if (playerRef.current.ammo > 0) {
          shoot();
        }
      });

      window.addEventListener('resize', () => {
        const w = window.innerWidth;
        const h = window.innerHeight;
        camera.aspect = w / h;
        camera.updateProjectionMatrix();
        renderer.setSize(w, h);
      });

      // ゲームループ
      const gameLoop = () => {
        update();
        renderer.render(scene, camera);
        gameLoopRef.current = requestAnimationFrame(gameLoop);
      };

      gameLoop();
    } catch (error) {
      console.error('Scene init error:', error);
    }
  };

  const createBots = (scene, count) => {
    botsRef.current = [];
    for (let i = 0; i < count; i++) {
      const skin = skinData[i % skinData.length];
      const botMesh = createPlayerMesh(skin);
      botMesh.position.set(
        (Math.random() - 0.5) * 400,
        5,
        (Math.random() - 0.5) * 400
      );
      scene.add(botMesh);

      botsRef.current.push({
        mesh: botMesh,
        x: botMesh.position.x,
        y: botMesh.position.y,
        z: botMesh.position.z,
        vx: (Math.random() - 0.5) * 2,
        vz: (Math.random() - 0.5) * 2,
        health: 100,
        skin: skin,
      });
    }
  };

  const shoot = () => {
    playerRef.current.ammo--;
    setGameUI(prev => ({ ...prev, ammo: playerRef.current.ammo }));

    const angle = playerRef.current.angle;
    const pitch = playerRef.current.pitch;

    const vx = Math.sin(angle) * Math.cos(pitch) * 100;
    const vy = -Math.sin(pitch) * 100;
    const vz = Math.cos(angle) * Math.cos(pitch) * 100;

    // マズルフラッシュ効果
    if (weaponMuzzleRef.current) {
      weaponMuzzleRef.current.material.emissive.setHex(0xffaa00);
      setTimeout(() => {
        if (weaponMuzzleRef.current) {
          weaponMuzzleRef.current.material.emissive.setHex(0x000000);
        }
      }, 50);
    }

    bulletsRef.current.push({
      x: playerRef.current.position.x,
      y: playerRef.current.position.y + 1.5,
      z: playerRef.current.position.z,
      vx,
      vy,
      vz,
      life: 300,
    });
  };

  const update = () => {
    const speed = 0.3;
    
    // W: 前進（修正）
    if (keysRef.current['w']) {
      playerRef.current.velocity.x += Math.sin(playerRef.current.angle) * speed;
      playerRef.current.velocity.z += Math.cos(playerRef.current.angle) * speed;
    }
    // S: 後退（修正）
    if (keysRef.current['s']) {
      playerRef.current.velocity.x -= Math.sin(playerRef.current.angle) * speed;
      playerRef.current.velocity.z -= Math.cos(playerRef.current.angle) * speed;
    }
    // A: 左移動
    if (keysRef.current['a']) {
      playerRef.current.velocity.x += Math.sin(playerRef.current.angle - Math.PI / 2) * speed;
      playerRef.current.velocity.z += Math.cos(playerRef.current.angle - Math.PI / 2) * speed;
    }
    // D: 右移動
    if (keysRef.current['d']) {
      playerRef.current.velocity.x += Math.sin(playerRef.current.angle + Math.PI / 2) * speed;
      playerRef.current.velocity.z += Math.cos(playerRef.current.angle + Math.PI / 2) * speed;
    }

    if (keysRef.current[' '] && !playerRef.current.isJumping) {
      playerRef.current.velocity.y = 0.6;
      playerRef.current.isJumping = true;
    }

    if (keysRef.current['r']) {
      playerRef.current.ammo = 30;
      setGameUI(prev => ({ ...prev, ammo: 30 }));
    }

    // 重力と抵抗
    playerRef.current.velocity.y -= 0.02;
    playerRef.current.velocity.x *= 0.9;
    playerRef.current.velocity.z *= 0.9;

    playerRef.current.position.x += playerRef.current.velocity.x;
    playerRef.current.position.y += playerRef.current.velocity.y;
    playerRef.current.position.z += playerRef.current.velocity.z;

    // 境界処理（壁すり抜け防止）
    if (playerRef.current.position.x < -350) playerRef.current.position.x = -350;
    if (playerRef.current.position.x > 350) playerRef.current.position.x = 350;
    if (playerRef.current.position.z < -350) playerRef.current.position.z = -350;
    if (playerRef.current.position.z > 350) playerRef.current.position.z = 350;

    // 地面衝突
    if (playerRef.current.position.y < 2) {
      playerRef.current.position.y = 2;
      playerRef.current.velocity.y = 0;
      playerRef.current.isJumping = false;
    }

    // カメラ更新
    if (cameraRef.current) {
      cameraRef.current.position.set(
        playerRef.current.position.x,
        playerRef.current.position.y + 1.7,
        playerRef.current.position.z
      );
      cameraRef.current.rotation.order = 'YXZ';
      cameraRef.current.rotation.y = playerRef.current.angle;
      cameraRef.current.rotation.x = playerRef.current.pitch;
    }

    // ボット更新
    botsRef.current.forEach(bot => {
      bot.x += bot.vx;
      bot.z += bot.vz;

      if (Math.abs(bot.x) > 350 || Math.abs(bot.z) > 350) {
        bot.vx *= -1;
        bot.vz *= -1;
      }

      bot.mesh.position.set(bot.x, bot.y, bot.z);
    });

    // 弾更新
    bulletsRef.current = bulletsRef.current.filter(bullet => {
      bullet.x += bullet.vx * 0.016;
      bullet.y += bullet.vy * 0.016;
      bullet.z += bullet.vz * 0.016;
      bullet.life--;

      botsRef.current.forEach(bot => {
        const dx = bullet.x - bot.x;
        const dy = bullet.y - bot.y;
        const dz = bullet.z - bot.z;
        const dist = Math.sqrt(dx * dx + dy * dy + dz * dz);

        if (dist < 3) {
          bot.health -= 25;
          bullet.life = 0;

          if (bot.health <= 0) {
            playerRef.current.kills++;
            playerRef.current.score += 100;
            setGameUI(prev => ({
              ...prev,
              kills: playerRef.current.kills,
              score: playerRef.current.score,
            }));

            bot.health = 100;
            bot.x = (Math.random() - 0.5) * 300;
            bot.z = (Math.random() - 0.5) * 300;
          }
        }
      });

      return bullet.life > 0;
    });
  };

  useEffect(() => {
    return () => {
      if (gameLoopRef.current) {
        cancelAnimationFrame(gameLoopRef.current);
      }
    };
  }, []);

  return (
    <div style={{ width: '100vw', height: '100vh', overflow: 'hidden', background: '#000' }}>
      {gameUI.gameState === 'login' && (
        <div
          style={{
            position: 'absolute',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 100,
            flexDirection: 'column',
          }}
        >
          <h1 style={{ fontSize: '4em', color: '#fff', marginBottom: '20px', fontWeight: 'bold' }}>
            🎮 FORTNITE FPS
          </h1>
          <p style={{ fontSize: '1.5em', color: '#fff', marginBottom: '40px' }}>3D FPS Battle Royale</p>

          <input
            type="text"
            value={playerName}
            onChange={(e) => setPlayerName(e.target.value)}
            placeholder="プレイヤー名"
            onKeyPress={(e) => e.key === 'Enter' && startGame()}
            style={{
              padding: '15px',
              fontSize: '1.1em',
              width: '300px',
              marginBottom: '20px',
              border: 'none',
              borderRadius: '5px',
            }}
          />

          <button
            onClick={startGame}
            style={{
              padding: '15px 50px',
              fontSize: '1.3em',
              background: '#ff6b6b',
              color: '#fff',
              border: 'none',
              borderRadius: '5px',
              cursor: 'pointer',
              fontWeight: 'bold',
            }}
          >
            START
          </button>
        </div>
      )}

      {gameUI.gameState === 'playing' && (
        <>
          <div ref={containerRef} style={{ width: '100%', height: '100%' }} />

          <div style={{ position: 'absolute', top: '20px', left: '20px', background: 'rgba(0,0,0,0.7)', color: '#fff', padding: '20px', borderRadius: '10px', fontFamily: 'monospace', fontSize: '1.2em' }}>
            <div>❤️ Health: {gameUI.health}</div>
            <div>🔫 Ammo: {gameUI.ammo}</div>
            <div>👥 Online: {gameUI.online}</div>
          </div>

          <div style={{ position: 'absolute', top: '20px', right: '20px', background: 'rgba(0,0,0,0.7)', color: '#fff', padding: '20px', borderRadius: '10px', fontFamily: 'monospace', fontSize: '1.2em' }}>
            <div>⚔️ Kills: {gameUI.kills}</div>
            <div>💀 Deaths: {gameUI.deaths}</div>
            <div>⭐ Score: {gameUI.score}</div>
          </div>

          <div style={{ position: 'absolute', bottom: '20px', left: '50%', transform: 'translateX(-50%)', background: 'rgba(0,0,0,0.7)', color: '#fff', padding: '15px 30px', borderRadius: '10px', textAlign: 'center', fontSize: '1em' }}>
            WASD: 移動 | SPACE: ジャンプ | クリック: 射撃 | R: リロード | マウス: 視点変更
          </div>

          <div style={{ position: 'absolute', left: '50%', top: '50%', transform: 'translate(-50%, -50%)', width: '25px', height: '25px', border: '2px solid lime', borderRadius: '50%', pointerEvents: 'none', boxShadow: '0 0 10px lime' }} />
        </>
      )}
    </div>
  );
};

export default FortniteFPS;
