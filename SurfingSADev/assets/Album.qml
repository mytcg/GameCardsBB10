import bb.cascades 1.0


Page {
    id: albumPage
    property NavigationPane navParent: null

    //vars for pages
    property Page albumViewPage: null

    signal cancel ()
    
    function loadAlbums(String) {
        albumClass.loadAlbums(String);
    }
    
    titleBar: TitleBar {
        title: "Album"
        visibility: ChromeVisibility.Visible
    }
    
    Container {
        layout: DockLayout {
        }
        
        //background: Color.create("#ededed");
        ImageView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            imageSource: "asset:///images/backgrounds/bg.jpg"
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

                    if (albumPage.albumViewPage == null) {
                        albumPage.albumViewPage = albumViewDefinition.createObject();

                        albumPage.albumViewPage.navParent = corePane;
                    }

                    if(dataModel.data (indexPath).albumid=="-3"){
                        albumPage.albumViewPage.newCards = true;
                    }
                    navParent.push(albumPage.albumViewPage);
                    albumPage.albumViewPage.loadAlbum(dataModel.data (indexPath).albumid);
                }
            }
        
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }    
    }

    attachedObjects: [
        /*Sheet {
            id: albumViewSheet
            
            AlbumView{
                id: albumView
                
                onCancel: {
                    albumViewSheet.close();
                }
            }
        }*/
        ComponentDefinition {
            id: albumViewDefinition
            source: "AlbumView.qml"
        }
    ]
}
