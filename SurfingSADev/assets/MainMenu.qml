import bb.cascades 1.0

// The root container for the custom component
TabbedPane {
    showTabsOnActionBar: true
    Tab {
        title: "Cards"
        imageSource: "asset:///images/tabs/gamecards_tab.png"
        Page {
            titleBar: TitleBar {
                title: "Surfing SA"
                visibility: ChromeVisibility.Visible
            }
            
            Container {
                layout: DockLayout {
                }
                
                background: Color.create("#ededed");
                
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
		                        albumSheet.open();
		                        
		                        album.loadAlbums("0");
		                    }
		                }// ImageButton
		                
		                // An ImageButton
		                ImageButton {
		                    id: notificationButton
		                    defaultImageSource: "asset:///images/menu/Notifications.png"
		                    pressedImageSource: "asset:///images/menu/Notifications.png"
		                    disabledImageSource: "asset:///images/menu/Notifications.png"
		                    enabled: true
		                    
		                    onClicked: {
		                        notificationsSheet.open();
		                        notificationsClass.loadNotifications();
		                    }
		                }// ImageButton
		                
		                // An ImageButton
		                ImageButton {
		                    id: friendsButton
		                    defaultImageSource: "asset:///images/menu/Friends.png"
		                    pressedImageSource: "asset:///images/menu/Friends.png"
		                    disabledImageSource: "asset:///images/menu/Friends.png"
		                    enabled: true
		                    
		                    onClicked: {
		                        friendsSheet.open();
		                        friendsClass.loadFriends();
		                    }
		                }// ImageButton
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
		                        shopSheet.open();
		                        shopClass.loadProducts();
		                    }
		                }// ImageButton
		                
		                // An ImageButton
		                ImageButton {
		                    id: creditsButton
		                    defaultImageSource: "asset:///images/menu/Credits.png"
		                    pressedImageSource: "asset:///images/menu/Credits.png"
		                    disabledImageSource: "asset:///images/menu/Credits.png"
		                    enabled: true
		                    
		                    onClicked: {
		                        creditsSheet.open();
		                        creditsClass.loadCredits();
		                    }
		                }// ImageButton
		                
		                // An ImageButton
		                ImageButton {
		                    id: inviteButton
		                    defaultImageSource: "asset:///images/menu/Invite.png"
		                    pressedImageSource: "asset:///images/menu/Invite.png"
		                    disabledImageSource: "asset:///images/menu/Invite.png"
		                    enabled: true
		                    
		                    onClicked: {
		                        invitefriendSheet.open()
		                    }
		                }// ImageButton
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
		                        auctionSheet.open();
		                        auctionClass.loadAuctions();
		                    }
		                }// ImageButton
		                
		                // An ImageButton
		                ImageButton {
		                    id: redeemButton
		                    defaultImageSource: "asset:///images/menu/Redeem.png"
		                    pressedImageSource: "asset:///images/menu/Redeem.png"
		                    disabledImageSource: "asset:///images/menu/Redeem.png"
		                    enabled: true
		                    
		                    onClicked: {
		                        redeemSheet.open()
		                    }
		                }// ImageButton
		            }
	        }
	    }
    }
    
    Tab {
        title: "Weather"
        imageSource: "asset:///images/tabs/weather_tab.png"
        
        Page {
            titleBar: TitleBar {
                title: "Surfing SA"
                visibility: ChromeVisibility.Visible
            }
            
            Container {
                layout: DockLayout {
                }
                
                background: Color.create("#ededed");
                
                topPadding: 10
        	    bottomPadding: 55
        	    leftPadding: 10
        	    rightPadding: 10
            
	            Weather {
	                id: weatherContainer
	                
	                horizontalAlignment: HorizontalAlignment.Fill
	                verticalAlignment: VerticalAlignment.Fill
	            }
	        }
        }
    }
    
    Tab {
        title: "News"
        imageSource: "asset:///images/tabs/news_tab.png"
        
        Page {
            titleBar: TitleBar {
                title: "Surfing SA"
                visibility: ChromeVisibility.Visible
            }
            
            Container {
                layout: DockLayout {
                }
                
                background: Color.create("#ededed");
                
                topPadding: 10
        	    bottomPadding: 55
        	    leftPadding: 10
        	    rightPadding: 10
	            
	            News {
	                id: newsContainer
	                
	                horizontalAlignment: HorizontalAlignment.Fill
	                verticalAlignment: VerticalAlignment.Fill
	            }
	        }
        }
    }
    
    Tab {
        title: "Scores"
        imageSource: "asset:///images/tabs/scoring_tab.png"
        Page {
            Container {
                layout: DockLayout {
                }
                
                background: Color.create("#ededed");
                
                topPadding: 10
        	    bottomPadding: 10
        	    leftPadding: 10
        	    rightPadding: 10
        	    
        	    ImageView {
        	        imageSource: "asset:///images/comingsoon/coming_soon.jpg"
        	    }
	        }
        }
    }
    
    attachedObjects: [
        Sheet {
            id: albumSheet
            
            Album{
                id: album
                
                onCancel: {
                    albumSheet.close();
                }
            }
        },
        
        Sheet {
            id: shopSheet
            
            Shop{
                onCancel: {
                    shopSheet.close();
                }
            }
        },
        
        Sheet {
            id: auctionSheet
            
            Auction{
                onCancel: {
                    auctionSheet.close();
                }
            }
        },
        
        Sheet {
            id: creditsSheet
            
            Credits{
                onCancel: {
                    creditsSheet.close();
                }
            }
        },
        
        Sheet {
            id: friendsSheet
            
            Friends{
                onCancel: {
                    friendsSheet.close();
                }
            }
        },
        
        Sheet {
            id: invitefriendSheet
            
            InviteFriend{
                onCancel: {
                    invitefriendSheet.close();
                }
            }
        },
        
        Sheet {
            id: notificationsSheet
            
            Notifications{
                onCancel: {
                    notificationsSheet.close();
                }
            }
        },
        
        Sheet {
            id: redeemSheet
            
            Redeem{
                onCancel: {
                    redeemSheet.close();
                }
            }
        }
    ]
} // End of the root container