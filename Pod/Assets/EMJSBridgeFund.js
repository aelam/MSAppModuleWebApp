(function() {
  // 理财
  // 页面跳转类型的使用openPath
  // 获取数据的使用GoodsBridge
  var GoodsFund = {
    getFundAccount: function(vendorId) {
      var params = {
        "vendorId": vendorId
      };
      GoodsBridge.callHandler('getFundAccount', params, null);
    },

    goFundMyAsset: function() {
      GoodsBridge.callHandler('goFundMyAsset', null, null);
    },
  }

  if (window.goods) {
    goods.installPlugin(GoodsFund);
  } else {
    document.addEventListener("goodsReady", function(){
      goods.installPlugin(GoodsFund);
    })
  }

}());
