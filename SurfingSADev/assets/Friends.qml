import bb.cascades 1.0

Page {
    id: friendsPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Friends"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                friendsPage.cancel();
            }
        }
    }
    Container {
        layout: DockLayout {
        }
        Label {
            id: friendsLabel
            objectName: "friendsLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "friendsView"
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
            layout: FlowListLayout {
            
            }
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    /*StandardListItem {
                    
                    description: ListItemData.usr + "\n" +
                    ListItemData.val+ "\n" +ListItemData.desc
                    
                    }*/
                    Container{
                        touchPropagationMode: TouchPropagationMode.Full
                        rightPadding: 5.0
                        topPadding: 5.0
                        bottomPadding: 5.0
                        leftPadding: 5.0
                        Label{
                            text:  ListItemData.usr
                        }
                        Label{
                            text:  ListItemData.val
                        }
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
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadFriendsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
}
