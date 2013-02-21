import bb.cascades 1.0

Page {
    id: shopPage
    property NavigationPane navParent: null
    property Page purchasePage: null
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Shop"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        layout: DockLayout {
            
        }
        background: Color.create("#ededed");
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadProductsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }
        
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            topPadding: 10
            
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Label {
                id: shopLabel
                objectName: "shopLabel"
                text: "0"
                visible: false
            }
            
            Label {
                id: creditsLabel
                objectName: "shopCreditsLabel"
                text: "0"
                visible: false
            }
            
            Label {
                id: premiumLabel
                objectName: "shopPremiumLabel"
                text: "0"
                visible: false
            }
            
            ListView {
                objectName: "shopList"
                
                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    console.log("onTriggered");
                    console.log("indexPath " + indexPath);
                    console.log("selectedItem.productname " + selectedItem.productname);
                    if (shopPage.purchasePage == null) {
                        shopPage.purchasePage = purchaseDefinition.createObject();

                        shopPage.purchasePage.navParent = corePane;
                    }

                    shopPage.purchasePage.productId = selectedItem.productid;
                    shopPage.purchasePage.purchaseType = (selectedItem.productpremium=="0"?"3":"2");

                    shopPage.purchasePage.productNameLabeltext = selectedItem.productname;
                    shopPage.purchasePage.productCostLabeltext = "Price: " + selectedItem.productprice;
                    shopPage.purchasePage.productNumCardsLabeltext = "Number of cards: " + selectedItem.productnumcards;
                    shopPage.purchasePage.productTypeLabeltext = "Product type: " + selectedItem.producttype;
                    shopPage.purchasePage.productUserCreditsLabeltext = "Credits: " + creditsLabel.text + "      Premium: " + premiumLabel.text;
                    navParent.push(shopPage.purchasePage);
                    //purchaseSheet.open();
                }
                
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }        
            }
        }
        attachedObjects: [
            ComponentDefinition {
                id: purchaseDefinition
                source: "Purchase.qml"
            }
        ]
    }
}
