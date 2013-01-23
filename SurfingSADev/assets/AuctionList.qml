import bb.cascades 1.0


Page {
    id: auctionListPage
    
    signal cancel ()
    
    property string albumid: "0";
    
    function loadAuctionList(String) {
        auctionListClass.loadAuctionList(String);
    }
    
    titleBar: TitleBar {
        title: "Auction Cards"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                auctionListPage.cancel();
            }
        }
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: auctionListLabel
            objectName: "auctionListLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "auctionListList"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.description +" ("+ListItemData.quantity+")"
                        horizontalAlignment: HorizontalAlignment.Center
                        imageSource: (ListItemData.quantity=="0"?"asset:///images/emptythumb.png":"asset:///images/loadingthumb.png")
                        minHeight: 66
                        visible: (ListItemData.quantity=="0"?false:true)
                    }
                }
            ]
            onTriggered: {
                clearSelection();
                if(dataModel.data (indexPath).quantity!="0"){
                    auctionCreate.cardId = dataModel.data (indexPath).cardid;
                    auctionCreate.createAuction.visible = true;
                    auctionCreateSheet.open();
                }
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionListIndicator"
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
            id: auctionCreateSheet
            
            AuctionCreate{
            id: auctionCreate
            
            onCancel: {
                auctionCreateSheet.close();
                auctionListPage.loadAuctionList(albumid);
            }
            }
        }
    ]
}
