import bb.cascades 1.0

// The root container for the custom component
TabbedPane {
	id: menuPane
    showTabsOnActionBar: true
    property alias showLoggin: loginContainer.visible
    function selectTab(index) {
    	if (index == 0) {
            menuPane.activeTab = tabCards
        } else if (index == 1) {
            menuPane.activeTab = tabWeather
        } else if (index == 2) {
            menuPane.activeTab = tabNews
        } else if (index == 3) {
            menuPane.activeTab = tabScores
        }
    }

    Tab {
    	//vars for pages
    	property Page albumPage: null
        property Page shopPage: null
        property Page auctionPage: null
        property Page notificationsPage: null
        property Page creditsPage: null
        property Page friendsPage: null
        property Page invitefriendPage: null
        property Page redeemPage: null

        id: tabCards
        title: "Cards"
        imageSource: "asset:///images/tabs/surfing_cards_icon_tab.png"
        NavigationPane {
        	id: corePane
            Page {
                actions: [
                    ActionItem {
                        title: qsTr("Invite to download")
                        onTriggered: {

                        }
                    }
                ]
                Container {
                    layout: DockLayout {
                    }
                    Container {
                    	layout: StackLayout {
                        	orientation: LayoutOrientation.LeftToRight
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        Container {
                            layout: DockLayout {
                            }

                            ImageView {
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                imageSource: "asset:///images/backgrounds/surfing_cards_landing_bg.jpg"
                            }

                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill

                                Container {
                                    layout: DockLayout {
                                    }

                                    ImageView {
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        verticalAlignment: VerticalAlignment.Fill
                                        imageSource: "asset:///images/header/header.png"
                                    }

                                    ImageView {
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Top
                                        imageSource: "asset:///images/header/surfing_cards_logo.png"
                                    }
                                }
                                Login {
                                    id: loginContainer
                                }
                                Container {
                                    visible: (! loginContainer.visible)

                                    layout: DockLayout {
                                    }
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill

                                    topPadding: 30
                                    bottomPadding: 55
                                    leftPadding: 20
                                    rightPadding: 20

                                    Container {
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Fill

                                        layout: StackLayout {
                                            orientation: LayoutOrientation.TopToBottom
                                        }

                                        // An ImageButton
                                        ImageButton {
                                            id: albumButton
                                            defaultImageSource: "asset:///images/menu/Album.png"
                                            pressedImageSource: "asset:///images/menu/Album.png"
                                            disabledImageSource: "asset:///images/menu/Album.png"
                                            enabled: true

                                            onClicked: {
                                                //albumSheet.open();

                                                if (tabCards.albumPage == null) {
                                                    tabCards.albumPage = albumDefinition.createObject();
                                                }
                                                corePane.push(tabCards.albumPage);
                                                tabCards.albumPage.navParent = corePane;
                                                tabCards.albumPage.loadAlbums("0");
                                            }
                                        } // ImageButton

                                        // An ImageButton
                                        ImageButton {
                                            id: notificationButton
                                            defaultImageSource: "asset:///images/menu/Notifications.png"
                                            pressedImageSource: "asset:///images/menu/Notifications.png"
                                            disabledImageSource: "asset:///images/menu/Notifications.png"
                                            enabled: true

                                            onClicked: {
                                                //notificationsSheet.open();
                                                if (tabCards.notificationsPage == null) {
                                                    tabCards.notificationsPage = notificationsDefinition.createObject();
                                                }
                                                corePane.push(tabCards.notificationsPage);
                                                tabCards.notificationsPage.navParent = corePane;
                                                notificationsClass.loadNotifications();
                                            }
                                        } // ImageButton

                                        // An ImageButton
                                        ImageButton {
                                            id: friendsButton
                                            defaultImageSource: "asset:///images/menu/Friends.png"
                                            pressedImageSource: "asset:///images/menu/Friends.png"
                                            disabledImageSource: "asset:///images/menu/Friends.png"
                                            enabled: true

                                            onClicked: {
                                                //friendsSheet.open();
                                                if (tabCards.friendsPage == null) {
                                                    tabCards.friendsPage = friendsDefinition.createObject();
                                                }
                                                corePane.push(tabCards.friendsPage);
                                                tabCards.friendsPage.navParent = corePane;
                                                friendsClass.loadFriends();
                                            }
                                        } // ImageButton
                                    }

                                    Container {
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Fill

                                        layout: StackLayout {
                                            orientation: LayoutOrientation.TopToBottom
                                        }

                                        // An ImageButton
                                        ImageButton {
                                            id: shopButton
                                            defaultImageSource: "asset:///images/menu/Shop.png"
                                            pressedImageSource: "asset:///images/menu/Shop.png"
                                            disabledImageSource: "asset:///images/menu/Shop.png"
                                            enabled: true

                                            onClicked: {
                                                //shopSheet.open();
                                                if (tabCards.shopPage == null) {
                                                    tabCards.shopPage = shopDefinition.createObject();
                                                }
                                                corePane.push(tabCards.shopPage);
                                                tabCards.shopPage.navParent = corePane;
                                                shopClass.loadProducts();
                                            }
                                        } // ImageButton

                                        // An ImageButton
                                        ImageButton {
                                            id: creditsButton
                                            defaultImageSource: "asset:///images/menu/Credits.png"
                                            pressedImageSource: "asset:///images/menu/Credits.png"
                                            disabledImageSource: "asset:///images/menu/Credits.png"
                                            enabled: true

                                            onClicked: {
                                                //creditsSheet.open();
                                                if (tabCards.creditsPage == null) {
                                                    tabCards.creditsPage = creditsDefinition.createObject();
                                                }
                                                corePane.push(tabCards.creditsPage);
                                                tabCards.creditsPage.navParent = corePane;
                                                creditsClass.loadCredits();
                                            }
                                        } // ImageButton

                                        // An ImageButton
                                        ImageButton {
                                            id: inviteButton
                                            defaultImageSource: "asset:///images/menu/Invite.png"
                                            pressedImageSource: "asset:///images/menu/Invite.png"
                                            disabledImageSource: "asset:///images/menu/Invite.png"
                                            enabled: true

                                            onClicked: {
                                                //invitefriendSheet.open()
                                                if (tabCards.invitefriendPage == null) {
                                                    tabCards.invitefriendPage = invitefriendDefinition.createObject();
                                                }
                                                corePane.push(tabCards.invitefriendPage);
                                                tabCards.invitefriendPage.navParent = corePane;
                                            }
                                        } // ImageButton
                                    }

                                    Container {
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Fill

                                        layout: StackLayout {
                                            orientation: LayoutOrientation.TopToBottom
                                        }

                                        // An ImageButton
                                        ImageButton {
                                            id: auctionButton
                                            defaultImageSource: "asset:///images/menu/Auctions.png"
                                            pressedImageSource: "asset:///images/menu/Auctions.png"
                                            disabledImageSource: "asset:///images/menu/Auctions.png"
                                            enabled: true

                                            onClicked: {
                                                //auctionSheet.open();
                                                if (tabCards.auctionPage == null) {
                                                    tabCards.auctionPage = auctionDefinition.createObject();
                                                }
                                                corePane.push(tabCards.auctionPage);
                                                tabCards.auctionPage.navParent = corePane;
                                                auctionClass.loadAuctions();
                                            }
                                        } // ImageButton

                                        // An ImageButton
                                        ImageButton {
                                            id: redeemButton
                                            defaultImageSource: "asset:///images/menu/Redeem.png"
                                            pressedImageSource: "asset:///images/menu/Redeem.png"
                                            disabledImageSource: "asset:///images/menu/Redeem.png"
                                            enabled: true

                                            onClicked: {
                                                if (tabCards.redeemPage == null) {
                                                    tabCards.redeemPage = redeemDefinition.createObject();
                                                }
                                                corePane.push(tabCards.redeemPage);
                                            }
                                        } // ImageButton
                                    }
                                }
                            }
                            //background: Color.create("#ededed")
                        }
                    }
                }
            }
        }
    }
    
    Tab {
        id: tabWeather
        title: "Weather"
        imageSource: "asset:///images/tabs/weather_icon_tab.png"

        Page {
            
            Container {
                layout: DockLayout {
                }
                
                //background: Color.create("#ededed");
                ImageView {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    imageSource: "asset:///images/backgrounds/bg.jpg"
                }

                Container {
                	layout: StackLayout {
                		orientation: LayoutOrientation.TopToBottom                    
                    }
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

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
                            ImageView {
                                imageSource: "asset:///images/tabs/weather_icon_tab.png"
                                verticalAlignment: VerticalAlignment.Center
                            }
                            Label {
                                text: "WEATHER"
                                textStyle.color: Color.LightGray
                                verticalAlignment: VerticalAlignment.Center
                                textStyle.fontSize: FontSize.Small
                            }
                        }
                    }

                    Weather {
                        id: weatherContainer

                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill

                        topPadding: 10
                        bottomPadding: 10
                        leftPadding: 10
                        rightPadding: 10
                    }
                }
	        }
        }
    }
    
    Tab {
        id: tabNews
        title: "News"
        imageSource: "asset:///images/tabs/news_icon_tab.png"

        Page {

            Container {
                layout: DockLayout {
                }
                
                //background: Color.create("#ededed");
                ImageView {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    imageSource: "asset:///images/backgrounds/bg.jpg"
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

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
                            ImageView {
                                imageSource: "asset:///images/tabs/news_icon_tab.png"
                                verticalAlignment: VerticalAlignment.Center
                            }
                            Label {
                                text: "NEWS"
                                textStyle.color: Color.LightGray
                                verticalAlignment: VerticalAlignment.Center
                                textStyle.fontSize: FontSize.Small
                            }
                        }
                    }

                    News {
                        id: newsContainer

                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill

                        topPadding: 10
                        bottomPadding: 10
                        leftPadding: 10
                        rightPadding: 10
                    }
                }
	        }
        }
    }
    
    Tab {
        id: tabScores
        title: "Scores"
        imageSource: "asset:///images/tabs/scoring_icon_tab.png"

        Scoring {
            id: scoreContainer
        }
        
        onTriggered: {
        	if (!scoreContainer.loaded) {
                scoreContainer.loadEvents()
            }
        }
    }
    
    attachedObjects: [
        /*Sheet {
            id: albumSheet
            
            Album{
                id: album
                
                onCancel: {
                    albumSheet.close();
                }
            }
        }*/
        ComponentDefinition {
            id: albumDefinition
            source: "Album.qml"
        }
        /*Album {
            id: album
        }*/,

        ComponentDefinition {
            id: shopDefinition
            source: "Shop.qml"
        },

        ComponentDefinition {
            id: auctionDefinition
            source: "Auction.qml"
        },

        ComponentDefinition {
            id: creditsDefinition
            source: "Credits.qml"
        },

        ComponentDefinition {
            id: friendsDefinition
            source: "Friends.qml"
        },

        ComponentDefinition {
            id: invitefriendDefinition
            source: "InviteFriend.qml"
        },

        ComponentDefinition {
            id: notificationsDefinition
            source: "Notifications.qml"
        },
        ComponentDefinition {
            id: redeemDefinition
            source: "Redeem.qml"
        }
    /*Sheet {
            id: redeemSheet
            
            Redeem{
                onCancel: {
                    redeemSheet.close();
                }
            }
        }*/
    ]
} // End of the root container