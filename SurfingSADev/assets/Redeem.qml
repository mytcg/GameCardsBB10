import bb.cascades 1.0

Page {
    id: redeemPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Redeem"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        layout: DockLayout {
     
        }
        background: Color.create("#ededed");
        
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            topPadding: 10
            
            Label {
                text: "Redeem Code:"
                textStyle.fontSizeValue: 0.0
                textStyle.fontFamily: "SlatePro-Condensed"
            }
            TextField {
                id: redeemText
                objectName: "redeemText"
                hintText: "Enter redeem code"
            }
            Label {
                id: redeemLabel
                objectName: "redeemLabel"
                text: "0"
                visible: false
            }
        }

        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "redeemIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
                //cancelScreen()
            }
        }
    }
    actions: [
        ActionItem {
            title: "Redeem"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                redeemClass.redeem(redeemText.text)
            }
        }
    ]
}
