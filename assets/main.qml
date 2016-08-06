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
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                var settingspage = Qt.createComponent("settings.qml").createObject(navroot);
                settingspage.nav = navroot;
                navroot.push(settingspage)
            }
        }
        helpAction: HelpActionItem {
            onTriggered: {
                var aboutpage = Qt.createComponent("about.qml").createObject(navroot);
                navroot.push(aboutpage)
            }
        }
    }

    showTabsOnActionBar: false

    Tab {
        id: tabHead
        title: "头条"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateHead
            //            News {
            ////                type_title: tabHead.title
            ////                news_type: "T1295501906343"
            //            }
            source: "News.qml"

        }
        onTriggered: {
            _app.newsClassId = "T1295501906343"
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
            _app.newsClassId = "T1295505301714"
        }
    }

    Tab {
        id: tabDomestic
        title: "国内"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateDomestic
//            News {
//                type_title: tabDomestic.title
//                news_type: "T1295505330581"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1295505330581"
        }
    }

    Tab {
        id: tabInternational
        title: "国际"
        delegateActivationPolicy: TabDelegateActivationPolicy.ActivateWhenSelected
        delegate: Delegate {
            id: tabDelegateInternational
//            News {
//                type_title: tabInternational.title
//                news_type: "T1295505403327"
//            }
            source: "News.qml"
        }
        onTriggered: {
            _app.newsClassId = "T1295505403327"
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
            _app.newsClassId = "T1295505705196"
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
            _app.newsClassId = "T1295507084100"
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
            _app.newsClassId = "T1295506658957"
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
            _app.newsClassId = "T1295505916992"
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
            _app.newsClassId = "T1295507338077"
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
            _app.newsClassId = "T1295505447897"
        }
    }
}
