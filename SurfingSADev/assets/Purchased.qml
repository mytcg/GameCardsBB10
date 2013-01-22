import bb.cascades 1.0


Page {
    id: purchasedPage
    
    property string newCards: "false"
    
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Booster"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                purchasedPage.cancel();
            }
        }
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        ListView {
            objectName: "purchasedList"
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
                    }
                }
            ]
            onTriggered: {
                clearSelection();
                if(dataModel.data (indexPath).quantity!="0"){
                    card.cardId = dataModel.data (indexPath).cardid;
                    cardSheet.open();
                }
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadPurchasedIndicator"
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
            id: cardSheet
            
            Card{
            id: card
            
            onCancel: {
            cardSheet.close();
            }
            }
        }
    ]
}
