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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: friendsLabel
            objectName: "friendsLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "friendsView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            layout: FlowListLayout {
            
            }
            
            listItemComponents: [
                ListItemComponent {
                    type: "listItem"
                    StandardListItem {
                        title: ListItemData.usr + ", " +
ListItemData.val
                        description: ListItemData.desc
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
