import bb.cascades 1.0


Page {
    id: purchasePage
    signal cancel ()
    
    property string productId: "0";
    property string purchaseType: "3";
    
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
                purchasedSheet.open();
                purchaseClass.purchase(productId,purchaseType);
            }
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            text: "Cards"
            onClicked: {
                boosterSheet.open();
                boosterClass.booster(productId);
            } 
        }
    
    }
    attachedObjects: [
        Sheet {
            id: purchasedSheet
            
            Purchased{
                id: purchasedView
                
                onCancel: {
                    purchasedSheet.close();
                }
            }
        },Sheet {
            id: boosterSheet
            
            Booster{
                id: booster
                
                onCancel: {
                    boosterSheet.close();
                }
            }
        }
    ]
}
