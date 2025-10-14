import { useState } from 'react';
import { Heart } from 'lucide-react';

export default function LikeButton() {
  const [likes, setLikes] = useState(0);
  const [isLiked, setIsLiked] = useState(false);

  const handleLike = () => {
    if (isLiked) {
      setLikes(likes - 1);
      setIsLiked(false);
    } else {
      setLikes(likes + 1);
      setIsLiked(true);
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="bg-white rounded-lg shadow-lg p-8 w-full max-w-md">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-800 mb-4">TikTok投稿</h1>
          <div className="bg-gray-200 rounded-lg h-64 flex items-center justify-center mb-6">
            <p className="text-gray-500">画像がここに表示されます</p>
          </div>
          
          <div className="mb-8">
            <p className="text-gray-700 mb-4">投稿内容がここに表示されます</p>
            <p className="text-sm text-gray-500 mb-4">@syu_u0316</p>
          </div>

          <div className="flex items-center justify-center gap-4">
            <button
              onClick={handleLike}
              className={`flex items-center gap-2 px-6 py-3 rounded-full font-semibold transition-all duration-200 transform ${
                isLiked
                  ? 'bg-red-500 text-white scale-110'
                  : 'bg-gray-200 text-gray-800 hover:bg-gray-300'
              }`}
            >
              <Heart
                size={24}
                fill={isLiked ? 'currentColor' : 'none'}
              />
              いいね
            </button>
          </div>

          <div className="mt-6 text-2xl font-bold text-gray-800">
            <p className="text-red-500">{likes.toLocaleString()}件のいいね</p>
          </div>
        </div>
      </div>
    </div>
  );
}
