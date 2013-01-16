import bb.cascades 1.0


Page {
    id: purchasePage
    signal cancel ()
    
    property string productId: "0";
    property string purchaseType: "false";
    
    titleBar: TitleBar {
        title: "Shop"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                purchasePage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        Label {
            id: cardLabel
            objectName: "cardLabel"
            text: "0"
            visible: false
        }
        ImageView {
            id: boosterView
            objectName: "boosterView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            imageSource: "asset:///images/loading.png"
        
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            text: "Purchase"  
            onClicked: {
                 purchaseClass.purchase(productId,purchaseType);
            }
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            text: "Cards"
            onClicked: {
                            
            } 
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadCardIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
    attachedObjects: [
        Sheet {
            id: optionsSheet
            
            /*AlbumView{
            id: albumView
            
            onCancel: {
            albumViewSheet.close();
            }
            }*/
        }
    ]
}
