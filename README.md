<html>
<head>
<style>
body {
  margin: 0;
  padding: 20px;
  font-family: Arial;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.container {
  background: white;
  border-radius: 16px;
  padding: 40px;
  max-width: 500px;
  box-shadow: 0 10px 40px rgba(0,0,0,0.2);
}

.header {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
}

.avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.image {
  width: 100%;
  height: 300px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px 0;
  overflow: hidden;
}

.image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.btn {
  border: none;
  background: none;
  cursor: pointer;
  padding: 10px 20px;
  font-size: 16px;
  color: #666;
  margin: 10px 5px;
  border-radius: 8px;
}

.btn:hover {
  background: #f0f0f0;
}

.btn.liked {
  color: #e74c3c;
  animation: beat 0.3s ease;
}

.actions {
  border-top: 1px solid #eee;
  border-bottom: 1px solid #eee;
  padding: 20px 0;
  margin: 30px 0;
  text-align: center;
}

.count {
  text-align: center;
  margin-top: 30px;
  font-size: 32px;
  color: #e74c3c;
  font-weight: bold;
}

@keyframes beat {
  0% { transform: scale(1); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}
</style>
</head>
<body>

<div class="container">
  <div class="header">
    <div class="avatar"><img src="https://p16-sign-sg.tiktokcdn.com/tos-alisg-avt-0068/550ffa3db40678d1b57c8e6a19a7eaa1~tplv-tiktokx-cropcenter:100:100.jpeg?dr=14579&refresh_token=2fe07fed&x-expires=1760580000&x-signature=mYVWUCGPGY2n6%2FPvxfG2dsjs8Ug%3D&t=4d5b0474&ps=13740610&shp=a5d48078&shcp=81f88b70&idc=my" alt="avatar"></div>
    <div>
      <h2 style="margin:0">柊羽</h2>
      <p style="margin:4px 0 0 0;color:#666;font-size:13px">@syu_u0316</p>
    </div>
  </div>
  
  <div class="image"><img src="https://via.placeholder.com/500x300/667eea/764ba2?text=投稿画像" alt="post-image"></div>
  
  <div style="margin:20px 0;color:#333">
    <p>素敵な時間を過ごしています</p>
    <a href="https://www.tiktok.com/@syu_u0316" style="color:#667eea;text-decoration:none">TikTokプロフィール</a>
  </div>
  
  <div class="actions">
    <button class="btn" id="likeBtn">Like</button>
    <button class="btn">Comment</button>
    <button class="btn">Share</button>
  </div>
  
  <div class="count">
    <div id="count">0</div>
    <div style="font-size:16px;color:#222">Likes</div>
  </div>
</div>

<script>
let likeCount = 0;
let isLiked = false;
const btn = document.getElementById('likeBtn');
const countEl = document.getElementById('count');

btn.addEventListener('click', function() {
  if (isLiked) {
    likeCount = likeCount - 1;
    isLiked = false;
    btn.classList.remove('liked');
  } else {
    likeCount = likeCount + 1;
    isLiked = true;
    btn.classList.add('liked');
  }
  countEl.textContent = likeCount;
});
</script>

</body>
</html>
