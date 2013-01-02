import bb.cascades 1.0

Page {
    id: notificationsPage
        signal cancel ()
        
        titleBar: TitleBar {
            title: "Notifications"
            visibility: ChromeVisibility.Visible
            
            acceptAction: ActionItem {
                title: "Back"
                onTriggered: {
                    notificationsPage.cancel();
                }
            }
        }
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: notificationsLabel
            objectName: "notificationsLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "listView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            layout: FlowListLayout {
            
            }
            
            listItemComponents: [
                ListItemComponent {
                    type: "listItem"
                    StandardListItem {
                        title: ListItemData.desc + ", " +
ListItemData.firstName
                        description: ListItemData.employeeNumber
                    }
                }
            ]
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadNotificationsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
    onCreationCompleted: {
        notificationsClass.loadNotifications();
    }
}
