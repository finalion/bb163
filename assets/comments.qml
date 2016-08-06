import bb.cascades 1.4
import cn.anpho 1.0
Page {
    property string u
    onUChanged: {
        if (u.length > 0) {
            console.log("Loading " + u)
            netmgr.ajax("GET", u, [], function(b, d) {
                    if (b) {
                        imp.processComments(d)
                    }
                })
        }
    }
    id: pageroot
    property int basetextsize: _app.getv("fontsize", "100")
    property string post_id: ""
    property string page_title: ""
    attachedObjects: [
        Net {
            id: netmgr
        },
        
        ComponentDefinition {
            id: graph
            WebImageView {
                id: wiv
                preferredWidth: 100
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
                
        ComponentDefinition {
            id: post
            Post {
                horizontalAlignment: HorizontalAlignment.Fill
            }
        },
        
        
        QtObject {
            id: imp               
            function processNeteaseComments(txt){
                var commentsJson = JSON.parse(txt);
                var hotPosts = commentsJson.hotPosts;
                for(var i=0; i<hotPosts.length;i++){
                    var hotPost = hotPosts[i];
                    var hotPost1 = hotPost["1"]
//                    var avatar2add = graph.createObject(pageroot)
//                    var timg = hotPost1["timg"]
//                    if(timg){
//                        avatar2add.url = timg;
//                    }
//                    holderImg.add(avatar2add)
                    
                    var post2add = post.createObject(pageroot)
                    post2add.author = hotPost1["f"].replace("&nbsp;","     ")
                    post2add.time = hotPost1["t"];
                    post2add.content = hotPost1["b"]
                    post2add.votes = hotPost1["v"]+"赞";
                    console.log("---->",post2add.author)
                    holder.add(post2add)
                }
            }
            
            function processComments(txt){
                holder.removeAll();
                processNeteaseComments(txt)
                console.log("process over.")
            }

        }
    ]

    actionBarVisibility: ChromeVisibility.Overlay
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    
    ScrollView {
        Container {
            leftPadding: 20.0
            rightPadding: 20.0
            
            Label {
                text: page_title
                textStyle.fontSize: FontSize.Large
                multiline: true
                textStyle.fontWeight: FontWeight.W100
                textStyle.textAlign: TextAlign.Center
                textFit.mode: LabelTextFitMode.Default
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle.color: ui.palette.primaryDark
            }

            Divider {
                topMargin: 20.0
                bottomMargin: 20.0
            }
            Container {
                id: holder
//                layout: StackLayout {
//                    orientation: LayoutOrientation.LeftToRight
//                
//                }
                horizontalAlignment: HorizontalAlignment.Fill
//                Container {
//                    id: holderImg
//                    horizontalAlignment: HorizontalAlignment.Fill
//                }
                Label {
                    text: qsTr("Loading ...")
                    textStyle.textAlign: TextAlign.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle.fontWeight: FontWeight.W100

                }
            }
        }
    }
    
    actions: [
        ActionItem {
            id: write_comment
            title: "跟帖"
            enabled: true
            imageSource: "asset:///icons/ic_compose.png"
            ActionBar.placement: ActionBarPlacement.Signature
            onTriggered: {
            }
        } // ActionItem
    ]
}
