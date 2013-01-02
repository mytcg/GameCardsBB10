import bb.cascades 1.0

Page {
    id: shopPage
        signal cancel ()
        
        titleBar: TitleBar {
            title: "Shop"
            visibility: ChromeVisibility.Visible
            
            acceptAction: ActionItem {
                title: "Back"
                onTriggered: {
                    shopPage.cancel();
                }
            }
        }
   Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: shopLabel
            objectName: "shopLabel"
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
                        title: ListItemData.albumname + ", " +
ListItemData.firstName
                        description: ListItemData.employeeNumber
                    }
                }
            ]
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadProductsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
    onCreationCompleted: {
        shopClass.loadProducts()
    }
}
