import bb.cascades 1.0

Page {
    id: auctionPage
    property NavigationPane navParent: null
    property Page auctionCategoriesPage: null
    property Page onAuctionListPage: null
    signal cancel ()

    function loadAuctions() {
        auctionClass.loadAuctions();
    }

    Container {
        layout: DockLayout {
            
        }

        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
            }
        ]

        background: backgroundPaint.imagePaint

        Container {
            layout: DockLayout {
            }

            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Fill

            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                //verticalAlignment: VerticalAlignment.Fill
                imageSource: "asset:///images/header/header.png"
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                leftPadding: 20
                topPadding: 20
                Label {
                    text: "AUCTIONS"
                    textStyle.color: Color.LightGray
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontSize: FontSize.Small
                }
            }
        }

        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            leftPadding: 20
            rightPadding: 20
            topPadding: 165
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
                        Container {
                            preferredHeight: 100
                            preferredWidth: 768
                            id: itemRoot
                            layout: DockLayout {
                            }
                            //touchPropagationMode: TouchPropagationMode.Full
                            horizontalAlignment: HorizontalAlignment.Fill

                            ImageView {
                                imageSource: "asset:///images/customcomponents/list_background.png"
                                verticalAlignment: VerticalAlignment.Fill
                                horizontalAlignment: HorizontalAlignment.Fill
                            }
                            Container {
                                opacity: itemRoot.ListItem.active ? 0.9 : 0.0
                                background: Color.create("#75b5d3")
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                            }
                            Container {
                                layout: DockLayout {
                                }
                                rightPadding: 10
                                topPadding: 10
                                bottomPadding: 10
                                leftPadding: 20
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill

                                Label {
                                    horizontalAlignment: HorizontalAlignment.Left
                                    text: ListItemData.albumname
                                    verticalAlignment: VerticalAlignment.Center
                                    textStyle.color: Color.DarkGray
                                }
                            }
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
            /*onPop: {
                auctionClass.loadAuctions();
            }*/
        },
        ComponentDefinition {
            id: onAuctionListDefinition
            source: "OnAuctionList.qml"
            /*onPop: {
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
