import bb.cascades 1.0


Page {
    id: albumViewPage
    
    property string newCards: "false"
    
    signal cancel ()
    
    function loadAlbum(String) {
        albumViewClass.loadAlbum(String);
    }
    
    titleBar: TitleBar {
        title: "Album"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                albumViewPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        
        background: Color.create("#ededed");
        
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            topPadding: 10
            leftPadding: 10
            rightPadding: 10
            bottomPadding: 10
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
            Label {
                id: albumLabel
                objectName: "albumViewLabel"
                text: "0"
                visible: false
            }
            ListView {
                objectName: "albumViewView"
                horizontalAlignment: HorizontalAlignment.Fill
                
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: ListItemData.description +" ("+ListItemData.quantity+")"
                            horizontalAlignment: HorizontalAlignment.Center
                            imageSource: (ListItemData.quantity=="0"?"asset:///images/emptythumb.png":"asset:///images/loadingthumb.png")
                            minHeight: 66
                            onCreationCompleted: {
                                imageloaderClass.loadImage(ListItemData.thumburl, this);
                            }
                        }
                    }
                ]
                onTriggered: {
                    clearSelection();
                    if(dataModel.data (indexPath).quantity!="0"){
                        card.cardId = dataModel.data (indexPath).cardid;
                        card.newCard = newCards;
                        card.fronturl = dataModel.data (indexPath).fronturl;
                        card.backurl = dataModel.data (indexPath).backurl;
                        card.loadImage(dataModel.data (indexPath).fronturl);
                        card.statView.statModel.insertList(dataModel.data (indexPath).stats);
                        cardSheet.open();
                    }
                }
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAlbumViewIndicator"
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
            peekEnabled: false
            Card{
            id: card
            
            onCancel: {
            cardSheet.close();
            }
            }
        }
    ]
}
