import bb.cascades 1.0

Page {
    id: auctionPage
        signal cancel ()
        
        titleBar: TitleBar {
            title: "Auctions"
            visibility: ChromeVisibility.Visible
            
            acceptAction: ActionItem {
                title: "Back"
                onTriggered: {
                    auctionPage.cancel();
                }
            }
        }
     Container {
        layout: DockLayout {
        }
        Label {
            id: albumLabel
            objectName: "auctionLabel"
            text: "0"
            visible: false
        }
        ListView {
            objectName: "auctionView"
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            
            layout: FlowListLayout {
            
            }
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.albumname + ", " +
ListItemData.firstName
                        description: ListItemData.employeeNumber
                    }
                }
            ]
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadAuctionsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
            }
        }    
    }
}
