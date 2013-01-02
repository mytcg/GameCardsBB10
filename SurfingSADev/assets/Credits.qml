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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: creditsLabel
            objectName: "creditsLabel"
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
            objectName: "loadCreditsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
    onCreationCompleted: {
        creditsClass.loadCredits();
    }
}
