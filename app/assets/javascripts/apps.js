var appCache = window.applicationCache;
var firstCache = appCache.status == appCache.UNCACHED;

window.onload = function(){ 
  if(window.navigator.standalone) {
    addCacheEventListener();
  }

  if (window.navigator.onLine && firstCache == false) {
    appCache.update();
  }

  showContents();
}

function addCacheEventListener() {
  appCache.addEventListener('updateready', function(e) {
    if(confirm('データの更新が完了しました。再読み込みしますか？')){
      appCache.swapCache();
      location.reload();
    }
  }, false);

  appCache.addEventListener('cached', function(e){
    alert('データの保存が完了しました');
  }, false);

//  appCache.addEventListener('noupdate', function(e){
//    alert('noupdate');
//  }, false);

  appCache.addEventListener('downloading', function(e){
    if(firstCache){
      alert('アプリデータのダウンロードを開始します');
    }else{
      alert('最新版が見つかったためアップデートします');
    }
  }, false);

  appCache.addEventListener('error', function(e){
    if (window.navigator.onLine) {
      alert('データの保存に失敗しました');
    }
  }, false);

  appCache.addEventListener('progress', function(e){
    console.log("progress");
  }, false)
}

function showContents()
{
  var contents = document.getElementById("contents");
  var appHTML = '<iframe src="' + appName + '/index.html" frameborder="0" width="100%" height="100%" marginwidth="0" marginheight="0"></iframe>';
  var downloadHTML = 'Add To Home';

  if( window.navigator.standalone ) {
    contents.innerHTML = appHTML;
  }else{
    contents.innerHTML = downloadHTML;
  }
}


