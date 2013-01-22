import bb.cascades 1.0

Page {
    id: redeemPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Redeem"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                redeemLabel.text = "";
                redeemText.text = "";

                redeemPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
     
        }
        
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
            Button {
                id: redeem
                text: "Redeem"
                onClicked: redeemClass.redeem(redeemText.text)
                horizontalAlignment: HorizontalAlignment.Center
            }
        }

        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "redeemIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
                //cancelScreen()
            }
        }
    }
}
