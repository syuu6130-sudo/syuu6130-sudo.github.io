import React, { useState, useEffect } from 'react';
import { ExternalLink, Heart, MessageCircle, Share2 } from 'lucide-react';

export default function CreatorProfile() {
  const [creatorData, setCreatorData] = useState({
    username: 'syu_u0316',
    displayName: '柊羽',
    bio: 'TikTokクリエイター',
    following: 1,
    followers: 4046,
    likes: 68100,
    avatar: 'https://p16-sign.tiktokcdn.com/avatar-v2/default-avatar.png?x-expires=1729097400&x-signature=xyz',
    verified: false,
    tiktokUrl: 'https://www.tiktok.com/@syu_u0316',
    recentVideos: []
  });

  // TikTok APIから情報を取得する関数（認証が必要）
  const fetchCreatorData = async () => {
    try {
      // 注：実際のAPIを使用するにはTikTok Developer Platformでの認証が必要
      // このコードはプレースホルダーです
      
      // const response = await fetch('/api/tiktok/creator', {
      //   method: 'POST',
      //   headers: { 'Content-Type': 'application/json' },
      //   body: JSON.stringify({ username: 'syu_u0316' })
      // });
      // const data = await response.json();
      // setCreatorData(data);
      
    } catch (error) {
      console.error('データ取得エラー:', error);
    }
  };

  useEffect(() => {
    fetchCreatorData();
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 p-4 md:p-8">
      <div className="max-w-2xl mx-auto">
        {/* プロフィールカード */}
        <div className="bg-white/10 backdrop-blur-md rounded-3xl p-8 mb-8 border border-white/20 shadow-2xl">
          {/* ヘッダーバナー */}
          <div className="w-full h-32 bg-gradient-to-r from-pink-500 to-purple-500 rounded-2xl mb-8 relative"></div>

          {/* アバターと基本情報 */}
          <div className="flex flex-col items-center -mt-16 mb-6">
            <img
              src={creatorData.avatar}
              alt={creatorData.displayName}
              className="w-32 h-32 rounded-full border-4 border-white/20 shadow-lg mb-4 object-cover"
            />
            <div className="text-center">
              <h1 className="text-3xl font-bold text-white mb-2">
                {creatorData.displayName}
                {creatorData.verified && <span className="ml-2">✓</span>}
              </h1>
              <p className="text-purple-300 text-lg mb-3">@{creatorData.username}</p>
              <p className="text-white/80 mb-6">{creatorData.bio}</p>
            </div>
          </div>

          {/* ステータス */}
          <div className="grid grid-cols-3 gap-4 mb-8 py-6 border-y border-white/10">
            <div className="text-center">
              <div className="text-2xl font-bold text-pink-400 mb-1">
                {creatorData.followers.toLocaleString()}
              </div>
              <div className="text-white/70 text-sm">フォロワー</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-purple-400 mb-1">
                68.1K
              </div>
              <div className="text-white/70 text-sm">いいね</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-blue-400 mb-1">
                {creatorData.following}
              </div>
              <div className="text-white/70 text-sm">フォロー中</div>
            </div>
          </div>

          {/* アクションボタン */}
          <div className="flex gap-3 justify-center mb-6">
            <a
              href={creatorData.tiktokUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-pink-500 to-purple-500 text-white font-semibold rounded-full hover:shadow-lg hover:scale-105 transition-all"
            >
              <ExternalLink size={18} />
              TikTokで見る
            </a>
          </div>

          {/* 情報セクション */}
          <div className="grid md:grid-cols-2 gap-6 mt-8 p-6 bg-white/5 rounded-2xl">
            <div>
              <h3 className="text-white font-semibold mb-3 flex items-center gap-2">
                <Heart size={20} className="text-pink-400" />
                人気情報
              </h3>
              <ul className="text-white/80 text-sm space-y-2">
                <li>• クリエイター認定</li>
                <li>• 継続的に動画投稿中</li>
                <li>• エンゲージメント率が高い</li>
              </ul>
            </div>
            <div>
              <h3 className="text-white font-semibold mb-3 flex items-center gap-2">
                <MessageCircle size={20} className="text-purple-400" />
                コンテンツ
              </h3>
              <ul className="text-white/80 text-sm space-y-2">
                <li>• オリジナルコンテンツ配信</li>
                <li>• フォロワーとのインタラクション</li>
                <li>• トレンド対応</li>
              </ul>
            </div>
          </div>
        </div>

        {/* 免責事項 */}
        <div className="bg-white/5 border border-white/10 rounded-2xl p-4 text-white/60 text-sm text-center">
          <p>このプロフィール情報は教育・参考目的です。最新情報はTikTok公式ページでご確認ください。</p>
        </div>
      </div>
    </div>
  );
}
