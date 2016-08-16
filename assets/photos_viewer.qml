import bb.cascades 1.4
import cn.anpho 1.0
import bb.device 1.3
Page {
    id: pageroot
    property string u
    onUChanged: {
        u = u.trim()
        scrollView.scrollToPoint(0.0, 0.0)
        if (u.length > 0) {
            console.log("Loading " + u)
            netmgr.ajax("GET", u, [], function(b, d) {
                    if (b) {
                        console.log("ok....." + d)
                        imp.process(d)
                    }
                })
        } else {
            console.log("url error")
        }
    }

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

        QtObject {
            id: imp

            function processNeteasePhotos(txt) {
                var json = JSON.parse(txt);
                board_id = json["boardid"]
                var photosArr = json["photos"];
                adm.append(photosArr);
            }

            function process(txt) {
                processNeteasePhotos(txt)
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

            ListView {
                id: lv_photos
                dataModel: ArrayDataModel {
                    id: adm
                }
                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
                leftPadding: 20.0
                rightPadding: 20.0
                bottomPadding: 50.0
                horizontalAlignment: HorizontalAlignment.Fill
                scrollRole: ScrollRole.Main
                onCreationCompleted: {
                    console.log("Phots Listview created. ")
                }

                onTriggered: {
                    var selected = adm.data(indexPath);
                    // to reserve
                }

                attachedObjects: [
                    ListScrollStateHandler {
                        onScrollingChanged: {
                            if (scrolling && atEnd) {
                                // to reserve
                            }
                        }
                    }
                ]

                function getContext() {
                    return _app;
                }

                property int font_size: pageroot.basetextsize
                listItemComponents: [
                    ListItemComponent {
                        id: lcroot
                        Container {
                            id: croot
                            bottomMargin: 20
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            attachedObjects: [
                                DisplayInfo {
                                    id: displayInfo
                                }
                            ]
                            WebImageView {
                                id: wiv_photo
                                url: ListItemData["imgurl"]
                                preferredWidth: displayInfo.pixelSize.width
                                scalingMethod: ScalingMethod.AspectFit
                                horizontalAlignment: HorizontalAlignment.Center
                                implicitLayoutAnimationsEnabled: false
                                gestureHandlers: TapHandler {
                                    onTapped: {
                                        croot.ListItem.view.getContext().viewimage(wiv_photo.getCachedPath());
                                    }
                                }
                            }
                            Label {
                                text: ListItemData["note"]
                                multiline: true
                                textStyle.fontWeight: FontWeight.W200
                                //                                textStyle.fontStyle: FontStyle.Italic
                                textStyle.textAlign: TextAlign.Left 
                                textStyle.fontSizeValue: croot.ListItem.view.font_size* 0.95
                                textStyle.fontSize: FontSize.PercentageValue
                                horizontalAlignment: HorizontalAlignment.Fill
                            }

                            Divider {
                                opacity: 0.8
                                topMargin: 20.0
                            }
                        }
                    }
                ]
            }
            Divider {
                opacity: 0.8
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
                wbv.u = "http://comment.api.163.com/api/json/post/list/new/hot/" + board_id + "/" + post_id + "/0/10/10/2/2";
                wbv.page_title = page_title
                navroot.push(wbv);
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
