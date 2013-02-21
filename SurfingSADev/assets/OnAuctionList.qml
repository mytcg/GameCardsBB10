import bb.cascades 1.0


Page {
    id: onAuctionListPage
    property NavigationPane navParent: null
    property Page auctionInfoPage: null

    signal cancel ()
    
    property string type: "0"
    property string albumid: "0"
    
    titleBar: TitleBar {
        title: "On Auction"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        layout: DockLayout {
            
        }
        background: Color.create("#ededed");
        
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
                    if (onAuctionListPage.auctionInfoPage == null) {
                        onAuctionListPage.auctionInfoPage = auctionInfoDefinition.createObject();

                        onAuctionListPage.auctionInfoPage.navParent = corePane;
                    }
                    onAuctionListPage.auctionInfoPage.type = type;
                    onAuctionListPage.auctionInfoPage.auctionid = dataModel.data (indexPath).auctioncardid;
                    onAuctionListPage.auctionInfoPage.usercardid = dataModel.data (indexPath).usercardid;
                    onAuctionListPage.auctionInfoPage.buynowprice = dataModel.data (indexPath).buynowprice;
                    onAuctionListPage.auctionInfoPage.username = dataModel.data (indexPath).username;
                    onAuctionListPage.auctionInfoPage.price = dataModel.data (indexPath).price;
                    onAuctionListPage.auctionInfoPage.openingbid = dataModel.data (indexPath).openingbid;
                    onAuctionListPage.auctionInfoPage.auctionCardLabeltext = dataModel.data (indexPath).description;
	                if(dataModel.data (indexPath).lastBidUser==""){
                        onAuctionListPage.auctionInfoPage.auctionBidLabeltext = "Opening Bid: "+dataModel.data (indexPath).openingbid;
	                }else{
                        onAuctionListPage.auctionInfoPage.auctionBidLabeltext = "Current Bid: "+dataModel.data (indexPath).price;
	                }
                    onAuctionListPage.auctionInfoPage.auctionBuyNowLabeltext = "Buy Out: "+dataModel.data (indexPath).buynowprice;
                    onAuctionListPage.auctionInfoPage.sellerLabeltext = "Seller: "+dataModel.data (indexPath).username;
                    onAuctionListPage.auctionInfoPage.auctionBidDurationLabeltext = "End Date: "+dataModel.data (indexPath).endDate;
	                
	                if (creditsLabel.text != "") {
	                    auctionInfo.auctionUserCreditsLabeltext = "Credits: " + creditsLabel.text + "      Premium: " + premiumLabel.text;
	                }
                    navParent.push(onAuctionListPage.auctionInfoPage);
                    //auctionInfoSheet.open();
	            }
	        }
	    }
	    
	    // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadOnAuctionListIndicator"
            preferredWidth: 100
            preferredHeight: 100
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            onStopped: {
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: auctionInfoDefinition
            source: "AuctionInfo.qml"
	        /*onCancel: {
	            auctionInfoSheet.close();
	            onAuctionListClass.loadOnAuctionList(albumid,type);
	        }*/
        }
    ]
}

