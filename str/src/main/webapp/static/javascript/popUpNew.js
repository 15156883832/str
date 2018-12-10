;(function ($) {
    $.fn.popup = function (options) {
        // options是html中调用popUp()函数时传递过来的参数（json形式）
        var $this = $(this);
        var settings = $.extend({
            fixedHeight: true,  // 弹出框的高度是否固定，默认固定
            level: 1,
            title: '提示',
            type: 0,
            fnConfirm: null,
            fnCancel: null,
            closeSelfOnly: false  // 目前仅针对promptBox，closeSelfOnly仅关闭promptBox本身，不会调整$parentFrame的z-index
        }, options);  //创建一个新对象，保留对象的默认值。

        var width = getSize().width,
            height = getSize().height,
            bodyHeight = getSize().bodyHeight;

        var dValue = 60;
        /*if (bodyHeight >= 900) {
            dValue = 300;
        } else if (bodyHeight >= 800) {
            dValue = 200;
        } else {
            dValue = 120;
        }*/
        var maxHeight = bodyHeight - dValue;
        var $parentFrame = $('#Hui-article-box', window.top.document); // 获取父页面iframe所在的区域 ----------parentFrameContainer----初始9
        var openZindex = parseInt($('#Hui-aside', window.top.document).css('z-index')); // 初始99
        var zIndex = parseInt($parentFrame.css('z-index')); // 初始9
        // $parentFrame.css({'z-index': settings.level * 1000 + zIndex}); // 获取顶层页面iframe所在区域的层级 默认值是1因此，如果不传值settings.level，那么settings.level将会是1000*level+parentFrameContainer的level
        $parentFrame.css({'z-index': 100}); // 获取顶层页面iframe所在区域的层级 默认值是1因此，如果不传值settings.level，那么settings.level将会是1000*level+parentFrameContainer的level,bigger than left side menu

        // 弹出遮罩层
        var $shadeBg = $('<div class="shadeBg" id="shadeBg_' + settings.level + '" style="z-index:' + (settings.level * 100) + ';"></div>'); // shadowBg遮罩的level是settings.level*100
        $(document.body).append($shadeBg);
        var $shadeBgs = $('.shadeBg');
        $shadeBgs.css({
            'height': height,
            'width': width
        });

        return $(this).each(function () {
            var $this = $(this); //  == $dialog
            var $loadBg = $(".loadBg", window.parent.document);
            if ($loadBg) {
                $loadBg.remove();
            }
            var selLoadBg = $(".loadBg", document);
            if (selLoadBg) {
                selLoadBg.remove();
            }

            if (settings.level == '3') {
                var html = '<div class="popupBox promptBox">' +
                    '<h2 class="popupHead">' + settings.title +
                    '<a href="javascript:;" class="sficon closePopup"></a></h2>' +
                    '<div class="popupContainer">' +
                    '<div class="popupMain  f-14" >';
                if (settings.type == 1) {
                    html += '<p class=""><i class="iconType iconType1"></i>' + settings.content + '</p>' +
                        '<div class="text-c pl-10 mt-25">' +
                        '<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70" id="btn-prompt-box-confirm">关闭</a>' +
                        '</div>';

                } else if (settings.type == 2) {
                    html += '<p class=""><i class="iconType iconType2"></i>' + settings.content + '</p>' +
                        '<div class="text-c mt-25 ">' +
                        '<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-10 " id="btn-prompt-box-confirm">确认</a>' +
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="btn-prompt-box-cancel">取消</a>' +
                        '</div>';
                } else {
                    html += '<p class="lh-30 f-14">' + settings.content + '</p>' +
                        '<div class="text-c mt-25">' +
                        '<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-10 " id="btn-prompt-box-confirm">确认</a>' +
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="btn-cancel">取消</a>' +
                        '</div>';
                }
                html += '</div></div></div>';
                $("body").append(html);
                $this = $(".promptBox");
            }

            if (settings.level == '3') {
                $this.css({'z-index': 10000}); // 针对prompt特殊处理,这里假定10000是我们所有弹出框的最大z-index.
            } else {
                $this.css({'z-index': openZindex + settings.level * 100}); // 是左侧菜单的zindex + settings.level*100
            }
            var $container = $($this.find('div.popupContainer')[0]);
            var $main = $($this.find('div.popupMain')[0]);
            var $content = $($this.find('div.pcontent')[0]);

            var thisHeight = $content.height();
            if (!settings.fixedHeight) {
                var paddingR = parseInt($content.css('padding-right'));

                if ($content) {
                    $content.css({
                       'max-height': maxHeight - 70,
                        'overflow-y': 'auto',
                        'padding-right': (paddingR - 17) > 0 ? (paddingR - 17) : 0
                    });
                }
            }
            var $close = $($this.find('.closePopup')[0]); // 弹出框的关闭按钮
            $close.off('click');
            $close.on('click', function () {
                $.closeDiv($this, settings.closeSelfOnly);
            });

            $.setPos($this);
            $this.show();

            window.onresize = function () {
                $.setPos($this);
                $shadeBgs.css({
                    'height': getSize().height,
                    'width': getSize().width
                });
            };

            $close.click(function (e, f, a) {//对应下面click时间
                if (f) {
                    f.call(this, a);
                }
            });

            $('#btn-prompt-box-confirm').bind('click', function () {
                // $close.click();
                var doc = $(this).get(0).ownerDocument;
                // $(this).closest(".popupBox").prev(".shadeBg").eq(0).remove();
                $(".shadeBg").last().remove();
                $(this).closest(".popupBox").remove();
                var win = doc.defaultView || doc.parentWindow;
                if (win.parent === window.top && !settings.closeSelfOnly) {
                    var $iFrame = $('#Hui-article-box', window.top.document);
                    $iFrame.css({'z-index': 9});
                }
                settings.fnConfirm && settings.fnConfirm();
            });
            $('#btn-prompt-box-cancel').bind('click', function () {
                var doc = $(this).get(0).ownerDocument;
                $(".shadeBg").last().remove();
                $(this).closest(".popupBox").remove();
                var win = doc.defaultView || doc.parentWindow;
                if (win.parent === window.top && !settings.closeSelfOnly) {
                    var $iFrame = $('#Hui-article-box', window.top.document);
                    $iFrame.css({'z-index': 9});
                }
                settings.fnCancel && settings.fnCancel();
            });
            $.drugBox($this);
        });
        function getSize() {
            var width = Math.max(getClientSize().width, getScrollSize().width) + "px", // 文档的最大宽度
                height = Math.max(getClientSize().height, getScrollSize().height) + "px"; // 文档的最大高度
            var bodyHeight = Math.min(getClientSize().height, getScrollSize().height);
            return {width: width, height: height, bodyHeight: bodyHeight};
        }
    };

    $.fn.tableHeaderSetting = function (options, callback) {
        var settings = $.extend({
            id: "-1",
            tableHeaderSaveUrl: '#'		//保存表头提交的地址
        }, options);  //创建一个新对象，保留对象的默认值。
        if (settings.sfSortColumns == "" || settings.sfSortColumns == undefined) {
            settings.sfSortColumns = "0";
        }
        var items = getSelectedItems(settings.sfHeader, settings.sfSortColumns);
        if (settings.sfSortColumns == "0") {
            settings.sfSortColumns = settings.sfHeader;
        }
        var headerHtml = generateTableHeader(items.selected, items.unselected);
        $(".header_settable_container").remove();
        $(document.body).append(headerHtml);
        $.selectCheck("optionchk");
        $.shiftHeader("shiftheader");
        var seltor = this.selector;
        bindTableHeadAddBtn();
        bindTableHeadRemoveBtn();
        $(".save-table-header-btn").on('click', function (ev) {
            var selItems = "";
            $(".selectedHead").find("li[class^='selItem_']").each(function () {
                var idx = $(this).attr("tag");
                selItems += "," + idx;
            });

            selItems = selItems.substring(1);
            $.ajax({
                url: settings.tableHeaderSaveUrl,
                data: {sortHeader: selItems, id: settings.id, defaultId: settings.defaultId},
                type: 'post',
                success: function () {
                    $(seltor).find('.closePopup').click();
                    if (callback) {
                        callback();
                    }
                    location.reload();
                }
            });
        });
        $(".cancel-table-header").bind('click', function (ev) {
            // $(seltor).find('.closePopup').trigger('click');
            // $(seltor).find('.closePopup').unbind('click');
            $.closeDiv($(seltor));
        });
        return $(this.selector);
    };

    function isReallyFunctionType(functionToCheck) {
        var getType = {};
        return functionToCheck && getType.toString.call(functionToCheck) === '[object Function]';
    }

    $.extend({
        closeDiv: function (obj, selfOnly) {
            var directOpenLayer = ($('body').children().first().get(0) === obj.get(0));
            var objParent = obj.parent().get(0);
            var doc = obj.get(0).ownerDocument;
            var docWinParent = (doc.defaultView || doc.parentWindow).parent;
            var topWin = window.top;
            $('.shadeBg').last().remove();
            if (obj.hasClass("promptBox")) { // 选择框，每次popup都是新创建，因此需要将其remove。
                obj.remove();
            } else {
                obj.hide();
            }
            var $iFrame = $('#Hui-article-box', window.top.document);

            if (objParent && (objParent.tagName.toLowerCase() === 'body') && directOpenLayer) {
                var index = parent.layer.getFrameIndex(window.name);
                if (typeof index != 'undefined') {
                    try {
                        parent.layer.close(index);
                    } catch (e) {
                    }
                }
            }

            var _selfOnly = false;
            if (typeof selfOnly === 'undefined') {
                _selfOnly = false;
            } else {
                _selfOnly = selfOnly;
            }
            if (docWinParent.parent === topWin && !_selfOnly) {
                $iFrame.css({'z-index': 9});
            }
        },
        closeDiv2: function (obj) {
            // 用layer.open打开弹出框
            var index = parent.layer.getFrameIndex(window.name);
            var zIndex = obj.css('z-index').toString();
            var lv = parseInt(zIndex.charAt(0));
            $('#shadeBg_' + lv).remove();
            obj.hide();
            var $iFrame = $('#Hui-article-box', window.top.document);
            var pzIndex = parseInt($iFrame.css('z-index'));

            if (isNaN(lv)) {
                $iFrame.css({'z-index': 9});
                parent.layer.closeAll();
            } else {
                var $zidx = pzIndex - lv * 1000;
                $iFrame.css({'z-index': $zidx < 0 ? 9 : $zidx});
                // console.log(pzIndex);
                if (lv == 3) {
                    obj.remove();
                }
                if (lv == 1) {
                    parent.layer.close(index);
                }
            }
        },
        closeAllDiv: function (callback) {
            if (isReallyFunctionType(callback)) {
                callback.call();
            }
            var topWin = window.top;
            var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
            var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);
            frameWin.layer.closeAll();
            $("#Hui-article-box", topWin.document).css({
                'z-index': '9'
            });
        },
        setPos: function (obj) {
            var max_left = parseInt(Math.min(getClientSize().width, getScrollSize().width)) - parseInt(obj.outerWidth()),
                max_top = parseInt(Math.min(getClientSize().height, getScrollSize().height)) - parseInt(obj.outerHeight());

            var x_left = (getClientSize().width - parseInt(obj.outerWidth())) / 2,
                y_top = (getClientSize().height - parseInt(obj.outerHeight())) / 2;
            if (x_left < 0) {
                x_left = 0;
            } else if (x_left > max_left) {
                x_left = max_left;
            }
            if (y_top < 0) {
                y_top = 0;
            } else if (y_top > max_top) {
                y_top = max_top;
            }
            obj.css({
                'left': x_left + 'px',
                'top': y_top + 'px'
            })
        },
        drugBox: function(obj){
            var dragging = false;
            var iX, iY;
            var oHead = $(obj).find('.popupHead');

            oHead.mousedown(function(e) {
                dragging = true;
                iX = e.clientX - $(obj).offset().left;
                iY = e.clientY - $(obj).offset().top;
                // console.log( $(obj).offset().top)
                obj.setCapture && obj.setCapture();
                // return false;
                document.onmousemove = function(e) {
                    if (dragging) {
                        var e = e || window.event;
                        var oX = e.clientX - iX;
                        var oY = e.clientY - iY;
                        var maxX =$(document.body).width()-$(obj).outerWidth(),
                            maxY =$(document.body).height()-$(obj).outerHeight() ;

                        if(oX<0){
                            oX = 0;
                        }else if(oX>maxX){
                            oX = maxX;
                        }
                        if(oY<0){
                            oY = 0;
                        }else if(oY>maxY){
                            oY = maxY;
                        }
                        $(obj).css({
                            "left":oX + "px",
                            "top":oY + "px"
                        });
                        return false;
                    }
                };
                $(document).mouseup(function(e) {
                    dragging = false;
                    obj.releaseCapture && obj.releaseCapture();
                    e.cancelBubble = true;
                });
            });

        }
    });

    // 获取窗口可视范围高度/宽度
    function getClientSize() {
        var clientSize = {};
        if (document.body.clientHeight && document.documentElement.clientHeight) {
            clientSize.height = (document.body.clientHeight < document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
            clientSize.width = (document.body.clientWidth < document.documentElement.clientWidth) ? document.body.clientWidth : document.documentElement.clientWidth;
        } else {
            clientSize.height = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
            clientSize.width = (document.body.clientWidth > document.documentElement.clientWidth) ? document.body.clientWidth : document.documentElement.clientWidth;
        }
        return clientSize;
    }

    // 获取窗口滚动条高度
    function getScrollPos() {
        var scroll = {};
        if (document.documentElement && document.documentElement.scrollTop) {
            scroll.top = document.documentElement.scrollTop;
            scroll.left = document.documentElement.scrollLeft;
        } else {
            scroll.top = document.body.scrollTop;
            scroll.left = document.body.scrollLeft;
        }
        return scroll;
    }

    //获取文档实际内容高度
    function getScrollSize() {
        var scrollSize = {};
        scrollSize.height = Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
        scrollSize.width = Math.max(document.body.scrollWidth, document.documentElement.scrollWidth);
        return scrollSize;
    }

    function bindTableHeadAddBtn() {
        $(".sfheader-add-btn").unbind("click");
        $(".sfheader-add-btn").on('click', function (ev) {
            ev.stopPropagation();
            addToRight();
            return false;
        });
    }

    function bindTableHeadRemoveBtn() {
        $(".sfheader-del-btn").unbind("click");
        $(".sfheader-del-btn").bind('click', function (ev) {
            ev.stopPropagation();
            addToLeft($(this).attr("id"), $(this).attr('tag'));
            $(this).parents('li').remove();
            return false;
        });
    }

    function generateTableHeader(selItems, unselItems){
        var html = '';
        html += '<div class="popupBox addHeaders header_settable_container">'
            + '<h2 class="popupHead">'
            + '表头设置'
            + '<a href="javascript:;" class="sficon closePopup"></a>'
            + '</h2>'
            + '<div class="popupContainer">'
            + '<div class="popupMain">'
            + '<div class="cl">'
            + '<dl class="tabheaders optionalHead pb-10"><dt class="text-c">可选字段</dt><dd><ul class="pt-10">';
        for(var i = 0; i < unselItems.length; i++){
            var item_ = unselItems[i];
            html += '<li><label class="label-cbox2" for="'+item_.name+'"><input type="checkbox" id="'+item_.name+'" tag="'+item_.label+'" name="optionchk">'+item_.label+'</label></li>';
        }
        html += '</ul></dd></dl>';
        html += '<dl class="tabheaders selectedHead"><dt class="cl"><p class="left-lb">已选字段</p><p class="right-lb">操作</p></dt><dd class="pb-10">';

        var frozenHtml = '<ul class="disabledmove pt-10">';
        var selHtml = '<ul id="shiftheader">';
        var isFrozen = false;
        for(var i = 0; i < selItems.length; i++){
            var item = selItems[i];
            if(item.frozen){//冻结列表
                frozenHtml += '<li class="selItem_'+item.name+'" tag="'+item.name+'"><p class="left-lb">'+item.label+'</p></li>';
                isFrozen = true;
            }else{
                selHtml += '<li class="selItem_'+item.name+'" tag="'+item.name+'"><p class="left-lb">'+item.label+'</p><p class="right-lb">';
                selHtml += '<a href="javascript:;" class="sficon sficon-arrowtop1" title="上移" ></a>';
                selHtml += '<a href="javascript:;" class="sficon sficon-arrowdown1" title="下移" ></a>';
                selHtml += '<a href="javascript:;" class="sficon sficon-delete1 sfheader-del-btn" id="'+item.name+'" tag="'+item.label+'" title="删除" ></a>';
                selHtml += '</p></li>';
            }
        }
        frozenHtml += '</ul>';
        html += (isFrozen ? frozenHtml : '') + selHtml;
        html += '<a href="javascript:;" class="sfbtn sfbtn-opt btn-addheaders sfheader-add-btn">添加</a>';
        html += '</div>'
            + '<div class="text-c btbWrap">'
            + '<a href="javascript:;" class="sfbtn sfbtn-opt3 save-table-header-btn">保存</a>'
            + '<a href="javascript:;" class="sfbtn sfbtn-opt ml-10 closePopup cancel-table-header">取消</a>'
            + '</div>'
            + '</div></div>'
            + '</div>';

        return html;
    }

    function addToRight(){
        var items = "";
        $(".optionalHead").find("input[type='checkbox']").each(function(){
            if($(this).is(":checked")){
                items += "," + $(this).attr("id") + "@" + $(this).attr("tag");
            }
        });
        items = items.substring(1);
        var itemArr = items.split(",");
        var len =  itemArr.length;
        selHtml = '';
        for(var i = 0; i < len; i++){
            var item_ = itemArr[i];
            var id = item_.split("@")[0];
            var name = item_.split("@")[1];
            selHtml += '<li class="selItem_'+id+'" tag="'+id+'"><p class="left-lb">'+name+'</p><p class="right-lb">';
            selHtml += '<a href="javascript:;" class="sficon sficon-arrowtop1" title="上移" ></a>';
            selHtml += '<a href="javascript:;" class="sficon sficon-arrowdown1" title="下移" ></a>';
            selHtml += '<a href="javascript:;" class="sficon sficon-delete1 sfheader-del-btn" id="'+id+'" tag="'+name+'" title="删除" ></a>';
            selHtml += '</p></li>';
            $("#" + id, ".header_settable_container").parent().parent().remove();
        }
        $("#shiftheader").append(selHtml);
        $.selectCheck("optionchk");
        $.shiftHeader("shiftheader");
        bindTableHeadRemoveBtn();
    }

    function addToLeft(id, name){
        $(".optionalHead").find("ul").append('<li><label class="label-cbox2" for="'+id+'"><input type="checkbox" id="'+id+'" name="optionchk" tag="'+name+'">'+name+'</label></li>');
        $.selectCheck("optionchk");
        $.shiftHeader("shiftheader");
    }

    function getSelectedItems(defaultItems, sortItems){
        var items = {};
        var selItems = [];
        var unselItems = [];
        var sortArr = sortItems.split(",");
        var sortArrLen = sortArr.length;
        var defaultItemsLen = defaultItems.length;
        for(var j = 0; j < sortArrLen; j++){
            var stVal = sortArr[j];
            for(var i = 0; i < defaultItemsLen; i++){
                var item = defaultItems[i];
                //if(!item.hidden && item.name.indexOf(stVal) != -1){
                if(!item.hidden && item.name == stVal){
                    selItems.push(item);
                    break;
                }
            }
        }

        for(var i = 0 ; i < defaultItemsLen; i++){
            var dfItem = defaultItems[i];
            if(!dfItem.hidden && sortItems == "0" && dfItem.frozen){//第一次没有设置的时候
                selItems.push(dfItem);
                continue;
            }
            if((sortItems == "0" || sortItems.length == 0) && !dfItem.hidden){
                selItems.push(dfItem);
            }else{
                var unSelected = true;
                for(var j = 0; j < sortArrLen; j++){
                    var stItem = sortArr[j];
                    //if(dfItem.name.indexOf(stItem) != -1){
                    if(dfItem.name == stItem){
                        unSelected = false;
                        break;
                    }
                }
                if(!dfItem.hidden && unSelected){
                    unselItems.push(dfItem);
                }
            }
        }

        items.selected = selItems;
        items.unselected = unselItems;
        return items;
    }
}(jQuery));
