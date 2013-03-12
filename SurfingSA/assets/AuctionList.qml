import bb.cascades 1.0


Page {
    id: auctionListPage
    property NavigationPane navParent: null
    property Page auctionCreatePage: null

    signal cancel ()
    
    property string albumid: "0";
    
    function loadAuctionList(String) {
        auctionListClass.loadAuctionList(String);
    }
    
    titleBar: TitleBar {
        title: "Auction Cards"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        layout: DockLayout {
        }
        
        background: Color.create("#ededed");
        
        Label {
            id: auctionListLabel
            objectName: "auctionListLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "auctionListList"
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
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
                    if (auctionListPage.auctionCreatePage == null) {
                        auctionListPage.auctionCreatePage = auctionCreateDefinition.createObject();

                        auctionListPage.auctionCreatePage.navParent = corePane;

                        auctionListPage.auctionCreatePage.albumid = albumid;
                    }
                    auctionListPage.auctionCreatePage.cardId = dataModel.data (indexPath).cardid;
                    auctionListPage.auctionCreatePage.createAuctionButtonvisible = true;
                    navParent.push(auctionListPage.auctionCreatePage);
                    //auctionCreateSheet.open();
                }
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionListIndicator"
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
            id: auctionCreateDefinition
            source: "AuctionCreate.qml"
            
            /*onCancel: {
                auctionCreateSheet.close();
                auctionListPage.loadAuctionList(albumid);
            }*/
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                auctionCategoriesPage.loadAuctionCategories("0");
                navParent.pop();
            }
        }
    }
}
