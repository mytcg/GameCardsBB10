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
        layout: DockLayout {
            
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
        
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
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
                objectName: "shopList"
                
                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    console.log("onTriggered");
                    console.log("indexPath " + indexPath);
                    console.log("selectedItem.productname " + selectedItem.productname);
                    purchase.productId = selectedItem.productid;
                    purchase.purchaseType = (selectedItem.productpremium=="0"?"3":"2");
                    
                    purchase.productNameLabeltext = selectedItem.productname;
                    purchase.productCostLabeltext = "Price: " + selectedItem.productprice;
                    purchase.productNumCardsLabeltext = "Number of cards: " + selectedItem.productnumcards;
                    purchase.productTypeLabeltext = "Product type: " + selectedItem.producttype;
                    purchaseSheet.open();
                }
                
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                
                layout: GridListLayout {
                    columnCount: 2
                    cellAspectRatio: 1.6
                }            
            }
        }
        attachedObjects: [
                Sheet {
                    id: purchaseSheet
                    
                    Purchase{
                        id: purchase
                        
                        onCancel: {
                            purchaseSheet.close();
                        }
                    }
                }
            ]
    }
}
