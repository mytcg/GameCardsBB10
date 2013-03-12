import bb.cascades 1.0


Page {
    id: purchasedPage
    property NavigationPane navParent: null
    property Page cardPage: null
    property string newCards: "false"
    
    signal cancel ()
    
    Container {
        layout: DockLayout {
            
        }
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
                    text: "BOOSTER"
                    textStyle.color: Color.LightGray
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontSize: FontSize.Small
                }
            }
        }

        Container {
            layout: DockLayout {
            }
            topPadding: 165
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            ListView {
                objectName: "purchasedList"
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill

                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: ListItemData.description + " (" + ListItemData.quantity + ")"
                            horizontalAlignment: HorizontalAlignment.Center
                            imageSource: (ListItemData.quantity == "0" ? "asset:///images/emptythumb.png" : "asset:///images/loadingthumb.png")
                            minHeight: 66
                        }
                    }
                ]
                onTriggered: {
                    clearSelection();
                    if (dataModel.data(indexPath).quantity != "0") {
                        //card.cardId = dataModel.data (indexPath).cardid;
                        //cardSheet.open();
                    }
                }
            }
        }
            
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadPurchasedIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }    
    }
    attachedObjects: [
        ComponentDefinition {
            id: cardSheet
            source: "Card.qml"
            /*Card{
            id: card
            
            onCancel: {
            cardSheet.close();
            }
            }*/
        }
    ]
}
