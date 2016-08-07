import bb.cascades 1.4
import cn.anpho 1.0
Page {
    property string u
    onUChanged: {
        u = u.trim()
        adm.clear()
        scrollView.scrollToPoint(0.0, 0.0)
        if (u.length > 0) {
            console.log("Loading " + u)
            netmgr.ajax("GET", u, [], function(b, d) {
                    if (b) {
                        console.log("ok....." + d)
                        //                        page_description = "desciption"//textEx.getDescription(d);
                        //                        var a = textEx.getContents(d);
                        //                        imp.process(a);
                        imp.process(d)
                    }
                })
        }
    }
    id: pageroot
    property int basetextsize: _app.getv("fontsize", "100")
    property string post_id: ""
    property string page_title: ""
    property string page_description: ""
    property string page_content: ""
    property string pub_date: ""
    property string source_txt: ""
    property string board_id: ""
    attachedObjects: [
        Net {
            id: netmgr
        },

        ComponentDefinition {
            id: para
            Label {
                multiline: true
                textStyle.textAlign: TextAlign.Left
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle.fontSizeValue: pageroot.basetextsize
                textStyle.fontSize: FontSize.PercentageValue
                implicitLayoutAnimationsEnabled: false
                //                text:  "<html><b>Cascades</b> is <i>awesome!</i></html>"
            }
        },

        ComponentDefinition {
            id: graph
            WebImageView {
                id: wiv
                preferredWidth: 1000
                scalingMethod: ScalingMethod.AspectFit
                horizontalAlignment: HorizontalAlignment.Center
                implicitLayoutAnimationsEnabled: false
                gestureHandlers: TapHandler {
                    onTapped: {
                        _app.viewimage(wiv.getCachedPath())
                    }
                }
            }
        },
        QtObject {
            id: imp

            function getImage(newsDetail, imgLabel) {
                var imgArrs = newsDetail["img"]
                if (imgArrs) {
                    for (var i = 0; i < imgArrs.length; i ++) {
                        var img = imgArrs[i];
                        if (img["ref"] == imgLabel) {
                            return img
                        }
                    }
                }
            }

            function getLink(newsDetail, linkPara) {
                var linksArr = newsDetail["link"]
                if (linksArr) {
                    for (var i = 0; i < linksArr.length; i ++) {
                        var link = linksArr[i];
                        if (link["ref"] == linkPara) {
                            return link
                        }
                    }
                }
            }

            function processNetease(txt) {
                var newsJson = JSON.parse(txt);
                var details = newsJson[post_id];
                var rb = details.replyBoard
                board_id = rb ? rb : ""     //此处有可能无replyBoard字段，为禁止跟帖的新闻
                var paras = details.body.split(/<\/?p>/);
                paras = paras.filter(function(p) {
                        return (p != undefined) && (p != "")
                    }).map(function(p, index) {
                        return p.trim(); //.replace("<b>", "<html><b>").replace("</b>", "</b></html>")
                    })
                console.log(paras.length);
                for (var i = 0; i < paras.length; i ++) {
                    var p = paras[i];
                    //                    console.log("para "+i+p);
                    if (p.indexOf("<!--IMG") >= 0) {
                        var imgs = p.match(/<!--IMG#\d+-->/gi)
                        imgs.forEach(function(imgLabel) {
                                var imginfo = getImage(details, imgLabel)
                                if (imginfo) {
                                    var image2add = graph.createObject(pageroot);
                                    image2add.url = imginfo["src"];
                                    holder.add(image2add);
                                }
                            })
                    } else if (p.indexOf("<!--link") >= 0) {
                        var link = getLink(details, p)
                        p = p.replace(/<!--link\d+-->/gi, "")
                        var text2add = para.createObject(pageroot)
                        text2add.text = "<html><a href='" + link["href"] + "'>" + p + "</a></html>"; //!! <html>前加空格无法显示html
                        holder.add(text2add)
                    } else {
                        var text2add = para.createObject(pageroot)
                        text2add.text = "<html>" + p + "</html>"; //!! <html>前加空格无法显示html
                        holder.add(text2add)
                    }
                    console.log(p)
                }
            }

            function process(txt) {
                holder.removeAll();
                processNetease(txt)
                console.log("process over.")
            }

        }
    ]

    actionBarVisibility: ChromeVisibility.Overlay
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll

    ScrollView {
        id: scrollView
        Container {
            leftPadding: 20.0
            rightPadding: 20.0
            Header {
                title: source_txt
                subtitle: pub_date

            }
            Label {
                text: page_title
                textStyle.fontSize: FontSize.XLarge
                multiline: true
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                textFit.mode: LabelTextFitMode.Default
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle.color: ui.palette.primaryDark
                bottomMargin: 30.0
            }

            //            Label {
            //                text: "　　" + page_description
            //                multiline: true
            //                textStyle.fontSizeValue: pageroot.basetextsize * 0.95
            //                textStyle.fontSize: FontSize.PercentageValue
            //                opacity: 0.8
            //            }
            //            Divider {
            //                topMargin: 20.0
            //                bottomMargin: 20.0
            //            }
            Container {
                id: holder
                horizontalAlignment: HorizontalAlignment.Fill
                //                Label {
                //                    text: qsTr("Loading ...")
                //                    textStyle.textAlign: TextAlign.Center
                //                    horizontalAlignment: HorizontalAlignment.Center
                //                    textStyle.fontWeight: FontWeight.W100
                //
                //                }
                WebView {
                    html: qsTr("Loading ...")
                }
            }
            Divider {
                opacity: 0.1
                topMargin: 150.0
            }
        }
    }

    actions: [
        ActionItem {
            id: refresh
            title: "刷新"
            enabled: true
            imageSource: "asset:///icons/ic_reload.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                u += " "
            }
        }, // ActionItem
        ActionItem {
            id: view_comments
            title: "查看跟帖"
            property string lastFileName: ""
            enabled: true
            imageSource: "asset:///icons/ic_view_post.png"
            ActionBar.placement: ActionBarPlacement.Signature
            onTriggered: {
                var wbv = Qt.createComponent("comments.qml").createObject(navroot);
                if (board_id) {
                    wbv.u = "http://comment.api.163.com/api/json/post/list/new/hot/" + board_id + "/" + post_id + "/0/10/10/2/2";
                    wbv.page_title = page_title
                    navroot.push(wbv);
                }
            }
        }, // ActionItem
        ActionItem {
            id: write_comment
            title: "跟帖"
            enabled: true
            imageSource: "asset:///icons/ic_compose.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
            }
        } // ActionItem
    ]
}
