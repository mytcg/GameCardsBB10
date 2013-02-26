import bb.cascades 1.0


Page {
    id: purchasePage
    property NavigationPane navParent: null
    property Page purchasedPage: null
    property Page boosterPage: null
    signal cancel ()
    
    property string productId: "0";
    property string purchaseType: "3";
    
    property alias productNameLabeltext: productNameLabel.text
    property alias productCostLabeltext: productCostLabel.text
    property alias productNumCardsLabeltext: productNumCardsLabel.text
    property alias productTypeLabeltext: productTypeLabel.text
    property alias productUserCreditsLabeltext: productUserCreditsLabel.text
    
    
    titleBar: TitleBar {
        title: "Shop"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        leftPadding: 20
        rightPadding: 20
        topPadding: 10
        background: Color.create("#ededed");
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        Label{
            id: productUserCreditsLabel
            
            horizontalAlignment: HorizontalAlignment.Center
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
            
            /*Button{
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Bottom
                text: "Purchase"  
                onClicked: {
                    if (purchasePage.purchasedPage == null) {
                        purchasePage.purchasedPage = purchasedDefinition.createObject();

                        purchasePage.purchasedPage.navParent = corePane;
                    }
                    navParent.push(purchasePage.purchasedPage);
                    //purchasedSheet.open();
                    purchaseClass.purchase(productId,purchaseType);
                }
            }
            Button{
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Bottom
                text: "Cards"
                onClicked: {
                    if (purchasePage.boosterPage == null) {
                        purchasePage.boosterPage = boosterDefinition.createObject();

                        purchasePage.boosterPage.navParent = corePane;
                    }
                    navParent.push(purchasePage.boosterPage);
                    //boosterSheet.open();
                    boosterClass.booster(productId);
                } 
            }*/
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: purchasedDefinition
            source: "Purchased.qml"
        },
        ComponentDefinition {
            id: boosterDefinition
            source: "Booster.qml"
        }
    ]
    actions: [
        ActionItem {
            title: "Purchase"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if (purchasePage.purchasedPage == null) {
                    purchasePage.purchasedPage = purchasedDefinition.createObject();

                    purchasePage.purchasedPage.navParent = corePane;
                }
                navParent.push(purchasePage.purchasedPage);
                //purchasedSheet.open();
                purchaseClass.purchase(productId, purchaseType)
            }
            imageSource: "asset:///images/actionicons/purchase.png"
        },
        ActionItem {
            title: "Booster"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if (purchasePage.boosterPage == null) {
                    purchasePage.boosterPage = boosterDefinition.createObject();

                    purchasePage.boosterPage.navParent = corePane;
                }
                navParent.push(purchasePage.boosterPage);
                //boosterSheet.open();
                boosterClass.booster(productId);
            }
            imageSource: "asset:///images/actionicons/cards.png"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navParent.pop();
            }
        }
    }
}
