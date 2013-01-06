import bb.cascades 1.0


Page {
    id: albumPage
    signal cancel ()
    
    function loadAlbums() {
        albumClass.loadAlbums("0");
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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: albumLabel
            objectName: "albumLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "albumView"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            dataModel: GroupDataModel {
                sortingKeys: ["albumname"]
            }
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
}
