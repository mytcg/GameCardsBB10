import bb.cascades 1.0

Page {
    id: auctionPage
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Auctions"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                auctionPage.cancel();
            }
        }
    }
    Container {
        layout: DockLayout {
            
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
                id: auctionsLabel
                objectName: "auctionLabel"
                text: "0"
                visible: false
            }
            Button{
                horizontalAlignment: HorizontalAlignment.Center
                text: "Create new Auction"   
                onClicked: {
                    auctionCategories.loadAuctionCategories("0");
                    auctionCategoriesSheet.open();
                }
            }
            ListView {
                objectName: "auctionView"
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                
                layout: FlowListLayout {
                
                }
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: ListItemData.albumname 
                        }
                    }
                ]
                onTriggered: {
                    clearSelection();
                    if(dataModel.data (indexPath).albumid=="-2"){
                        onAuctionList.type = "1";
                        onAuctionList.albumid = dataModel.data (indexPath).albumid;
                        onAuctionListClass.loadOnAuctionList(dataModel.data (indexPath).albumid,"1");
                    }else {
                        onAuctionList.type = "0";
                        onAuctionList.albumid = dataModel.data (indexPath).albumid;
                        onAuctionListClass.loadOnAuctionList(dataModel.data (indexPath).albumid,"0");
                    }
                    onAuctionListSheet.open();
                }
            }
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        } 
    }
    
    attachedObjects: [
        Sheet {
            id: auctionCategoriesSheet
            
            AuctionCategories{
                id: auctionCategories
                
                onCancel: {
                    auctionCategoriesSheet.close();
                    auctionClass.loadAuctions();
                }
            }
        },Sheet {
            id: onAuctionListSheet
            
            OnAuctionList{
                id: onAuctionList
                
                onCancel: {
                    onAuctionListSheet.close();
                    auctionClass.loadAuctions();
                }
            }
        }
    ]
}
