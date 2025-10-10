# syuu6130-sudo.github.io
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zombie Survival FPS - 無料オンラインゲーム</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            color: white;
            overflow-x: hidden;
        }

        .header {
            background: rgba(0, 0, 0, 0.8);
            padding: 20px 0;
            border-bottom: 3px solid #00ff88;
            box-shadow: 0 4px 20px rgba(0, 255, 136, 0.3);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo {
            font-size: 2.5em;
            font-weight: bold;
            background: linear-gradient(45deg, #00ff88, #00d4ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin-bottom: 10px;
        }

        .tagline {
            text-align: center;
            color: #00ff88;
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .hero {
            padding: 60px 20px;
            text-align: center;
        }

        .hero h1 {
            font-size: 3em;
            margin-bottom: 20px;
            text-shadow: 0 0 20px rgba(0, 255, 136, 0.5);
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: 0 0 20px rgba(0, 255, 136, 0.5); }
            to { text-shadow: 0 0 30px rgba(0, 255, 136, 0.8), 0 0 40px rgba(0, 212, 255, 0.5); }
        }

        .hero p {
            font-size: 1.3em;
            margin-bottom: 40px;
            color: #aaa;
        }

        .play-button {
            display: inline-block;
            padding: 20px 60px;
            font-size: 1.5em;
            font-weight: bold;
            background: linear-gradient(45deg, #ff0000, #ff6600);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            box-shadow: 0 8px 30px rgba(255, 0, 0, 0.4);
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .play-button:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 40px rgba(255, 0, 0, 0.6);
        }

        .features {
            padding: 60px 20px;
            background: rgba(0, 0, 0, 0.3);
        }

        .features h2 {
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 50px;
            color: #00ff88;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.05);
            padding: 30px;
            border-radius: 15px;
            border: 2px solid rgba(0, 255, 136, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            border-color: #00ff88;
            box-shadow: 0 10px 40px rgba(0, 255, 136, 0.3);
        }

        .feature-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }

        .feature-card h3 {
            font-size: 1.5em;
            margin-bottom: 15px;
            color: #00d4ff;
        }

        .feature-card p {
            color: #ccc;
            line-height: 1.6;
        }

        .screenshots {
            padding: 60px 20px;
        }

        .screenshots h2 {
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 50px;
            color: #00ff88;
        }

        .screenshot-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .screenshot {
            background: linear-gradient(135deg, #2a2a2a 0%, #1a1a1a 100%);
            border-radius: 15px;
            padding: 20px;
            border: 2px solid rgba(0, 255, 136, 0.3);
            text-align: center;
            transition: all 0.3s ease;
        }

        .screenshot:hover {
            transform: scale(1.05);
            border-color: #00ff88;
        }

        .screenshot-placeholder {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #1a1a1a 0%, #0a0a0a 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3em;
            margin-bottom: 15px;
        }

        .controls {
            padding: 60px 20px;
            background: rgba(0, 0, 0, 0.3);
        }

        .controls h2 {
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 50px;
            color: #00ff88;
        }

        .controls-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .control-item {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 10px;
            border: 2px solid rgba(0, 212, 255, 0.3);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .control-key {
            background: linear-gradient(135deg, #333 0%, #111 100%);
            padding: 15px 20px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1.2em;
            border: 2px solid #00d4ff;
            min-width: 80px;
            text-align: center;
        }

        .control-desc {
            color: #ccc;
        }

        .footer {
            background: rgba(0, 0, 0, 0.8);
            padding: 40px 20px;
            text-align: center;
            border-top: 3px solid #00ff88;
            margin-top: 60px;
        }

        .footer p {
            color: #888;
            margin-bottom: 10px;
        }

        .stats {
            display: flex;
            justify-content: center;
            gap: 50px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 3em;
            font-weight: bold;
            background: linear-gradient(45deg, #ff0000, #ff6600);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: #888;
            margin-top: 10px;
        }

        #game-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.95);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        #game-modal.active {
            display: flex;
        }

        .modal-content {
            text-align: center;
            padding: 40px;
        }

        .modal-content h2 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #00ff88;
        }

        .modal-content p {
            font-size: 1.2em;
            margin-bottom: 30px;
            color: #ccc;
        }

        .close-button {
            padding: 15px 40px;
            font-size: 1.2em;
            background: #ff0000;
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .close-button:hover {
            background: #ff3333;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2em;
            }
            
            .logo {
                font-size: 1.8em;
            }

            .play-button {
                padding: 15px 40px;
                font-size: 1.2em;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="logo">🧟 ZOMBIE SURVIVAL FPS</div>
            <div class="tagline">究極のゾンビサバイバル体験</div>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <h1>🎮 今すぐプレイ！</h1>
            <p>ブラウザで遊べる本格FPSゲーム。ゾンビの大群から生き残れ！</p>
            <button class="play-button" onclick="startGame()">▶ ゲームを開始</button>
            
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">無料</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3D</div>
                    <div class="stat-label">グラフィック</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">∞</div>
                    <div class="stat-label">ウェーブ</div>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <h2>✨ ゲームの特徴</h2>
            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h3>リアルな3D体験</h3>
                    <p>Three.jsを使用した美しい3Dグラフィックで、没入感のあるゲームプレイを実現</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🧟</div>
                    <h3>エンドレスモード</h3>
                    <p>どこまで生き残れるか挑戦！ウェーブごとに難易度が上昇し、強力なゾンビが出現</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚙️</div>
                    <h3>カスタマイズ可能</h3>
                    <p>感度、明るさ、クロスヘア、FOVなど細かい設定が可能。自分好みの環境でプレイ</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔫</div>
                    <h3>多彩な機能</h3>
                    <p>オートエイム、オート射撃など、初心者から上級者まで楽しめる機能を搭載</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🌍</div>
                    <h3>広大なマップ</h3>
                    <p>建物、遮蔽物、コンテナなど戦略的に配置されたマップで戦術的なプレイが可能</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">💻</div>
                    <h3>ブラウザで即プレイ</h3>
                    <p>ダウンロード不要！対応ブラウザで今すぐプレイ可能。インストール一切不要</p>
                </div>
            </div>
        </div>
    </section>

    <section class="screenshots">
        <div class="container">
            <h2>📸 ゲーム画面</h2>
            <div class="screenshot-grid">
                <div class="screenshot">
                    <div class="screenshot-placeholder">🎮</div>
                    <p>迫力の戦闘シーン</p>
                </div>
                <div class="screenshot">
                    <div class="screenshot-placeholder">🏙️</div>
                    <p>広大な3Dマップ</p>
                </div>
                <div class="screenshot">
                    <div class="screenshot-placeholder">🧟</div>
                    <p>恐怖のゾンビ軍団</p>
                </div>
            </div>
        </div>
    </section>

    <section class="controls">
        <div class="container">
            <h2>🎮 操作方法</h2>
            <div class="controls-grid">
                <div class="control-item">
                    <div class="control-key">W A S D</div>
                    <div class="control-desc">キャラクター移動</div>
                </div>
                <div class="control-item">
                    <div class="control-key">マウス</div>
                    <div class="control-desc">視点変更・照準</div>
                </div>
                <div class="control-item">
                    <div class="control-key">クリック</div>
                    <div class="control-desc">射撃（長押しで連射）</div>
                </div>
                <div class="control-item">
                    <div class="control-key">SPACE</div>
                    <div class="control-desc">ジャンプ</div>
                </div>
                <div class="control-item">
                    <div class="control-key">R</div>
                    <div class="control-desc">リロード</div>
                </div>
                <div class="control-item">
                    <div class="control-key">ESC</div>
                    <div class="control-desc">設定メニュー</div>
                </div>
            </div>
        </div>
    </section>

    <section class="hero" style="padding-top: 40px;">
        <div class="container">
            <h1>準備はいいか？</h1>
            <p>ゾンビの大群があなたを待っている...</p>
            <button class="play-button" onclick="startGame()">▶ 今すぐプレイ</button>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <p>🧟 Zombie Survival FPS - ブラウザで遊べる無料3Dゲーム</p>
            <p style="font-size: 0.9em; margin-top: 20px;">© 2025 Zombie Survival FPS. All rights reserved.</p>
            <p style="font-size: 0.8em; color: #666; margin-top: 10px;">
                ⚠️ このゲームには暴力的な表現が含まれます。18歳未満の方は保護者の同意を得てプレイしてください。
            </p>
        </div>
    </footer>

    <div id="game-modal">
        <div class="modal-content">
            <h2>🚀 ゲームを起動中...</h2>
            <p>ゲームは別のアーティファクトとして表示されます</p>
            <p style="color: #00ff88; margin-top: 20px;">Claude.aiの右側にゲーム画面が表示されます！</p>
            <button class="close-button" onclick="closeModal()">✓ 理解しました</button>
        </div>
    </div>

    <script>
        function startGame() {
            const modal = document.getElementById('game-modal');
            modal.classList.add('active');
            
            setTimeout(() => {
                modal.classList.remove('active');
            }, 4000);
        }

        function closeModal() {
            const modal = document.getElementById('game-modal');
            modal.classList.remove('active');
        }

        // スムーススクロール
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
    </script>
</body>
</html>
