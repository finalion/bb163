import bb.cascades 1.4

Container {
    layout: StackLayout {
        //        orientation: LayoutOrientation.LeftToRight
    
    }
    bottomMargin: 20.0
    property alias author:post_author.text
    property alias time: post_time.text
    property alias votes: post_votes.text
    property alias content: post_text.text
    //    property alias avata_url: wiv.imageSource

    Label { 
        id: post_author
        text: "xixi"
        multiline: true
        textStyle.textAlign: TextAlign.Left
        horizontalAlignment: HorizontalAlignment.Left
//        textStyle.fontSizeValue: pageroot.basetextsize
        textStyle.fontSize: FontSize.XSmall
        opacity: 0.8
    }
    
    Container {
        layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
        }
        horizontalAlignment: HorizontalAlignment.Fill

        Label { 
            id: post_time
            text: "2014.7.28"
            multiline: true
            textStyle.textAlign: TextAlign.Left
            horizontalAlignment: HorizontalAlignment.Center
//            textStyle.fontSizeValue: pageroot.basetextsize
            textStyle.fontSize: FontSize.XSmall
            opacity: 0.8
        }
        Label { 
            id: post_votes
            text: "100000"
            multiline: true
            textStyle.textAlign: TextAlign.Left
            horizontalAlignment: HorizontalAlignment.Right
//            textStyle.fontSizeValue: pageroot.basetextsize
            textStyle.fontSize: FontSize.XSmall
            opacity: 0.8
        }
    
    }
    
    Label { 
        id: post_text
        text: "text text text text text text"
        multiline: true
        textStyle.textAlign: TextAlign.Left
        horizontalAlignment: HorizontalAlignment.Fill
//        textStyle.fontSizeValue: pageroot.basetextsize
        textStyle.fontSize: FontSize.Medium
    }
    //    Label { 
    //        id: post_votes
    //        text: "votes"
    //        textStyle.textAlign: TextAlign.Center
    //        horizontalAlignment: HorizontalAlignment.Fill
    //        textStyle.fontSizeValue: pageroot.basetextsize
    //        textStyle.fontSize: FontSize.PercentageValue
    //    } 
    
    //    Container {
    //        rightMargin: 10.0
    //        ImageView {
    //            id: wiv
    //            preferredWidth: 200
    //            scalingMethod: ScalingMethod.AspectFit 
    //            horizontalAlignment: HorizontalAlignment.Center 
    //            implicitLayoutAnimationsEnabled: false
    ////            gestureHandlers: TapHandler {
    ////                onTapped: {
    ////                    _app.viewimage(wiv.getCachedPath())
    ////                }
    ////            }
    //        }
    //        Label { 
    //            id: post_votes
    //            text: "votes"
    //            textStyle.textAlign: TextAlign.Center
    //            horizontalAlignment: HorizontalAlignment.Fill
    //            textStyle.fontSizeValue: pageroot.basetextsize
    //            textStyle.fontSize: FontSize.PercentageValue
    //        } 
    //    }
    //    Container {
    //        Header {
    //            id: header
    //            title: "author"
    //            subtitle: "time"
    //        }
    //        Label { 
    //            id: post_text
    //            text: "text"
    //            multiline: true
    //            textStyle.textAlign: TextAlign.Left
    //            horizontalAlignment: HorizontalAlignment.Fill
    //            textStyle.fontSizeValue: pageroot.basetextsize
    //            textStyle.fontSize: FontSize.PercentageValue
    //        }
    //
    //    }
    Divider {
    
    }
}
