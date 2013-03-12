import bb.cascades 1.0

Page {
    id: auctionCreatePage
    property NavigationPane navParent: null

    signal cancel ()
    property string cardId: "0"
    property string albumid: "0"

    property alias createAuctionButtonvisible: createAuction.enabled
    
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
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            Container {
                layout: DockLayout {
                }

                ImageView {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    imageSource: "asset:///images/header/header.png"
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    topPadding: 20
                    Label {
                        text: "CREATE AUCTION"
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
                topPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    id: auctionCreateLabel
                    textStyle.color: Color.DarkGray
                    objectName: "auctionCreateLabel"
                    text: ""
                }
                Label {
                    text: "Opening Bid:"
                    textStyle.color: Color.DarkGray
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: openingBidText
                    objectName: "openingBidText"
                    text: ""
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                Label {
                    text: "Buy Now Price:"
                    textStyle.color: Color.DarkGray
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: buyNowText
                    objectName: "buyNowText"
                    text: ""
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                Label {
                    text: "Auction duration(days):"
                    textStyle.color: Color.DarkGray
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: durationText
                    objectName: "durationText"
                    text: ""
                    inputMode: TextFieldInputMode.NumbersAndPunctuation
                }
                /*Button {
                 * objectName: "createAuction"
                 * id: createAuction
                 * text: "Auction"
                 * horizontalAlignment: HorizontalAlignment.Center
                 * onClicked: {
                 * auctionCreateClass.createAuction(cardId, openingBidText.text, buyNowText.text, durationText.text);
                 * }
                 * }*/
            }
        }
        
        ActivityIndicator {
            // The activity indicator has an object name set so that
            // we can start and stop it from C++
            objectName: "createAuctionIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            onStopped: {
                //cancelScreen()
            }
        }
    }
    actions: [
        ActionItem {
        	id: createAuction
            title: "Auction"
            objectName: "createAuction"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                auctionCreateClass.createAuction(cardId, openingBidText.text, buyNowText.text, durationText.text);
            }
            imageSource: "asset:///images/actionicons/auction.png"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                auctionCreateLabel.text = "";
                openingBidText.text = "";
                buyNowText.text = "";
                durationText.text = "";
                auctionListClass.loadAuctionList(albumid);
                navParent.pop();
            }
        }
    }
}
