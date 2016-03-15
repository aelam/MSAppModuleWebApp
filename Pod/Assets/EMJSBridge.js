
var AppURLScheme = "emstock";

function openPath(path, params) {
    openPath2(AppURLScheme, path, params);
}

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

function openPath2(URLScheme, path, params) {
    var doc = document;
    var fullPath = URLScheme + "://" + path + "?" + ParseParam(params);
    _createQueueReadyIframe(doc, fullPath);
}

function _createQueueReadyIframe(doc, src) {
  messagingIframe = doc.createElement('iframe')
  messagingIframe.style.display = 'none'
  messagingIframe.src = src;//CUSTOM_PROTOCOL_SCHEME + '://' + QUEUE_HAS_MESSAGE
  doc.documentElement.appendChild(messagingIframe)
}

var goods = {
    showgoods: function (stockId, fk, goodsName, subType) {
        var params = {
            "stockId": stockId,
            "subType": subType,
            "goodsName": goodsName,
            "fk": fk
        };
        openPath("stock", params);
    },

    goback: function () {
        window.location.href = "emstock://back";
    },

    addZxg: function (stockId, callback) {
        var params = {
            "stockId": stockId,
            "callback": callback
        };
        openPath("addZXG", params);
    },

    login: function (gowhere, callback) {
        var params = {
            "next": gowhere,
            "callback": callback
        };
        openPath("login", params);
    },

    // Not implement
    purchase: function () {
    },

    search: function (searchStr, type, callback) {
        var params = {
            "content": searchStr,
            "type": type,
            "callback": callback
        };
        openPath("search", params);
    },

    close: function () {
        openPath("close", null);
    },

    openurl: function (url) {
        var params = {
            "url": url
        };
        openPath("web", params);
    },

    homepage: function () {
        openPath("home", null);
    },

    share: function (title, url, id, imageurl, iconUrl, content, type, callback) {
        var params = {
            "title": title,
            "url": url,
            "id": id,
            "imageurl":imageurl,
            "iconUrl":iconUrl,
            "content":content,
            "type":type,
            "callback":callback
        };
        openPath("share", params);
    },

    completeTask: function (taskId, callback) {
        var params = {
            "taskId": taskId,
            "callback": callback
        };
        openPath("completeTask", params);
    },

    checkTaskStatus: function (operationId, callback) {
        var params = {
            "operationId": operationId,
            "callback": callback
        };
        openPath("checkTaskStatus", params);
    },

    openPage: function (pageId) {
        var params = {
            "pageId": pageId
        };
        openPath("page", params);
    },

    writePost: function (barId, barType, topicType, wordslimit, callback) {
        var params = {
            "barId": barId,
            "barType": barType,
            "topicType":topicType,
            "wordslimit": wordslimit,
            "callback":callback
        };
        openPath("writePost", params);
    },


    reply: function (topidid, quotoid, wordslimit, replyTo, callback) {
        var params = {
            "topicId": topidid,
            "quotoId": quotoid,
            "wordslimit": wordslimit,
            "replyTo":replyTo,
            "callback":callback
        };
        openPath("reply", params);
    },

    replyHalfScreen: function (topicId, postId, wordLimit, replyTo, callback) {
        var params = {
            "topicId": topicId,
            "postId": postId,
            "wordLimit": wordLimit,
            "replyTo": replyTo,
            "callback": callback
        };
        openPath("replyHalfScreen", params);
    },

    myFunsTopics: function (userId) {
        var params = {
            "userId": userId
        };
        openPath("friendList", params);
    },

    pointChange: function (point, pointChange,integral,showNotify) {
        var params = {
            "point": point,
            "pointChange": pointChange,
            "integral": integral,
            "showNotify":showNotify
        };
        openPath("pointsChange", params);
    },

    updateUserInfo: function (exp,point,level,nextlvexp,bitmapNewapp) {
        var params = {
            "exp": exp,
            "point": point,
            "level": level,
            "nextlvexp": nextlvexp,
            "bitmapNewapp":bitmapNewapp
        };
        openPath("updateUserInfo", params);
    },

    playVideo: function (id, sourceType, url, domain, meetingId, title, videoStatus) {
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
        openPath("openAccount", null);
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
        openPath("copy", params);
    },

    getFundAccount: function(vendorId) {
        var params = {
            "vendorId": vendorId
        };
        openPath("getFundAccount", params);
    },

    goFundMyAsset: function() {
      openPath("goFundMyAsset", null);
    },

    canOpenURL: function(appurl,callback) {
        var params = {
            "appurl": appurl,
            "callback":callback
        };

        openPath("canOpenURL", params);
   },

   showNotify: function(message) {
        var params = {
            "message": message
        };
        openPath("showNotify", params);
    },

   shareConfig: function(shareToggle ,title, url, imageurl, content) {
     var params = {
         "shareToggle": shareToggle,
         "title": title,
         "url": url,
         "imageurl":imageurl,
         "content":content,
     };
     openPath("shareConfig", params);
   },

    searchConfig: function (searchToggle) {
        var params = {
            "searchToggle": searchToggle,
        };
        openPath("searchConfig", params);
    }
};

(function () {
    var ev = document.createEvent("Event");
    ev.initEvent("goodsReady", true, true);
    document.dispatchEvent(ev);
 }());

//炒盘技巧--区分是否有此任务
if (typeof (clientGoods) != "undefined" && clientGoods != null && typeof (clientGoods.initTasks) != "undefined" && clientGoods.initTasks != null) {
    clientGoods.initTasks();
}
