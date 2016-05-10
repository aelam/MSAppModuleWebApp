 (function() {
   // 理财
   // 页面跳转类型的使用openPath
   // 获取数据的使用GoodsBridge
   var GoodAudioPlayer = {
     /**
      * @param: url
      * @param: url
      */
     playAudio: function(params, responseCallback) {
       GoodsBridge.callHandler('playAudio', params, responseCallback);
     },

     /**
      * @param: url
      * @param: url
      */
     stopAudio: function(params, responseCallback) {
       GoodsBridge.callHandler('stopAudio', params, responseCallback);
     },

     pauseAudio: function(params, responseCallback) {
       GoodsBridge.callHandler('pauseAudio', params, responseCallback);
     },

     /**
      * @param: url
      * @param: url
      */
     getAudioProgress: function(params, responseCallback) {
       GoodsBridge.callHandler('getAudioProgress', params, responseCallback);
     }
   }

   if (window.goods) {
     goods.installPlugin(GoodAudioPlayer);
   } else {
     document.addEventListener("goodsReady", function() {
       goods.installPlugin(GoodAudioPlayer);
     })
   }

 }());
