import bb.cascades 1.0

Page {
    id: creditsPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Credits"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                creditsPage.cancel();
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
            leftPadding: 20
            rightPadding: 20
            topPadding: 10
            
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
                        
            Label {
                id: creditsLabel
                objectName: "creditsLabel"
                text: "0"
                visible: false
            }
            Label{
                text: "Credits"
                horizontalAlignment: HorizontalAlignment.Center
            }
            TextField {
                id: creditsText
                objectName: "creditsText"
                text: "0"
                enabled: false
            }
            Label{
                text: "Premium"
                horizontalAlignment: HorizontalAlignment.Center
            }
            TextField {
                id: premiumText
                objectName: "premiumText"
                text: "0"
                enabled: false
            }
            ListView {
                objectName: "creditsView"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                layout: FlowListLayout {
                
                }
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container{
                            touchPropagationMode: TouchPropagationMode.Full
                            rightPadding: 5.0
                            topPadding: 5.0
                            bottomPadding: 5.0
                            leftPadding: 5.0
                            Label{
                                text:  ListItemData.desc
                            }
                            Divider {
                                verticalAlignment: VerticalAlignment.Bottom
                                horizontalAlignment: HorizontalAlignment.Center  
                            }
                        }
                    }
                ]
            }
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadCreditsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }
    }
}
