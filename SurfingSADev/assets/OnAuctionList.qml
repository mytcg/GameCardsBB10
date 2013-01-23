import bb.cascades 1.0


Page {
    id: onAuctionListPage
    
    signal cancel ()
    
    property string type: "0"
    
    titleBar: TitleBar {
        title: "On Auction"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                onAuctionListPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
            
        }
        
        Container {
            topPadding: 10
            leftPadding: 10
            rightPadding: 10
            bottomPadding: 10
            
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Label {
                id: albumLabel
                objectName: "onAuctionListLabel"
                text: "0"
                visible: false
            }
            Label {
                id: creditsLabel
                objectName: "auctionCreditsLabel"
                text: ""
                visible: false
            }
            
            Label {
                id: premiumLabel
                objectName: "auctionPremiumLabel"
                text: ""
                visible: false
            }
            
            ListView {
                objectName: "onAuctionListList"
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: ListItemData.description
                            horizontalAlignment: HorizontalAlignment.Center
                            imageSource: "asset:///images/loadingthumb.png"
                            minHeight: 66
                        }
                    }
                
	            ]
	            onTriggered: {
	                clearSelection();
	                auctionInfo.type = type;
	                auctionInfo.auctionid = dataModel.data (indexPath).auctioncardid;
	                auctionInfo.usercardid = dataModel.data (indexPath).usercardid;
	                auctionInfo.buynowprice = dataModel.data (indexPath).buynowprice;
	                auctionInfo.username = dataModel.data (indexPath).username;
	                auctionInfo.price = dataModel.data (indexPath).price;
	                auctionInfo.openingbid = dataModel.data (indexPath).openingbid;
	                auctionInfo.auctionCardLabeltext = dataModel.data (indexPath).description;
	                auctionInfo.auctionBidLabeltext = "Opening Bid: "+dataModel.data (indexPath).openingbid;
	                auctionInfo.auctionBuyNowLabeltext = "Buy Out: "+dataModel.data (indexPath).buynowprice;
	                auctionInfo.sellerLabeltext = "Seller: "+dataModel.data (indexPath).username;
	                auctionInfo.auctionBidDurationLabeltext = "End Date: "+dataModel.data (indexPath).endDate;
	                
	                if (creditsLabel.text != "") {
	                    auctionInfo.auctionUserCreditsLabeltext = "Credits: " + creditsLabel.text + "      Premium: " + premiumLabel.text;
	                }
	                
	                auctionInfoSheet.open();
	            }
	        }
	    }
	    
	    // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadOnAuctionListIndicator"
            preferredWidth: 200
            preferredHeight: 200
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            onStopped: {
            }
        }
    }
    attachedObjects: [
        Sheet {
            id: auctionInfoSheet
            
            AuctionInfo{
	            id: auctionInfo
	            
	            onCancel: {
	                auctionInfoSheet.close();
	            }
            }
        }
    ]
}

