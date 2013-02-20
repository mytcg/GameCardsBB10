import bb.cascades 1.0


Page {
    id: boosterPage
    
    signal cancel ()
    
    titleBar: TitleBar {
        title: "Possible Cards"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                boosterPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        
        background: Color.create("#ededed");
        
        ListView {
            objectName: "boosterList"
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
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
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadBoosterIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }    
    }
}
