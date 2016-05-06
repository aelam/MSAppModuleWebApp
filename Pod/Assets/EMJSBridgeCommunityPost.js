(function() {
  var GoodsCommunityPost = {
    post: function(params, responseCallback) {
      WebViewJavascriptBridge.callHandler('post', params, responseCallback);
    },
  }

  if (window.goods) {
    goods.installPlugin(GoodsCommunityPost);
  } else {
    document.addEventListener("goodsReady", function(){
      goods.installPlugin(GoodsFund);
    })
  }

}());
