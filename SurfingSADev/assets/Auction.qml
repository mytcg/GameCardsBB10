import bb.cascades 1.0

Page {
    id: auctionPage
    property NavigationPane navParent: null
    property Page auctionCategoriesPage: null
    property Page onAuctionListPage: null
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Auctions"
        visibility: ChromeVisibility.Visible
    }
    Container {
        layout: DockLayout {
            
        }
        
        background: Color.create("#ededed");
        
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
            /*Button{
                horizontalAlignment: HorizontalAlignment.Center
                text: "Create new Auction"   
                onClicked: {
                    if (auctionPage.auctionCategoriesPage == null) {
                        auctionPage.auctionCategoriesPage = auctionCategoriesDefinition.createObject();

                        auctionPage.auctionCategoriesPage.navParent = corePane;
                    }
                    navParent.push(auctionPage.auctionCategoriesPage);
                    auctionPage.auctionCategoriesPage.loadAuctionCategories("0");
                    //auctionCategoriesSheet.open();
                }
            }*/
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
                    if (auctionPage.onAuctionListPage == null) {
                        auctionPage.onAuctionListPage = onAuctionListDefinition.createObject();

                        auctionPage.onAuctionListPage.navParent = corePane;
                    }
                    
                    if(dataModel.data (indexPath).albumid=="-2"){
                        auctionPage.onAuctionListPage.type = "1";
                        auctionPage.onAuctionListPage.albumid = dataModel.data (indexPath).albumid;
                        navParent.push(auctionPage.onAuctionListPage);
                        onAuctionListClass.loadOnAuctionList(dataModel.data (indexPath).albumid,"1");
                    }else {
                        auctionPage.onAuctionListPage.type = "0";
                        auctionPage.onAuctionListPage.albumid = dataModel.data (indexPath).albumid;
                        navParent.push(auctionPage.onAuctionListPage);
                        onAuctionListClass.loadOnAuctionList(dataModel.data (indexPath).albumid,"0");
                    }
                    //onAuctionListSheet.open();
                }
            }
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionsIndicator"
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
            id: auctionCategoriesDefinition
            source: "AuctionCategories.qml"
            /*onCancel: {
                auctionCategoriesSheet.close();
                auctionClass.loadAuctions();
            }*/
        },
        ComponentDefinition {
            id: onAuctionListDefinition
            source: "OnAuctionList.qml"
            /*onCancel: {
                onAuctionListSheet.close();
                auctionClass.loadAuctions();
            }*/
        }
    ]
    actions: [
        ActionItem {
            title: "Create new Auction"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if (auctionPage.auctionCategoriesPage == null) {
                    auctionPage.auctionCategoriesPage = auctionCategoriesDefinition.createObject();

                    auctionPage.auctionCategoriesPage.navParent = corePane;
                }
                navParent.push(auctionPage.auctionCategoriesPage);
                auctionPage.auctionCategoriesPage.loadAuctionCategories("0");
            }
            imageSource: "asset:///images/actionicons/create new auction.png"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                navParent.pop();
            }
        }
    }
}
