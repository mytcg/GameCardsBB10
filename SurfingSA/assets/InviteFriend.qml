import bb.cascades 1.0

Page {
    id: invitefriendPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Invite Friend"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                inviteFriendLabel.text = "";
                usernameText.text = "";
                emailText.text = "";
                numberText.text = "";
                invitefriendPage.cancel();
            }
        }
    }
        Container {
                layout: DockLayout {
                    
                }
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            topPadding: 10
            
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Label {
                text: "Invite by Username:"
                textStyle.fontSizeValue: 0.0
            }
            TextField {
                id: usernameText
                objectName: "usernameText"
                
                text: ""
            }
            Label {
                text: "Invite by Email:"
            }
            TextField {
                id: emailText
                objectName: "emailText"
                
                text: ""
            }
            Label {
                text: "Invite by Phone Number:"
            }
            TextField {
                id: numberText
                objectName: "numberText"
                
                text: ""
            }
            Label {
                id: inviteFriendLabel
                objectName: "inviteFriendLabel"
                text: "0"
                visible: false
            }
            Button {
                id: invite
                text: "Invite"
                onClicked: invitefriendClass.inviteFriend(usernameText.text,emailText.text,numberText.text)
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "inviteFriendIndicator"
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