/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.4
import cn.anpho 1.0
import bb.system 1.2

// the first control is a NavigationPane this in order to drill down in the lists.
NavigationPane {
    id: navroot
//    property QString news_type
//    property QString type_title
//    property QString type_name
    Page {
        id: pageroot
        property int basetextsize: _app.getv("fontsize", "100")
        titleBar: TitleBar {
            // Localized text with the dynamic translation and locale updates support
            title: qsTr(_app.newsClassName+"新闻") + Retranslate.onLocaleOrLanguageChanged
            scrollBehavior: TitleBarScrollBehavior.NonSticky
        }
        actionBarVisibility: ChromeVisibility.Compact
        actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
        onCreationCompleted: {
            _app.returned.connect(appendData)
        }
        property bool loading: false
        function appendData(success, resp) {
            loading = false
            if (success) {
                var dobj = JSON.parse(resp);
                var items = dobj[_app.newsClassId];
                if (items.length > 0) {
                    console.log(items.length)
                    adm.append(items);
                } else {
                    errormsg("no data")
                }
            } else {
                errormsg(resp)
            }
        }
        function errormsg(msg) {
            ssd.err = msg;
            ssd.show();
        }
        attachedObjects: [
            SystemToast {
                id: sst
            },
            Net {
                id: net
            },
            SystemDialog {
                id: ssd
                property string err
                title: qsTr("ERROR")
                body: qsTr("Error fetching data, Server response is [%1], please check your internet connection.").arg(err)
                includeRememberMe: false
                confirmButton.label: qsTr("Reload")
                cancelButton.label: qsTr("Cancel")
                customButton.label: qsTr("Exit App")
                customButton.enabled: true
                confirmButton.enabled: true
                cancelButton.enabled: true
                onFinished: {
                    switch (value) {
                        case SystemUiResult.ConfirmButtonSelection:
                            lv_main.resetData()
                            break;
                        case SystemUiResult.CustomButtonSelection:
                            Application.requestExit()
                            break;
                    }
                }
            }
        ]
        
        ListView {
            id: lv_main
            dataModel: ArrayDataModel {
                id: adm
            }
            property int start_index: 0
            property string endpoint: "http://c.m.163.com/nc/article/headline/" + _app.newsClassId + "/"
//            property string endpoint: "http://c.3g.163.com/nc/article/list/" + _app.newsType + "/"

            function resetData() {
                adm.clear();
                pageroot.loading = false;
                start_index = 0;
                load()
            }
            function load() {
                if (pageroot.loading) {
                    return
                }
//                var params = [ "type=all" ];
//                params.push("page=" + page);
//                //                var endp = endpoint + "?" + params.join("&");
                var endp = endpoint + start_index + "-20.html";
                console.log(endp);
                pageroot.loading = true;
                _app.get(endp);
                
            }
            scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
            leftPadding: 20.0
            rightPadding: 20.0
            bottomPadding: 50.0
            horizontalAlignment: HorizontalAlignment.Fill
            scrollRole: ScrollRole.Main
            onCreationCompleted: {
                resetData()
            }
            onTriggered: {
                var selected = adm.data(indexPath);
                if(selected.skipType=="photoset"){
                    var photosetID = selected.photosetID
                    var id1 = photosetID.substr(4,4)
                    var id2 = photosetID.substring(6,)
                    var urltoopen = "http://c.3g.163.com/photo/api/set/"+id1+"/"+id2+"json";
                    var wbv = Qt.createComponent("photos_viewer.qml").createObject(navroot);
                    wbv.u = urltoopen;
                    wbv.post_id = selected.postid
                    wbv.source_txt = selected.source
                    wbv.page_title = selected.title //selected.title.replace(/<.*?>/ig, "")
                    wbv.pub_date = selected.ptime
                    navroot.push(wbv);    
                }else{
                    var urltoopen = "http://c.m.163.com/nc/article/" + selected.postid + "/full.html";
                    var wbv = Qt.createComponent("viewer.qml").createObject(navroot);
                    wbv.u = urltoopen;
                    wbv.post_id = selected.postid
                    wbv.source_txt = selected.source
                    wbv.page_description = selected.digest //selected.hometext.replace(/<.*?>/ig, "")
                    wbv.page_title = selected.title //selected.title.replace(/<.*?>/ig, "")
                    wbv.pub_date = selected.ptime
                    navroot.push(wbv);
                }
            }
            attachedObjects: [
                ListScrollStateHandler {
                    onScrollingChanged: {
                        if (scrolling && atEnd) {
                            lv_main.start_index += 20;
                            lv_main.load()
                        }
                    }
                }
            ]
            property int font_size: pageroot.basetextsize
            listItemComponents: [
                ListItemComponent {
                    id: lcroot
                    Container {
                        id: croot
                        bottomMargin: 20
                        Label {
                            text: ListItemData.title //.replace(/<.*?>/ig, "")
                            multiline: true
                            textStyle.fontSize: FontSize.XLarge
                            textStyle.color: ui.palette.primaryDark
                            verticalAlignment: VerticalAlignment.Top
                            horizontalAlignment: HorizontalAlignment.Fill
                        }
                        Label {
                            text: ListItemData.digest
                            textFormat: TextFormat.Html
                            multiline: true
                            textStyle.fontSizeValue: croot.ListItem.view.font_size * 0.95
                            textStyle.fontSize: FontSize.PercentageValue
                            bottomMargin: 15.0
                            textStyle.textAlign: TextAlign.Justify
                        }
                        Container {
                            layout: DockLayout {
                            }
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Bottom
                            Label {
                                text: ListItemData.source
                                textStyle.fontSize: FontSize.XSmall
                                textStyle.fontWeight: FontWeight.W200
//                                textStyle.fontStyle: FontStyle.Italic
                                textStyle.textAlign: TextAlign.Left
                                horizontalAlignment: HorizontalAlignment.Left
                            }
                            Label {
                                text: ListItemData.replyCount + "评论"
                                textStyle.fontSize: FontSize.XSmall
                                textStyle.fontWeight: FontWeight.W200
//                                textStyle.fontStyle: FontStyle.Italic
                                textStyle.textAlign: TextAlign.Center
                                horizontalAlignment: HorizontalAlignment.Center
                            }
                            Label {
                                text: ListItemData.ptime
                                textStyle.fontSize: FontSize.XSmall
                                textStyle.fontWeight: FontWeight.W200
//                                textStyle.fontStyle: FontStyle.Italic
                                textStyle.textAlign: TextAlign.Right
                                horizontalAlignment: HorizontalAlignment.Right
                            }
                        }

                        Divider {

                        }

                    }
                }
            ]
        }
    
        actions: [
            ActionItem {
                id: profile
                title: "个人资料"
                enabled: false
                //            imageSource: "asset:///images/icon.png"
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: {
                }
            }, // ActionItem
            ActionItem {
                id: login
                title: "登录"
                enabled: false
                //            imageSource: "asset:///images/icon.png"
                ActionBar.placement: ActionBarPlacement.InOverflow
                onTriggered: {
                }
            } // ActionItem
        ]
    }

    onPopTransitionEnded: {
        // Destroy the popped Page once the back transition has ended.
        page.destroy();
        pageroot.basetextsize = _app.getv("fontsize", "100");
    }
}
