<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>After Effects風 3Dアニメーション</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            overflow: hidden;
            background: #000;
            font-family: 'Arial Black', sans-serif;
        }
        #container {
            width: 100vw;
            height: 100vh;
        }
        #controls {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 100;
            color: white;
            background: rgba(0,0,0,0.7);
            padding: 15px;
            border-radius: 10px;
            font-size: 14px;
        }
        button {
            background: #ff0080;
            border: none;
            color: white;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            background: #ff33a0;
        }
    </style>
</head>
<body>
    <div id="container"></div>
    <div id="controls">
        <div>After Effects風 3Dアニメーション</div>
        <button onclick="restartAnimation()">アニメーション再生</button>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script>
        let scene, camera, renderer, time = 0;
        let textMeshes = [], particles = [], shapes = [];
        let animationPhase = 0;

        function init() {
            scene = new THREE.Scene();
            scene.fog = new THREE.Fog(0x000000, 10, 100);

            camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
            camera.position.z = 30;

            renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
            renderer.setSize(window.innerWidth, window.innerHeight);
            renderer.setClearColor(0x000000);
            document.getElementById('container').appendChild(renderer.domElement);

            // ライティング
            const ambientLight = new THREE.AmbientLight(0xffffff, 0.3);
            scene.add(ambientLight);

            const pointLight1 = new THREE.PointLight(0xff0080, 2, 100);
            pointLight1.position.set(10, 10, 10);
            scene.add(pointLight1);

            const pointLight2 = new THREE.PointLight(0x00ffff, 2, 100);
            pointLight2.position.set(-10, -10, 10);
            scene.add(pointLight2);

            const pointLight3 = new THREE.PointLight(0xffff00, 1.5, 100);
            pointLight3.position.set(0, 0, -10);
            scene.add(pointLight3);

            createTextElements();
            createParticles();
            createShapes();

            window.addEventListener('resize', onWindowResize);
            animate();
        }

        function createTextElements() {
            const texts = ['CREATIVE', '3D', 'MOTION', 'DESIGN'];
            const colors = [0xff0080, 0x00ffff, 0xffff00, 0xff3366];

            texts.forEach((text, i) => {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.width = 1024;
                canvas.height = 256;

                ctx.fillStyle = '#000';
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                
                const gradient = ctx.createLinearGradient(0, 0, canvas.width, 0);
                gradient.addColorStop(0, `#${colors[i].toString(16).padStart(6, '0')}`);
                gradient.addColorStop(1, '#ffffff');
                ctx.fillStyle = gradient;
                ctx.font = 'bold 120px Arial Black';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                ctx.fillText(text, canvas.width / 2, canvas.height / 2);

                const texture = new THREE.CanvasTexture(canvas);
                const material = new THREE.MeshPhongMaterial({
                    map: texture,
                    transparent: true,
                    side: THREE.DoubleSide,
                    emissive: colors[i],
                    emissiveIntensity: 0.3
                });

                const geometry = new THREE.PlaneGeometry(15, 4);
                const mesh = new THREE.Mesh(geometry, material);
                
                mesh.position.set(
                    (Math.random() - 0.5) * 40,
                    (Math.random() - 0.5) * 20,
                    (Math.random() - 0.5) * 30 - 50
                );
                mesh.userData.initialPos = mesh.position.clone();
                mesh.userData.targetPos = new THREE.Vector3(0, (i - 1.5) * 6, 0);
                mesh.userData.phase = i * 0.5;

                scene.add(mesh);
                textMeshes.push(mesh);
            });
        }

        function createParticles() {
            const geometry = new THREE.BufferGeometry();
            const positions = [];
            const colors = [];
            const sizes = [];

            for (let i = 0; i < 2000; i++) {
                positions.push(
                    (Math.random() - 0.5) * 100,
                    (Math.random() - 0.5) * 100,
                    (Math.random() - 0.5) * 100
                );

                const color = new THREE.Color();
                color.setHSL(Math.random(), 1.0, 0.5);
                colors.push(color.r, color.g, color.b);
                sizes.push(Math.random() * 2 + 1);
            }

            geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));
            geometry.setAttribute('color', new THREE.Float32BufferAttribute(colors, 3));
            geometry.setAttribute('size', new THREE.Float32BufferAttribute(sizes, 1));

            const material = new THREE.PointsMaterial({
                size: 0.5,
                vertexColors: true,
                transparent: true,
                opacity: 0.8,
                blending: THREE.AdditiveBlending
            });

            const particleSystem = new THREE.Points(geometry, material);
            scene.add(particleSystem);
            particles.push(particleSystem);
        }

        function createShapes() {
            const geometries = [
                new THREE.BoxGeometry(3, 3, 3),
                new THREE.SphereGeometry(2, 32, 32),
                new THREE.ConeGeometry(2, 4, 32),
                new THREE.TorusGeometry(2, 0.5, 16, 100)
            ];

            const colors = [0xff0080, 0x00ffff, 0xffff00, 0xff3366, 0x00ff00, 0xff6600];

            for (let i = 0; i < 15; i++) {
                const geometry = geometries[Math.floor(Math.random() * geometries.length)];
                const material = new THREE.MeshPhongMaterial({
                    color: colors[Math.floor(Math.random() * colors.length)],
                    emissive: colors[Math.floor(Math.random() * colors.length)],
                    emissiveIntensity: 0.5,
                    shininess: 100,
                    transparent: true,
                    opacity: 0.7
                });

                const mesh = new THREE.Mesh(geometry, material);
                mesh.position.set(
                    (Math.random() - 0.5) * 80,
                    (Math.random() - 0.5) * 80,
                    (Math.random() - 0.5) * 80
                );
                mesh.userData.rotationSpeed = new THREE.Vector3(
                    (Math.random() - 0.5) * 0.02,
                    (Math.random() - 0.5) * 0.02,
                    (Math.random() - 0.5) * 0.02
                );
                mesh.userData.initialPos = mesh.position.clone();

                scene.add(mesh);
                shapes.push(mesh);
            }
        }

        function animate() {
            requestAnimationFrame(animate);
            time += 0.01;

            // カメラアニメーション（After Effects風）
            const cameraRadius = 35;
            const cameraSpeed = time * 0.3;
            camera.position.x = Math.sin(cameraSpeed) * cameraRadius * Math.cos(time * 0.2);
            camera.position.y = Math.sin(time * 0.4) * 15 + Math.cos(time * 0.15) * 10;
            camera.position.z = Math.cos(cameraSpeed) * cameraRadius + 10;
            camera.lookAt(0, 0, 0);

            // FOVアニメーション
            camera.fov = 75 + Math.sin(time * 0.5) * 15;
            camera.updateProjectionMatrix();

            // テキストアニメーション
            textMeshes.forEach((mesh, i) => {
                const phase = (time - mesh.userData.phase) * 2;
                
                if (phase > 0 && phase < 2) {
                    const t = Math.min(1, phase);
                    const eased = 1 - Math.pow(1 - t, 3);
                    mesh.position.lerpVectors(mesh.userData.initialPos, mesh.userData.targetPos, eased);
                    mesh.material.opacity = eased;
                } else if (phase >= 2) {
                    mesh.position.copy(mesh.userData.targetPos);
                    mesh.material.opacity = 1;
                }

                mesh.rotation.y = Math.sin(time + i) * 0.2;
                mesh.rotation.x = Math.cos(time * 0.7 + i) * 0.1;
                mesh.position.z += Math.sin(time * 2 + i) * 0.01;
            });

            // パーティクルアニメーション
            particles.forEach(p => {
                p.rotation.y = time * 0.05;
                p.rotation.x = time * 0.03;
                const positions = p.geometry.attributes.position.array;
                for (let i = 0; i < positions.length; i += 3) {
                    positions[i + 1] += Math.sin(time + positions[i]) * 0.02;
                }
                p.geometry.attributes.position.needsUpdate = true;
            });

            // 形状アニメーション
            shapes.forEach((shape, i) => {
                shape.rotation.x += shape.userData.rotationSpeed.x;
                shape.rotation.y += shape.userData.rotationSpeed.y;
                shape.rotation.z += shape.userData.rotationSpeed.z;

                const offset = time * 0.5 + i * 0.5;
                shape.position.x = shape.userData.initialPos.x + Math.sin(offset) * 5;
                shape.position.y = shape.userData.initialPos.y + Math.cos(offset * 1.3) * 5;
                shape.position.z = shape.userData.initialPos.z + Math.sin(offset * 0.7) * 5;

                shape.scale.setScalar(1 + Math.sin(time * 2 + i) * 0.2);
            });

            renderer.render(scene, camera);
        }

        function restartAnimation() {
            time = 0;
            textMeshes.forEach(mesh => {
                mesh.position.copy(mesh.userData.initialPos);
                mesh.material.opacity = 0;
            });
        }

        function onWindowResize() {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        }

        init();
    </script>
</body>
</html>
