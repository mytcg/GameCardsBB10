import bb.cascades 1.0

Page {
    id: invitefriendPage
    property NavigationPane navParent: null
    signal cancel ()

    /*titleBar: TitleBar {
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
    }*/
    Container {
        layout: DockLayout {
            
        }
        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
            }
        ]

        background: backgroundPaint.imagePaint
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            Container {
                layout: DockLayout {
                }

                ImageView {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    imageSource: "asset:///images/header/header.png"
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    topPadding: 20
                    Label {
                        text: "INVITE FRIEND"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

            Container {
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
                    textStyle.color: Color.DarkGray
                }
                TextField {
                    id: usernameText
                    objectName: "usernameText"

                    text: ""
                }
                Label {
                    text: "Invite by Email:"
                    textStyle.color: Color.DarkGray
                }
                TextField {
                    id: emailText
                    objectName: "emailText"

                    text: ""
                }
                Label {
                    text: "Invite by Phone Number:"
                    textStyle.color: Color.DarkGray
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
                /*Button {
                 * id: invite
                 * text: "Invite"
                 * onClicked: invitefriendClass.inviteFriend(usernameText.text,emailText.text,numberText.text)
                 * horizontalAlignment: HorizontalAlignment.Center
                 * }*/
            }
        }
        
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "inviteFriendIndicator"
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
            title: "Invite Friend"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                invitefriendClass.inviteFriend(usernameText.text, emailText.text, numberText.text)
            }
            imageSource: "asset:///images/actionicons/invite.png"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                inviteFriendLabel.text = "";
                usernameText.text = "";
                emailText.text = "";
                numberText.text = "";
                navParent.pop();
            }
        }
    }
}
