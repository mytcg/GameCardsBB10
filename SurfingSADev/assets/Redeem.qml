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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: redeemLabel
            objectName: "redeemLabel"
            text: ""
        }
        Label {
            text: "Redeem Code:"
            textStyle.fontSizeValue: 0.0
        }
        TextField {
            id: redeemText
            objectName: "redeemText"
            text: ""
        }
        Button {
            id: redeem
            text: "Redeem"
            onClicked: redeemClass.redeem(redeemText.text)
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
