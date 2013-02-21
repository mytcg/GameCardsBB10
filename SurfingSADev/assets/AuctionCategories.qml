import bb.cascades 1.0


Page {
    id: auctionCategoriesPage
    property NavigationPane navParent: null
    property Page auctionListPage: null

    signal cancel ()
    
    function loadAuctionCategories(String) {
        auctionCategoriesClass.loadAuctionCategories(String);
    }
    
    titleBar: TitleBar {
        title: "Auction Categories"
        visibility: ChromeVisibility.Visible
        
        /*acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                auctionCategoriesPage.cancel();
            }
        }*/
    }
    
    Container {
        layout: DockLayout {
     
        }
        
        background: Color.create("#ededed");
        
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
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
                        if (auctionCategoriesPage.auctionListPage == null) {
                            auctionCategoriesPage.auctionListPage = auctionListDefinition.createObject();

                            auctionCategoriesPage.auctionListPage.navParent = corePane;
                        }
                        auctionCategoriesPage.auctionListPage.albumid = dataModel.data (indexPath).albumid;
                        navParent.push(auctionCategoriesPage.auctionListPage);
                        auctionCategoriesPage.auctionListPage.loadAuctionList(dataModel.data(indexPath).albumid)
                        //auctionListSheet.open();
                    }
                }
            }
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionCategoriesIndicator"
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
            id: auctionListDefinition
            source: "AuctionList.qml"
            /*onCancel: {
            auctionListSheet.close();
            auctionCategoriesPage.loadAuctionCategories("0");
            }*/
        }
    ]
}
