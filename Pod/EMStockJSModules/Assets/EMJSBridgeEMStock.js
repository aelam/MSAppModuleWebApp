(function() {
  // 理财
  // 页面跳转类型的使用openPath
  // 获取数据的使用GoodsBridge
  var GoodsEMStock = {
    openPage: function (pageId) {
      var params = {
        "pageId": pageId
      };
      GoodsBridge.callHandler("page", params, function (
        response) { })
    },

    // 2.9.0
    // {pageId:104000, stockCode:2000,stockName:10000}
    routePage: function (params) {
      GoodsBridge.callHandler("routePage", params, function (
        response) { })
    },

    // 页面跳转类型
    showgoods: function (stockId, fk, goodsName, subType) {
      var params = {
        "stockId": stockId,
        "subType": subType,
        "goodsName": goodsName,
        "fk": fk
      };
      goods.route('stock', params);
    },

    // 自选股模块
    addZxg: function (stockId, callback) {
      var params = {
        "stockId": stockId,
        "callback": callback
      };
      GoodsBridge.callHandler('addZXG', params, function (
        response) { })
    },

    // 授权模块
    login: function (gowhere, callback) {
      var params = {
        "next": gowhere,
        "callback": callback
      };
      goods.route('login', params);
    },

    // Not implement
    purchase: function () { },

    // 搜索模块
    search: function (searchStr, type, callback) {
      var params = {
        "content": searchStr,
        "type": type,
        "callback": callback
      };
      GoodsBridge.callHandler('search', params, function (response) { })
    },

    homepage: function () {
      goods.route('home', params);
    },
    // 任务模块
    completeTask: function (taskId, callback) {
      var params = {
        "taskId": taskId,
        "callback": callback
      };
      GoodsBridge.callHandler('completeTask', params, function (
        response) { })

    },

    checkTaskStatus: function (operationId, callback) {
      var params = {
        "operationId": operationId,
        "callback": callback
      };

      GoodsBridge.callHandler('checkTaskStatus', params, function (
        response) { })
    },

    // 2.9.0+
    post: function (params, responseCallback) {
      GoodsBridge.callHandler('post', params,
        responseCallback);
    },

    // 社区发帖
    writePost: function (barId, barType, topicType, wordslimit, callback) {
      var params = {
        "barId": barId,
        "barType": barType,
        "topicType": topicType,
        "wordslimit": wordslimit,
        "callback": callback
      };
      goods.route("writePost", params);
    },

    sendPost: function (barId, barType, topicType, title, content,
      wordslimit,
      callback) {
      var params = {
        "barId": barId,
        "barType": barType,
        "topicType": topicType,
        "title": title,
        "content": content,
        "wordslimit": wordslimit,
        "callback": callback
      };
      goods.route("sendPost", params);
    },

    reply: function (topidid, quotoid, wordslimit, replyTo, callback) {
      var params = {
        "topicId": topidid,
        "quotoId": quotoid,
        "wordslimit": wordslimit,
        "replyTo": replyTo,
        "callback": callback
      };
      goods.route("reply", params);
    },

    replyHalfScreen: function (topicId, postId, wordLimit, replyTo, callback) {
      var params = {
        "topicId": topicId,
        "postId": postId,
        "wordLimit": wordLimit,
        "replyTo": replyTo,
        "callback": callback
      };
      goods.route("replyHalfScreen", params);
    },

    myFunsTopics: function (userId) {
      var params = {
        "userId": userId
      };
      goods.route("friendList", params);
    },

    openCommentList: function (url, topicId) {
      var params = {
        "url": url,
        "topicId": topicId
      };
      goods.route("commentList", params)
    },

    // 用户信息模块
    pointChange: function (point, pointChange, integral, showNotify) {
      var params = {
        "point": point,
        "pointChange": pointChange,
        "integral": integral,
        "showNotify": showNotify
      };

      GoodsBridge.callHandler('pointsChange', params, function (
        response) { })

    },

    updateUserInfo: function (exp, point, level, nextlvexp, bitmapNewapp) {
      var params = {
        "exp": exp,
        "point": point,
        "level": level,
        "nextlvexp": nextlvexp,
        "bitmapNewapp": bitmapNewapp
      };
      GoodsBridge.callHandler('updateUserInfo', params, function (
        response) { })
    },

    // 视频播放
    playVideo: function (id, videoresourcetype, videoUrl, domain, mettingid, title) {
        var params = {
        "id": id,
        "videoresourcetype": videoresourcetype,
        "videoUrl": videoUrl,
        "domain": domain,
        "mettingid": mettingid,
        "title": title
      };
      goods.route("playVideo", params);
    },

    openAccount: function () {
      goods.route("openAccount", params);
    },


    // 理财
    // 页面跳转类型的使用openPath
    // 获取数据的使用GoodsBridge
    getFundAccount: function (vendorId) {
      var params = {
        "vendorId": vendorId
      };
      GoodsBridge.callHandler('getFundAccount', params, null);
    },

    goFundMyAsset: function () {
      GoodsBridge.callHandler('goFundMyAsset', null, null);
    },

    // 2.8.4
    heightChange: function (webViewheight, type) {
      var params = {
        "webViewheight": webViewheight,
        "type": type,
      };

      GoodsBridge.callHandler('heightChange', params, function (
        response) { })
    },

  }

  if (window.goods) {
    goods.installPlugin(GoodsEMStock);
  } else {
    document.addEventListener("goodsReady", function(){
      goods.installPlugin(GoodsEMStock);
    })
  }

}());
 
window.onload = function () {
    //炒盘技巧--区分是否有此任务
    if (typeof (clientGoods) != "undefined" && clientGoods != null &&
        typeof (clientGoods.initTasks) != "undefined" &&
        clientGoods.initTasks != null) {
        clientGoods.initTasks();
    }
}

