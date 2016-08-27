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

TabbedPane {
    id: mainTab
    onCreationCompleted: {
        Application.setCover(multiCover)
    }
    attachedObjects: [
        MultiCover {
            id: multiCover
            
            SceneCover {
                id: bigCover
                // Use this cover when a large cover is required
                MultiCover.level: CoverDetailLevel.High
                content: Container {
                    // Your large cover layout
                    background: Color.create("#DA2B2B")
                    Label {
                        id: largeCoverText
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: "头条新闻"
                        textStyle.color: Color.White
                        textStyle.fontSizeValue: 20.0
                    }
                }
                function update() {
                    // Update the large cover dynamically
                    largeCoverText.text = _app.newsClassName+"新闻"
                }
            } // sceneCover HIGH
            
            SceneCover {
                id: smallCover
                // Use this cover when a small cover is required
                MultiCover.level: CoverDetailLevel.Medium
                content: Container {
                    // Your small cover layout
                    background: Color.create("#DA2B2B")
                    Label {
                        id: smallCoverText
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: "头条"
                        textStyle.color: Color.White
                        textStyle.fontSizeValue: 5.0
                    }
                }
                function update() {
                    // Update the small cover dynamically
                    smallCoverText.text = _app.newsClassName
                }
            } // sceneCover MEDIUM
            
            function update() {
                bigCover.update()
                smallCover.update()
            }
        }
    ]
    
//    property NavigationPane np
    showTabsOnActionBar: false
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settingspage = Qt.createComponent("settings.qml").createObject(mainTab);                
//                settingspage.nav = navroot;
//                np.push(settingspage)
            }
        }
        helpAction: HelpActionItem {
            onTriggered: {
                var aboutpage = Qt.createComponent("about.qml").createObject(mainTab);
//                np.push(aboutpage)
            }
        }
    }
    Tab {
        id: tabHead
        title: "头条"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateHead
//                        News {
            //                type_title: tabHead.title
            //                news_type: "T1453256275238"
//                        }
            source: "News.qml"

        }
        onTriggered: {
            _app.newsClassId = "T1453256275238"
            multiCover.update()
        }
    }
    Tab {
        id: tabSelected
        title: "精选"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateSelected
            //            News {
            //                type_title: tabSociety.title
            //                news_type: "T1295505301714"
            //            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1467284926140"
            multiCover.update()
        }
    }
    Tab {
        id: tabSociety
        title: "社会"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateSociety
//            News {
//                type_title: tabSociety.title
//                news_type: "T1295505301714"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453269751664"
            multiCover.update()
        }
    }

    Tab {
        id: tabFinance
        title: "财经"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateFinance
//            News {
//                type_title: tabFinance.title
//                news_type: "T1295505705196"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453256688395"
            multiCover.update()
        }
    }

    Tab {
        id: tabScience
        title: "科技"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateScience
//            News {
//                type_title: tabScience.title
//                news_type: "T1295507084100"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453256766468"
            multiCover.update()
        }
    }

    Tab {
        id: tabEntertain
        title: "娱乐"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateEntertain
//            News {
//                type_title: tabEntertain.title
//                news_type: "T1295506658957"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453255581705"
            multiCover.update()
        }
    }

    Tab {
        id: tabSports
        title: "体育"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateSports
//            News {
//                type_title: tabSports.title
//                news_type: "T1295505916992"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453256532098"
            multiCover.update()
        }
    }

    Tab {
        id: tabAuto
        title: "汽车"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateAuto
//            News {
//                type_title: tabAuto.title
//                news_type: "T1295507338077"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453259252417"
            multiCover.update()
        }
    }

    Tab {
        id: tabMilitary
        title: "军事"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateMilitary
//            News {
//                type_title: tabMilitary.title
//                news_type: "T1295505447897"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453259453966"
            multiCover.update()
        }
    }
//    Tab {
//        id: tabPics
//        title: "图片"
//        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
//        delegate: Delegate {
//            id: tabDelegatePics
//            //            News {
//            //                type_title: tabMilitary.title
//            //                news_type: "T1295505447897"
//            //            }
//            source: "News.qml"
//        }
//        onTriggered: {
//            _app.newsClassId = "T1453260901051"
//        }
//    }
    Tab {
        id: tabHistory
        title: "历史"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateHistory
            //            News {
            //                type_title: tabMilitary.title
            //                news_type: "T1295505447897"
            //            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1453259573806"
            multiCover.update()
        }
    }
}
