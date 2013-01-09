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
            objectName: "shopView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.productname 
                        description: "Credits: " + ListItemData.productprice + "  Cards: "+ListItemData.productnumcards
                        imageSpaceReserved: true
                        imageSource: "asset:///images/loadingthumb.png"
                        minHeight: 66
                        onCreationCompleted: imageLoaderClass.loadImage(ListItemData.productthumb,this)
                    }
                 /*   Container {
                        Label { text: ListItemData.productname }
                        Label { text: "Credits: " + ListItemData.productprice }
                        Label { text: "Cards: " + ListItemData.productnumcards }
                    }*/
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
}
