import bb.cascades 1.0


Page {
    id: cardPage
    signal cancel ()
    
    property string cardId: "0";
    property string newCard: "false";
    
    function loadAlbums(String) {
        albumClass.loadAlbums(String);
    }
    
    titleBar: TitleBar {
        title: "Album"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                cardPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        Label {
            id: cardLabel
            objectName: "cardLabel"
            text: "0"
            visible: false
        }
        ImageView {
            objectName: "cardView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            imageSource: "asset:///images/loading.png"
        
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            text: newCard=="false"?"Flip":"Accept"  
            onClicked: {
                if(newCard=="true"){
                    cardClass.save(cardId);
                }
            }
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            text: newCard=="false"?"Options":"Reject" 
            onClicked: {
                if(newCard=="true"){
                    cardClass.reject(cardId); 
                }               
            } 
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadCardIndicator"
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
            id: optionsSheet
            
            /*AlbumView{
            id: albumView
            
            onCancel: {
            albumViewSheet.close();
            }
            }*/
        }
    ]
}
