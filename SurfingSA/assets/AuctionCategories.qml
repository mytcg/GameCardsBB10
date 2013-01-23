import bb.cascades 1.0


Page {
    id: auctionCategoriesPage
    
    signal cancel ()
    
    function loadAuctionCategories(String) {
        auctionCategoriesClass.loadAuctionCategories(String);
    }
    
    titleBar: TitleBar {
        title: "Auction Categories"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                auctionCategoriesPage.cancel();
            }
        }
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: albumLabel
            objectName: "auctionCategoriesLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "auctionCategoriesList"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.albumname
                        horizontalAlignment: HorizontalAlignment.Center
                        visible: (ListItemData.collected=="0"?false:true)
                    }
                }
            ]
            onTriggered: {
                clearSelection();
                if(dataModel.data (indexPath).hascards == "false"){
                    auctionCategoriesPage.loadAuctionCategories(dataModel.data (indexPath).albumid)
                }else{
                    auctionList.loadAuctionList(dataModel.data (indexPath).albumid)
                    auctionList.albumid = dataModel.data (indexPath).albumid;
                    auctionListSheet.open();
                }
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionCategoriesIndicator"
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
            id: auctionListSheet
            
            AuctionList{
            id: auctionList
            
            onCancel: {
            auctionListSheet.close();
            auctionCategoriesPage.loadAuctionCategories("0");
            }
            }
        }
    ]
}
