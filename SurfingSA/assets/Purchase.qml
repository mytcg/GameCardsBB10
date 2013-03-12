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

    Container {
    	layout: DockLayout {
    		
    	}
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill

        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
            }
        ]

        background: backgroundPaint.imagePaint

        Container {
            layout: DockLayout {
            }

            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Fill

            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                //verticalAlignment: VerticalAlignment.Fill
                imageSource: "asset:///images/header/header.png"
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                leftPadding: 20
                topPadding: 20
                Label {
                    text: "SHOP"
                    textStyle.color: Color.LightGray
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontSize: FontSize.Small
                }
            }
        }

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            topPadding: 165
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            Label {
                id: productUserCreditsLabel

                horizontalAlignment: HorizontalAlignment.Center

                textStyle.color: Color.DarkGray
            }

            Label {
                textStyle.color: Color.DarkGray
                id: productNameLabel
            }
            Label {
                textStyle.color: Color.DarkGray
                id: productCostLabel
            }
            Label {
                textStyle.color: Color.DarkGray
                id: productNumCardsLabel
            }
            Label {
                textStyle.color: Color.DarkGray
                id: productTypeLabel
                bottomMargin: 20
            }
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
