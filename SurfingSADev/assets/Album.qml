import bb.cascades 1.0


Page {
    id: albumPage
    
    signal cancel ()
    
    function loadAlbums(String) {
        albumClass.loadAlbums(String);
    }
    
    titleBar: TitleBar {
        title: "Album"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                albumPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        
        Label {
            id: albumLabel
            objectName: "albumLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "albumView"
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.albumname 
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    /*Container {
                    id: itemRoot
                    Label { text: ListItemData.albumname }
                    }*/
                }
            ]
            onTriggered: {
                clearSelection();
                if(dataModel.data (indexPath).hascards == "false"){
                    albumPage.loadAlbums(dataModel.data (indexPath).albumid);
                }else{
                    if(dataModel.data (indexPath).albumid=="-3"){
                        albumView.newCards = true;
                    }
                    albumViewSheet.open();
                    albumView.loadAlbum(dataModel.data (indexPath).albumid);
                }
            }
        
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadIndicator"
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
            id: albumViewSheet
            
            AlbumView{
                id: albumView
                
                onCancel: {
                    albumViewSheet.close();
                }
            }
        }
    ]
}
