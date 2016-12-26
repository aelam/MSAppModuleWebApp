(function () {
  window.AppURLScheme = "jsbridge";

  function ParseParam(obj) {
    var params = [];
    for (var p in obj) {
      if (typeof (obj[p]) == "undefined" || obj[p] == "undefined") {
        obj[p] = "";
      }
      params.push(p + "=" + encodeURIComponent(obj[p]));
    }
    params = params.join('&');
    return params;
  }

  function openPath(path, params) {
    openPath2(AppURLScheme, path, params);
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

  function prepareWebViewJavascriptBridge(callback) {
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
    setTimeout(function () {
      document.documentElement.removeChild(WVJBIframe)
    }, 0)
  }


  if (window.goods) {
    return;
  };

  // 如果不支持WebViewJavascriptBridge 则使用老的方式
  window.GoodsBridge = {
    callHandler: function (handlerName, data, responseCallback) {
      prepareWebViewJavascriptBridge(function (bridge) {
        if (bridge) {
          var parameters = data;
          if (typeof (data) === "string") {
            parameters = JSON.parse(data);
          }

          if (responseCallback) {
            window.WebViewJavascriptBridge.callHandler(handlerName, parameters, responseCallback);
          } else {
            window.WebViewJavascriptBridge.callHandler(handlerName, parameters, function (result) {
              var callback = parameters["callback"];
              if (callback) {
                eval(callback)(result);
              }
            });
          }
        } else {
          openPath(handlerName, data);
        }
      });
    }
  };

  window.goods = {
    ready: function (bridge) {
      prepareWebViewJavascriptBridge(bridge);
    },

    goback: function () {
      GoodsBridge.callHandler("back");
    },

    openurl: function (url) {
      var params = {
        "url": url
      };
      GoodsBridge.callHandler('web', params, function (response) { })
    },

    close: function () {
      GoodsBridge.callHandler('close', null, function (response) { })
    },

    copy: function (text) {
      var params = {
        "text": text
      };
      GoodsBridge.callHandler('copy', params, function (response) { })
    },

    // 2.9.0
    route: function (path, params) {
      params.path = path;
      GoodsBridge.callHandler("route", params, function (
        response) { })
    },

    showMenuItems: function (params) {
      GoodsBridge.callHandler("showMenuItems", params, function (
        response) { })
    },

    // 分享模块
    share: function (title, url, platformId, imageUrl, iconUrl, content, mediaType,
      callback) {
      var params = {
        "title": title,
        "url": url,
        "platformId": platformId,
        "imageUrl": imageUrl,
        "iconUrl": iconUrl,
        "content": content,
        "mediaType":mediaType,
        "callback": callback
      };
      GoodsBridge.callHandler('share', params, null)
    },

    shareMessage: function (params) {
      GoodsBridge.callHandler('share', params, null)
    },

    showNotify: function (message) {
      var params = {
        "message": message
      };
      GoodsBridge.callHandler('showNotify', params, null);
    },

    // `showMenuItems`替代`shareConfig`,`searchConfig`的配置
    shareConfig: function (shareToggle, title, url, imageurl, content) {
      var params = {
        "shareToggle": shareToggle,
        "title": title,
        "url": url,
        "imageurl": imageurl,
        "content": content
      };
      GoodsBridge.callHandler('shareConfig', params, function (
        response) { })
    },

    // 仅加强版旧版使用
    searchConfig: function (searchToggle) {
      var params = {
        "searchToggle": searchToggle,
      };
      GoodsBridge.callHandler('searchConfig', params, function (
        response) { })
    },

    // 2.9.0
    // @params: {appurl:"emstock://"}
    canOpenURL2: function (params, responseCallback) {
      GoodsBridge.callHandler('canOpenURL2', params, responseCallback)
    },

    // 2.9.0+ 改成回调方式
    getAppInfo2: function (params, responseCallback) {
      GoodsBridge.callHandler('getAppInfo2', params,
        responseCallback);
    },

    // 2.9.0+
    updateTitle: function (params, responseCallback) {
      GoodsBridge.callHandler('updateTitle', params,
        responseCallback);
    },

    // EMMPStock 新增
    showChangeFontSizeView: function (params, responseCallback) {
      GoodsBridge.callHandler('showChangeFontSizeView', params,
        responseCallback);
    },

    installPlugin: function (plugin) {
      for (var item in plugin) {
        goods[item] = plugin[item];
      }
    }
  };

} ());

(function () {
  var ev = document.createEvent("Event");
  ev.initEvent("goodsReady", true, true);
  document.dispatchEvent(ev);
} ());

