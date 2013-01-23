import bb.cascades 1.0


Page {
    id: cardPage
    signal cancel ()
    
    property string cardId: "0";
    property string newCard: "false";
    property string fronturl: "";
    property string backurl: "";
    property string flip: "1";
    
    function loadImage(String) {
        cardClass.loadImage(String);
    }
    
    titleBar: TitleBar {
        title: "Album"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                cardView.setImageSource("asset:///images/loading.png");
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
            id: cardView
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
                }else{
                    if(flip=="0"){
                        cardPage.loadImage(fronturl);
                        flip = "1";
                    }else{
                        cardPage.loadImage(backurl);
                        flip = "0";
                    }
                }
            }
        }
        Button{
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
            text: "Reject" 
            visible: (newCard=="true"?true:false)
            onClicked: {
                cardClass.reject(cardId);         
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
}
