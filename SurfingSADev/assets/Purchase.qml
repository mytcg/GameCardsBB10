import bb.cascades 1.0


Page {
    id: purchasePage
    signal cancel ()
    
    property string productId: "0";
    property string purchaseType: "3";
    
    property alias productNameLabeltext: productNameLabel.text
    property alias productCostLabeltext: productCostLabel.text
    property alias productNumCardsLabeltext: productNumCardsLabel.text
    property alias productTypeLabeltext: productTypeLabel.text
    
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
        leftPadding: 20
        rightPadding: 20
        topPadding: 10
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        Label{
            id: productNameLabel
        }
        Label{
            id: productCostLabel
        }
        Label{
            id: productNumCardsLabel
        }
        Label{
            id: productTypeLabel
            bottomMargin: 20
        }
        
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
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
