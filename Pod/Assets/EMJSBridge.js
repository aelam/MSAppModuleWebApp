(function() {
  window.AppURLScheme = "emstock";

  function openPath(path, params) {
    openPath2(AppURLScheme, path, params);
  }

  function ParseParam(obj) {
    var params = [];
    for (var p in obj) {
      if (typeof(obj[p]) == "undefined" || obj[p] == "undefined") {
        obj[p] = "";
      }
      params.push(p + "=" + encodeURIComponent(obj[p]));
    }
    params = params.join('&');
    return params;
  }

  function openPath2(URLScheme, path, params) {
    var doc = document;
    var fullPath = URLScheme + "://" + path + "?" + ParseParam(params);
    _createQueueReadyIframe(doc, fullPath);
  }

  function _createQueueReadyIframe(doc, src) {
    messagingIframe = doc.createElement('iframe')
    messagingIframe.style.display = 'none'
    messagingIframe.src = src; //CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE
    doc.documentElement.appendChild(messagingIframe);
    doc.documentElement.removeChild(messagingIframe);
  }


  if (window.goods) {
    return;
  };

  // 如果不支持WebViewJavascriptBridge 则使用老的方式
  var GoodsBridge = {
    callHandler: function(handlerName, data, responseCallback) {
      if (window.WebViewJavascriptBridge) {
        window.WebViewJavascriptBridge.callHandler(handlerName, data,
          responseCallback);
      } else {
        openPath(handlerName, data);
      }
    }
  };

  window.goods = {
    ready: function(callback) {
      if (window.WebViewJavascriptBridge) {
        return callback(WebViewJavascriptBridge);
      }
      if (window.WVJBCallbacks) {
        return window.WVJBCallbacks.push(callback);
      }
      window.WVJBCallbacks = [callback];
      var WVJBIframe = document.createElement('iframe');
      WVJBIframe.style.display = 'none';
      WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
      document.documentElement.appendChild(WVJBIframe);
      setTimeout(function() {
        document.documentElement.removeChild(WVJBIframe)
      }, 0)
    },

    // Actions
    // 2.9.0+ 改成回调方式
    getAppInfo2: function(params2, response) {
      WebViewJavascriptBridge.callHandler('getAppInfo2', null, response);
    },

    // 页面跳转类型
    showgoods: function(stockId, fk, goodsName, subType) {
      var params = {
        "stockId": stockId,
        "subType": subType,
        "goodsName": goodsName,
        "fk": fk
      };
      openPath('showgoods', params);
    },

    goback: function() {
      GoodsBridge.callHandler("back");
    },

    addZxg: function(stockId, callback) {
      var params = {
        "stockId": stockId,
        "callback": callback
      };
      GoodsBridge.callHandler('addZXG', params, function(
        response) {})
    },

    login: function(gowhere, callback) {
      var params = {
        "next": gowhere,
        "callback": callback
      };
      openPath('login', params);
    },

    // Not implement
    purchase: function() {},

    search: function(searchStr, type, callback) {
      var params = {
        "content": searchStr,
        "type": type,
        "callback": callback
      };
      GoodsBridge.callHandler('search', params, function(response) {})
    },

    close: function() {
      GoodsBridge.callHandler('close', null, function(response) {})

    },

    openurl: function(url) {
      var params = {
        "url": url
      };
      GoodsBridge.callHandler('web', params, function(response) {})

    },

    homepage: function() {
      openPage("home", null);
    },

    share: function(title, url, id, imageurl, iconUrl, content, type,
      callback) {
      var params = {
        "title": title,
        "url": url,
        "id": id,
        "imageurl": imageurl,
        "iconUrl": iconUrl,
        "content": content,
        "type": type,
        "callback": callback
      };
      GoodsBridge.callHandler('share', params, function(response) {})
    },

    completeTask: function(taskId, callback) {
      var params = {
        "taskId": taskId,
        "callback": callback
      };
      GoodsBridge.callHandler('completeTask', params, function(
        response) {})

    },

    checkTaskStatus: function(operationId, callback) {
      var params = {
        "operationId": operationId,
        "callback": callback
      };

      GoodsBridge.callHandler('checkTaskStatus', params, function(
        response) {})

    },

    openPage: function(pageId) {
      var params = {
        "pageId": pageId
      };
      openPath("page", params);
    },

    writePost: function(barId, barType, topicType, wordslimit, callback) {
      var params = {
        "barId": barId,
        "barType": barType,
        "topicType": topicType,
        "wordslimit": wordslimit,
        "callback": callback
      };
      openPath("writePost", params);
    },

    sendPost: function(barId, barType, topicType, title, content,
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
      openPath("sendPost", params);
    },

    reply: function(topidid, quotoid, wordslimit, replyTo, callback) {
      var params = {
        "topicId": topidid,
        "quotoId": quotoid,
        "wordslimit": wordslimit,
        "replyTo": replyTo,
        "callback": callback
      };
      openPath("reply", params);
    },

    replyHalfScreen: function(topicId, postId, wordLimit, replyTo, callback) {
      var params = {
        "topicId": topicId,
        "postId": postId,
        "wordLimit": wordLimit,
        "replyTo": replyTo,
        "callback": callback
      };
      openPath("replyHalfScreen", params);
    },

    myFunsTopics: function(userId) {
      var params = {
        "userId": userId
      };
      openPath("friendList", params);
    },

    pointChange: function(point, pointChange, integral, showNotify) {
      var params = {
        "point": point,
        "pointChange": pointChange,
        "integral": integral,
        "showNotify": showNotify
      };

      GoodsBridge.callHandler('pointsChange', params, function(
        response) {})

    },

    updateUserInfo: function(exp, point, level, nextlvexp, bitmapNewapp) {
      var params = {
        "exp": exp,
        "point": point,
        "level": level,
        "nextlvexp": nextlvexp,
        "bitmapNewapp": bitmapNewapp
      };
      GoodsBridge.callHandler('updateUserInfo', params, function(
        response) {})
    },

    playVideo: function(id, sourceType, url, domain, meetingId, title,
      videoStatus) {
      var params = {
        "id": id,
        "sourceType": sourceType,
        "url": url,
        "domain": domain,
        "meetingId": meetingId,
        "title": title,
        "videoStatus": videoStatus
      };
      openPath("playVideo", params);
    },

    openAccount: function() {
      openPath("openAccount", params);
    },

    openCommentList: function(url, topicId) {
      var params = {
        "url": url,
        "topicId": topicId
      };
      openPath("commentList", params);
    },

    copy: function(text) {
      var params = {
        "text": text
      };
      GoodsBridge.callHandler('copy', params, function(response) {})
    },

    // 理财
    // 页面跳转类型的使用openPath
    // 获取数据的使用GoodsBridge
    getFundAccount: function(vendorId) {
      var params = {
        "vendorId": vendorId
      };
      GoodsBridge.callHandler('getFundAccount', params, null);
    },

    goFundMyAsset: function() {
      GoodsBridge.callHandler('goFundMyAsset', null, null);
    },

    // @params: {appurl:"emstock://"}
    canOpenURL2: function(params, responseCallback) {
      GoodsBridge.callHandler('canOpenURL2', params, responseCallback)
    },

    showNotify: function(message) {
      var params = {
        "message": message
      };
      GoodsBridge.callHandler('showNotify', params, null);
    },

    shareConfig: function(shareToggle, title, url, imageurl, content) {
      var params = {
        "shareToggle": shareToggle,
        "title": title,
        "url": url,
        "imageurl": imageurl,
        "content": content
      };
      GoodsBridge.callHandler('shareConfig', params, function(
        response) {})
    },

    searchConfig: function(searchToggle) {
      var params = {
        "searchToggle": searchToggle,
      };
      GoodsBridge.callHandler('searchConfig', params, function(
        response) {})
    },

    heightChange: function(webViewheight, type) {
      var params = {
        "webViewheight": webViewheight,
        "type": type,
      };
      GoodsBridge.callHandler('heightChange', params, function(
        response) {})
    },

    installPlugin: function(plugin) {
      for (var item in plugin) {
        goods[item] = plugin[item];
      }
    }
  };

}());

(function() {
  var ev = document.createEvent("Event");
  ev.initEvent("goodsReady", true, true);
  document.dispatchEvent(ev);
}());

//炒盘技巧--区分是否有此任务
if (typeof(clientGoods) != "undefined" && clientGoods != null && typeof(
    clientGoods.initTasks) != "undefined" && clientGoods.initTasks != null) {
  clientGoods.initTasks();
}
