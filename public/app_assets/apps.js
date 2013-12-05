window.addEventListener('load', function(){ 
  if(window.navigator.standalone) {
    addCacheEventListener();
    showContents();
  }else{
    showDownloadPage();
  } 

  // window.applicationCache.update();
  // INVALID_STATE_ERR
  // document.getElementsByTagName("html")[0].setAttribute("manifest", bundleId + ".manifest"); 
});

function addCacheEventListener() {
  var appCache = window.applicationCache;

  appCache.addEventListener('checking', function(e) {
    console.log("checking");
  }, false);

  appCache.addEventListener('updateready', function(e) {
    console.log("updateready");
    alert('データの更新が完了しました');
    appCache.swapCache();
    location.reload();
  }, false);

  appCache.addEventListener('cached', function(e){
    console.log("cached");
    alert('データの保存が完了しました');
    hideProgress()
  }, false);

  appCache.addEventListener('noupdate', function(e){
    console.log("noupdate");
  }, false);

  appCache.addEventListener('downloading', function(e){
    console.log("downloading");
    alert('最新版データのダウンロードを開始しました');
    showProgress();
  }, false);

  appCache.addEventListener('error', function(e){
    console.log("error");
    if (window.navigator.onLine) {
      alert('データの保存に失敗しました');
    }
  }, false);

  appCache.addEventListener('progress', function(e){
    updateProgress(Math.floor((e.loaded / e.total) * 100));
    console.log("progress");
  }, false)
}

function showProgress()
{
  document.getElementById("loading").style.display = "block";
  document.getElementById("contents").style.display = "none";
}

function hideProgress()
{
  document.getElementById("loading").style.display = "none";
  document.getElementById("contents").style.display = "block";
}

function updateProgress(percentage)
{
  document.getElementById("progress").innerHTML = percentage + "%"
}

function showContents()
{
  document.contentsFrame.location.href = bundleId + "/app/index.html";
}

function showDownloadPage()
{
  document.contentsFrame.location.href = bundleId + "/assets/download.html";
}
