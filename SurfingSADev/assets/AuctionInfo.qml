import bb.cascades 1.0


Page {
    id: auctionInfoPage
    property NavigationPane navParent: null
    signal cancel ()
    
    property string type: "0";
    property string auctionid: "0";
    property string username: "";
    property string usercardid: "0";
    property string buynowprice: "0";
    property string price: "";
    property string openingbid: "0"
    property string albumid: "0"

    property alias auctionCardLabeltext: auctionCardLabel.text
    property alias auctionBidLabeltext: auctionBidLabel.text
    property alias auctionBuyNowLabeltext: auctionBuyNowLabel.text
    property alias sellerLabeltext: sellerLabel.text
    property alias auctionBidDurationLabeltext: auctionBidDurationLabel.text
    property alias auctionUserCreditsLabeltext: auctionUserCreditsLabel.text
    
    titleBar: TitleBar {
        title: "Auction Info"
        visibility: ChromeVisibility.Visible
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
            Label{
                id: auctionUserCreditsLabel
                
                horizontalAlignment: HorizontalAlignment.Center
            }
            
            Label {
                id: auctionInfoLabel
                objectName: "auctionInfoLabel"
                text: ""
            }
            Container{
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container{
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    Label{
                        id: auctionCardLabel
                    }
                    Label{
                        id: auctionBidLabel
                    }
                    Label{
                        id: auctionBuyNowLabel
                    }
                    Label{
                        id: sellerLabel
                    }
                    Label{
                        id: auctionBidDurationLabel
                    }
                }
            }
            Label {
                text: "Place Bid"
                visible: (type=="0"?true:false)
                textStyle.fontSizeValue: 0.0
            }
            TextField {
                id: placeBidText
                objectName: "placeBidText"
                text: ""
                visible: (type=="0"?true:false)
                inputMode: TextFieldInputMode.NumbersAndPunctuation
            }
            Container {
                layout: StackLayout {
                }
                verticalAlignment: VerticalAlignment.Top
                /*Button {
                    objectName: "bidAuctionButton"
                    horizontalAlignment: HorizontalAlignment.Left
                    //verticalAlignment: VerticalAlignment.Bottom
                    text: "Bid"
                    visible: (type=="0"?true:false)
                    onClicked: {
                        auctionInfoClass.placeBid(auctionid, username, placeBidText.text, price, openingbid);
                    }
                }
                Button {
                    objectName: "buyAuctionButton"
                    horizontalAlignment: HorizontalAlignment.Right
                    //verticalAlignment: VerticalAlignment.Bottom
                    text: "Buy Now"
                    visible: (type=="0"?true:false)
                    onClicked: {
                        auctionInfoClass.buyNow(auctionid, username, buynowprice, usercardid);
                    }
                }*/
            }
        }
        
        ActivityIndicator {
            objectName: "auctionInfoIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            onStopped: {
            }
        }
    }
    actions: [
        ActionItem {
            title: "Bid"
            objectName: "bidAuctionButton"
            ActionBar.placement: ActionBarPlacement.OnBar
            enabled: (type == "0" ? true : false)
            onTriggered: {
                auctionInfoClass.placeBid(auctionid, username, placeBidText.text, price, openingbid);
            }
            imageSource: "asset:///images/actionicons/bid.png"
        },
        ActionItem {
            title: "Buy"
            objectName: "buyAuctionButton"
            ActionBar.placement: ActionBarPlacement.OnBar
            enabled: (type == "0" ? true : false)
            onTriggered: {
                auctionInfoClass.buyNow(auctionid, username, buynowprice, usercardid);
            }
            imageSource: "asset:///images/actionicons/buy auction.png"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                onAuctionListClass.loadOnAuctionList(albumid, type);
                navParent.pop();
            }
        }
    }
}
