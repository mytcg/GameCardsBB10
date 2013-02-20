import bb.cascades 1.0

Page {
    id: auctionCreatePage
    signal cancel ()
    property string cardId: "0"
    
    property alias createAuctionButtonvisible: createAuction.visible
    
    titleBar: TitleBar {
        title: "Create Auction"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                auctionCreateLabel.text = "";
                openingBidText.text = "";
                buyNowText.text="";
                durationText.text = "";
                auctionCreatePage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
            
        }
        
        background: Color.create("#ededed");
        
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
                objectName: "auctionCreateLabel"
                text: ""
            }
            Label {
                text: "Opening Bid:"
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
                textStyle.fontSizeValue: 0.0
            }
            TextField {
                id: durationText
                objectName: "durationText"
                text: ""
                inputMode: TextFieldInputMode.NumbersAndPunctuation
            }
            Button {
                objectName: "createAuction"
                id: createAuction
                text: "Auction"
                horizontalAlignment: HorizontalAlignment.Center
                onClicked: {
                    auctionCreateClass.createAuction(cardId, openingBidText.text, buyNowText.text, durationText.text);
                }
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
}
