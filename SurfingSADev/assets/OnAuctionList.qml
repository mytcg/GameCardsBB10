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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: albumLabel
            objectName: "onAuctionListLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "onAuctionListList"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
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
                auctionInfoSheet.open();
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadOnAuctionListIndicator"
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
