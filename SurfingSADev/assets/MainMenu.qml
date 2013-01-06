import bb.cascades 1.0

// The root container for the custom component
Container {
    
    function showCoreMenu() {
        coreContainer.visible = true
        
        surfContainer.visible = false
    }
    
    function showSurfMenu() {
        coreContainer.visible = false
        
        surfContainer.visible = true
    }
    
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    
    Container {
        id: coreContainer
        
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Container {
            
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
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    albumSheet.open();
                    
                    album.loadAlbums();
                }
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: notificationButton
                defaultImageSource: "asset:///images/menu/Notifications.png"
                pressedImageSource: "asset:///images/menu/Notifications.png"
                disabledImageSource: "asset:///images/menu/Notifications.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    notificationsSheet.open();
                    notificationsClass.loadNotifications();
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: inviteButton
                defaultImageSource: "asset:///images/menu/Invite.png"
                pressedImageSource: "asset:///images/menu/Invite.png"
                disabledImageSource: "asset:///images/menu/Invite.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    invitefriendSheet.open()
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
        }
        
        Container {
            
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
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    shopSheet.open();
                    shopClass.loadProducts();
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: creditsButton
                defaultImageSource: "asset:///images/menu/Credits.png"
                pressedImageSource: "asset:///images/menu/Credits.png"
                disabledImageSource: "asset:///images/menu/Credits.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    creditsSheet.open();
                    creditsClass.loadCredits();
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: redeemButton
                defaultImageSource: "asset:///images/menu/Redeem.png"
                pressedImageSource: "asset:///images/menu/Redeem.png"
                disabledImageSource: "asset:///images/menu/Redeem.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    redeemSheet.open()
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
        }
        
        Container {
            
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
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    auctionSheet.open();
                    auctionClass.loadAuctions();;
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: friendsButton
                defaultImageSource: "asset:///images/menu/Friends.png"
                pressedImageSource: "asset:///images/menu/Friends.png"
                disabledImageSource: "asset:///images/menu/Friends.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    friendsSheet.open();
                    friendsClass.loadFriends();
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
            
            // An ImageButton
            ImageButton {
                id: exitButton
                defaultImageSource: "asset:///images/menu/exit.png"
                pressedImageSource: "asset:///images/menu/exit.png"
                disabledImageSource: "asset:///images/menu/exit.png"
                enabled: true
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                
                onClicked: {
                    testSheet.open()
                }
                
                leftMargin: 5.0
                rightMargin: 5.0
                topMargin: 5.0
                bottomMargin: 5.0
            }// ImageButton
        }
    }
    
    Container {
        id: surfContainer
        visible: false
        
        ListView {
            dataModel: XmlDataModel {
                source: "models/surfMenuItems.xml"
            }
            
            // Use a ListItemComponent to determine which property in the
            // data model is displayed for each list item
            listItemComponents: [
                ListItemComponent {
                    type: "listItem"
                    
                    StandardListItem {
                        // Display the value of an item's title property
                        // in the list
                        title: ListItemData.title
                    }
                }
            ]
            
            onTriggered: {
                var selectedItem = dataModel.data(indexPath);
                //textField.text = selectedItem.title + " " + indexPath;
                
                if (indexPath == 0) {
                    weatherSheet.open();
                }
            }
        }
    }
    
    scaleX: 1
    scaleY: 1
    
    attachedObjects: [
        Sheet {
            id: testSheet
            
            Page {
                id: sheetPage
                
                signal cancel ()
                
                titleBar: TitleBar {
                    id: addBar
                    title: "Test Sheet"
                    visibility: ChromeVisibility.Visible
                    
                    acceptAction: ActionItem {
                        title: "Back"
                        onTriggered: {
                            sheetPage.cancel();
                        }
                    }
                }
                
                onCancel: {
                    testSheet.close();
                }
            }
        },
        
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
        },
                
        Sheet {
            id: weatherSheet
            
            Weather{
                onCancel: {
                    weatherSheet.close();
                }
            }
        }
    ]
} // End of the root container