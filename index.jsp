<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ECサイト</title>
<style>
  body { margin: 0; font-family: sans-serif; background: #f8f9fa; }

  /* ヘッダー全体のレイアウト調整 */
  .site-header {
    display: flex; align-items: center; justify-content: space-between;
    padding: 10px 16px; background: #1e2d42; color: #fff;
    position: relative; z-index: 20;
  }
  
  /* 左側の塊（ボタン＋タイトル） */
  .header-left {
    display: flex; align-items: center; gap: 12px;
  }
  .site-header .title { font-size: 1.1rem; font-weight: bold; letter-spacing: 0.05em; }

  /* 右側の塊（ログイン＋新規登録ボタン） */
  .header-right {
    display: flex; align-items: center; gap: 10px;
  }

  /* 右側ボタンの共通スタイル */
  .header-btn {
    display: inline-block; text-decoration: none; font-size: 0.85rem;
    font-weight: bold; padding: 6px 14px; border-radius: 4px;
    transition: opacity 0.2s;
  }
  .header-btn:hover { opacity: 0.85; }
  
  /* ログインボタン（白枠） */
  .btn-login {
    color: #fff; border: 1px solid #fff; background: transparent;
  }
  /* 新規登録ボタン（テラコッタオレンジ） */
  .btn-register {
    color: #fff; background: #c84c24; border: none;
  }

  /* ハンバーガーボタン */
  .menu-btn {
    width: 40px; height: 40px; padding: 11px 8px;
    background: none; border: none; cursor: pointer;
    display: flex; flex-direction: column; justify-content: space-between;
  }
  .menu-btn span {
    display: block; height: 3px; background: #fff; border-radius: 2px;
    transition: transform .25s, opacity .25s; width: 100%;
  }
  /* 開いたとき「×」に変形 */
  .menu-btn.open span:nth-child(1) { transform: translateY(6px) rotate(45deg); }
  .menu-btn.open span:nth-child(2) { opacity: 0; }
  .menu-btn.open span:nth-child(3) { transform: translateY(-6px) rotate(-45deg); }

  /* メニュー本体 */
  .menu {
    position: fixed; top: 0; left: -260px; width: 240px; height: 100%;
    box-sizing: border-box;
    background: #fff; box-shadow: 2px 0 8px rgba(0,0,0,.2);
    padding: 70px 0 20px; transition: left .25s; z-index: 10;
    overflow-y: auto; /* 項目が増えて縦に長くなってもスクロールできるように設定 */
  }
  .menu.open { left: 0; }
  .menu a {
    display: block; padding: 14px 20px; color: #22344a;
    text-decoration: none; border-bottom: 1px solid #eee;
  }
  .menu a:hover { background: #f3f1ea; }

  /* メニューを開いたときの背景 */
  .overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,.4); z-index: 5;
  }
  .overlay.open { display: block; }

  .content { padding: 32px 24px; }
  .content h1 { font-size: 1.6rem; color: #333; margin-bottom: 16px; }
  .content a { color: #004bb1; text-decoration: underline; }
  .content a:hover { text-decoration: none; }

  /* ▼▼▼ アコーディオン用の修正スタイル ▼▼▼ */
  
  /* 開閉ボタンになる見出し（ラベル） */
  .menu-label {
    display: flex; justify-content: space-between; align-items: center;
    padding: 16px 20px; font-size: .75rem; font-weight: bold;
    color: #8a8272; border-bottom: 1px solid #eee; background: #faf8f2;
    cursor: pointer;  user-select: none;
  }
  
  /* 右側に「▼」マークを表示 */
  .menu-label::after {
    content: '▼';
    font-size: 0.6rem;
    color: #a09888;
    transition: transform 0.2s;
  }
  
  /* 開いているときは「▼」をひっくり返す */
  .menu-label.active::after {
    transform: rotate(180deg);
  }

  /* 子メニューを包むコンテナ */
  .menu-child {
    display: none; /* 初期状態は非表示（隠す） */
    background: #fff;
  }
  
  /* activeクラスがついたら表示する */
  .menu-child.active {
    display: block;
  }
  
  /* ▲▲▲ ここまで ▲▲▲ */
</style>
</head>
<body>

<div class="site-header">
  <div class="header-left">
    <button class="menu-btn" id="menuBtn" aria-label="メニュー">
      <span></span><span></span><span></span>
    </button>
    <div class="title">マルシェオンライン</div>
  </div>
  
  <div class="header-right">
    <a href="/marche-online/login" class="header-btn btn-login">ログイン</a>
    <a href="/marche-online/register" class="header-btn btn-register">新規登録</a>
  </div>
</div>

<nav class="menu" id="menu">
  <a href="index.jsp">トップ</a>
  <a href="top.jsp">商品一覧</a>
  <br>
  <a href="/marche/works/">チーム全体の進捗</a>
  <a href="https://miragedecoy0217-cmd.github.io/marche-online/">プロジェクト計画書</a>
  <a href="https://cotoacjp-my.sharepoint.com/:x:/g/personal/25i1010_coto_ac_jp/IQBbrNmBQjQ4TbH6-YvBgOoQAZGssEgJuZwil4b13sfdL4Q?e=9vJ9jN">WBS</a>
  <a href="/marche/works/">成果物</a>
  <br>
<!-- 個人のタスク進捗（アコーディオン化） -->
  <div class="menu-label js-accordion-toggle">個人のタスク進捗</div>
  <div class="menu-child">
    <a href="/marche/Nishizono/">西園</a>
    <a href="/marche/Teramoto/">寺本</a>
    <a href="/marche/Inoue/">井上</a>
   
  </div>

  <!-- 個人ページ（アコーディオン化） -->
  <div class="menu-label js-accordion-toggle">個人ページ</div>
  <div class="menu-child">
    <a href="https://infinityfree.io" target="_blank" rel="noopener">西園のページ</a>
    <a href="http://172.16.1.118:8080/sample/index.jsp" target="_blank" rel="noopener">寺本のページ</a>
    <a href="/inoue/">井上のページ</a>
    
  </div>


</nav>
<div class="overlay" id="overlay"></div>

<div class="content">
  <h1>ようこそ ECサイトへ</h1>
  <a href="top.jsp">商品一覧へ</a>
</div>

<script>
  // ハンバーガーメニューの開閉処理
  const btn = document.getElementById("menuBtn");
  const menu = document.getElementById("menu");
  const overlay = document.getElementById("overlay");

  function toggle() {
    btn.classList.toggle("open");
    menu.classList.toggle("open");
    overlay.classList.toggle("open");
  }
  btn.addEventListener("click", toggle);
  overlay.addEventListener("click", toggle);

  // ▼▼▼ アコーディオン開閉用のJavaScriptを追加 ▼▼▼
  const toggles = document.querySelectorAll(".js-accordion-toggle");
  
  toggles.forEach(toggle => {
    toggle.addEventListener("click", () => {
      // クリックされたラベルの次の要素（.menu-child）を取得
      const childMenu = toggle.nextElementSibling;
      
      // activeクラスをつけ外しして表示・非表示を切り替える
      toggle.classList.toggle("active");
      childMenu.classList.toggle("active");
    });
  });
</script>

</body>
</html>
