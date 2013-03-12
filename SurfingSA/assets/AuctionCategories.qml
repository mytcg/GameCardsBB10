import bb.cascades 1.0


Page {
    id: auctionCategoriesPage
    property NavigationPane navParent: null
    property Page auctionListPage: null

    signal cancel ()
    
    function loadAuctionCategories(String) {
        auctionCategoriesClass.loadAuctionCategories(String);
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

            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                imageSource: "asset:///images/header/header.png"
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                leftPadding: 20
                topPadding: 20
                Label {
                    text: "AUCTION CATEGORIES"
                    textStyle.color: Color.LightGray
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontSize: FontSize.Small
                }
            }
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            topPadding: 155
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
                        /*StandardListItem {
                            title: ListItemData.albumname
                            horizontalAlignment: HorizontalAlignment.Center
                            visible: (ListItemData.collected=="0"?false:true)
                        }*/
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
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                auctionClass.loadAuctions();
                navParent.pop();
            }
        }
    }
}
