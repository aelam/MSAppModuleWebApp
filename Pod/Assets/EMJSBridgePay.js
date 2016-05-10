 (function() {
   var GoodsPay = {
    pay: function(params, responseCallback) {
       WebViewJavascriptBridge.callHandler('pay', params,
         responseCallback);
     },
   }

   if (window.goods) {
     goods.installPlugin(GoodsCommunityPost);
   } else {
     document.addEventListener("goodsReady", function() {
       goods.installPlugin(GoodsPay);
     })
   }

 }());
