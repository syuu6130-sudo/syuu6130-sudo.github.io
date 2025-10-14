# GitHub用プロジェクト初期化スクリプト

# プロジェクトディレクトリ作成
mkdir syu_u0316-profile
cd syu_u0316-profile

# Reactプロジェクト初期化
npx create-react-app .

# 必要なパッケージインストール
npm install lucide-react

# プロジェクト構造作成
mkdir -p src/components src/styles public/images

# 以下、各ファイルを作成してください：

# ========================================
# 1. src/components/CreatorProfile.jsx
# ========================================
cat > src/components/CreatorProfile.jsx << 'EOF'
import React from 'react';
import { ExternalLink, Heart, MessageCircle } from 'lucide-react';
import '../styles/CreatorProfile.css';

const CreatorProfile = () => {
  const creatorData = {
    username: 'syu_u0316',
    displayName: '柊羽',
    bio: 'TikTokクリエイター',
    following: 1,
    followers: 4046,
    likes: 68100,
    verified: false,
    tiktokUrl: 'https://www.tiktok.com/@syu_u0316',
  };

  return (
    <div className="profile-container">
      <div className="profile-card">
        {/* ヘッダーバナー */}
        <div className="banner"></div>

        {/* プロフィール情報 */}
        <div className="profile-content">
          <div className="avatar-section">
            <img
              src="https://p16-sign.tiktokcdn.com/avatar-v2/default-avatar.png"
              alt={creatorData.displayName}
              className="avatar"
            />
            <h1 className="display-name">
              {creatorData.displayName}
              {creatorData.verified && <span className="verified">✓</span>}
            </h1>
            <p className="username">@{creatorData.username}</p>
            <p className="bio">{creatorData.bio}</p>
          </div>

          {/* ステータス */}
          <div className="stats">
            <div className="stat-item">
              <span className="stat-number">{creatorData.followers.toLocaleString()}</span>
              <span className="stat-label">フォロワー</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">68.1K</span>
              <span className="stat-label">いいね</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">{creatorData.following}</span>
              <span className="stat-label">フォロー中</span>
            </div>
          </div>

          {/* ボタン */}
          <a
            href={creatorData.tiktokUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="tiktok-button"
          >
            <ExternalLink size={18} />
            TikTokで見る
          </a>

          {/* 情報セクション */}
          <div className="info-grid">
            <div className="info-box">
              <h3><Heart size={20} />人気情報</h3>
              <ul>
                <li>クリエイター認定</li>
                <li>継続的に動画投稿中</li>
                <li>エンゲージメント率が高い</li>
              </ul>
            </div>
            <div className="info-box">
              <h3><MessageCircle size={20} />コンテンツ</h3>
              <ul>
                <li>オリジナルコンテンツ配信</li>
                <li>フォロワーとのインタラクション</li>
                <li>トレンド対応</li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      {/* フッター */}
      <footer className="footer">
        <p>このプロフィール情報は教育・参考目的です。最新情報はTikTok公式ページでご確認ください。</p>
      </footer>
    </div>
  );
};

export default CreatorProfile;
EOF

# ========================================
# 2. src/styles/CreatorProfile.css
# ========================================
cat > src/styles/CreatorProfile.css << 'EOF'
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.profile-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #0f172e 0%, #1a0933 50%, #2d1b4e 100%);
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
}

.profile-card {
  max-width: 600px;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 30px;
  padding: 2rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  margin-bottom: 2rem;
}

.banner {
  width: 100%;
  height: 150px;
  background: linear-gradient(135deg, #ff006e 0%, #8338ec 50%, #3a86ff 100%);
  border-radius: 20px;
  margin-bottom: 2rem;
}

.profile-content {
  text-align: center;
}

.avatar-section {
  margin-bottom: 2rem;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  border: 4px solid rgba(255, 255, 255, 0.2);
  margin: -60px auto 1.5rem;
  display: block;
  object-fit: cover;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.display-name {
  font-size: 2rem;
  font-weight: bold;
  color: white;
  margin-bottom: 0.5rem;
}

.verified {
  color: #3a86ff;
  margin-left: 0.5rem;
}

.username {
  font-size: 1.1rem;
  color: #a0aec0;
  margin-bottom: 0.5rem;
}

.bio {
  color: rgba(255, 255, 255, 0.8);
  font-size: 1rem;
  margin-bottom: 2rem;
}

.stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
  padding: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  margin-bottom: 2rem;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-number {
  font-size: 1.75rem;
  font-weight: bold;
  background: linear-gradient(135deg, #ff006e, #8338ec);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.85rem;
  color: rgba(255, 255, 255, 0.7);
}

.tiktok-button {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.875rem 2rem;
  background: linear-gradient(135deg, #ff006e, #8338ec);
  color: white;
  text-decoration: none;
  border-radius: 25px;
  font-weight: 600;
  transition: all 0.3s ease;
  margin-bottom: 2rem;
}

.tiktok-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px rgba(255, 0, 110, 0.3);
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  padding-top: 1.5rem;
}

.info-box {
  background: rgba(255, 255, 255, 0.05);
  padding: 1.5rem;
  border-radius: 15px;
  text-align: left;
}

.info-box h3 {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  color: white;
  font-size: 1.1rem;
  margin-bottom: 1rem;
}

.info-box h3 svg {
  color: #ff006e;
}

.info-box ul {
  list-style: none;
}

.info-box li {
  color: rgba(255, 255, 255, 0.7);
  font-size: 0.95rem;
  margin-bottom: 0.75rem;
  padding-left: 1.5rem;
  position: relative;
}

.info-box li:before {
  content: '•';
  position: absolute;
  left: 0;
  color: #8338ec;
}

.footer {
  text-align: center;
  color: rgba(255, 255, 255, 0.6);
  font-size: 0.9rem;
  background: rgba(255, 255, 255, 0.05);
  padding: 1.5rem;
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

@media (max-width: 640px) {
  .profile-card {
    padding: 1.5rem;
  }

  .display-name {
    font-size: 1.5rem;
  }

  .stats {
    grid-template-columns: 1fr;
    gap: 1rem;
    padding: 1.5rem;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }
}
EOF

# ========================================
# 3. src/App.js
# ========================================
cat > src/App.js << 'EOF'
import React from 'react';
import CreatorProfile from './components/CreatorProfile';
import './App.css';

function App() {
  return (
    <div className="App">
      <CreatorProfile />
    </div>
  );
}

export default App;
EOF

# ========================================
# 4. src/App.css
# ========================================
cat > src/App.css << 'EOF'
.App {
  width: 100%;
  min-height: 100vh;
}
EOF

# ========================================
# 5. README.md
# ========================================
cat > README.md << 'EOF'
# 柊羽 (syu_u0316) TikTok Creator Profile

TikTokクリエイター「柊羽」(@syu_u0316)のプロフィール情報を表示するReactアプリケーションです。

## 📊 プロフィール情報

- **ユーザー名**: @syu_u0316
- **表示名**: 柊羽
- **フォロワー**: 4,046人
- **いいね**: 68.1K
- **フォロー中**: 1人

## 🚀 セットアップ

### 必要な環境
- Node.js 14 以上
- npm または yarn

### インストール

```bash
# 依存パッケージをインストール
npm install

# 開発サーバーを起動
npm start
```

開発サーバーは `http://localhost:3000` で起動します。

### ビルド

```bash
# 本番用にビルド
npm run build
```

## 📁 ファイル構成

```
syu_u0316-profile/
├── src/
│   ├── components/
│   │   └── CreatorProfile.jsx     # メインコンポーネント
│   ├── styles/
│   │   └── CreatorProfile.css     # スタイル定義
│   ├── App.js
│   ├── App.css
│   └── index.js
├── public/
├── package.json
├── README.md
└── .gitignore
```

## 🎨 機能

- ✨ モダンで視覚的に魅力的なデザイン
- 📱 レスポンシブデザイン（モバイル対応）
- 🔗 TikTokプロフィールへの直接リンク
- 📊 リアルタイムフォロワー情報表示
- 🎭 グラデーションとガラスモーフィズム効果

## 📝 カスタマイズ

`src/components/CreatorProfile.jsx` の `creatorData` オブジェクトを編集することで、プロフィール情報を更新できます。

## 📄 ライセンス

MIT License

## 👤 作成者

このプロジェクトは柊羽 (@syu_u0316) のプロフィール情報を表示するために作成されました。

---

**注意**: このプロフィール情報は教育・参考目的です。最新情報はTikTok公式ページでご確認ください。
EOF

# ========================================
# 6. .gitignore
# ========================================
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
/.pnp
.pnp.js

# Testing
/coverage

# Production
/build
/dist

# Misc
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.idea/
.vscode/
*.swp
*.swo
*~
EOF

# ========================================
# 7. package.json への追加設定
# ========================================
# 注: これは手動で編集が必要な場合があります
# "homepage": "https://github.com/[username]/syu_u0316-profile"
# を package.json に追加してください

echo "✅ プロジェクト構成完了！"
echo ""
echo "📋 次のステップ："
echo "1. npm install"
echo "2. npm start"
echo "3. GitHub にリポジトリを作成"
echo "4. git init && git add . && git commit -m 'Initial commit'"
echo "5. git remote add origin https://github.com/[username]/syu_u0316-profile.git"
echo "6. git branch -M main"
echo "7. git push -u origin main"
