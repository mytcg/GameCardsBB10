import bb.cascades 1.0

Page {
    id: cardPage
    signal cancel()

    property string cardId: "0"
    property string newCard: "false"
    property string fronturl: ""
    property string backurl: ""
    property string flip: "1"

    function loadImage(String) {
        cardClass.loadImage(String);
    }

    Container {
        layout: DockLayout {
        }

        background: Color.create("#ededed")

        Label {
            id: cardLabel
            objectName: "cardLabel"
            text: "0"
            visible: false
        }
        ImageView {
            id: cardView
            objectName: "cardView"
            preferredHeight: 700
            preferredWidth: 500
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            imageSource: "asset:///images/loading.png"
            gestureHandlers: [
                TapHandler {
                    onTapped: {
                        if (newCard == "true") {
                            cardClass.save(cardId);
                        } else {
                            if (flip == "0") {
                                cardPage.loadImage(fronturl);
                                flip = "1";
                            } else {
                                cardPage.loadImage(backurl);
                                flip = "0";
                            }
                        }
                    }
                }
            ]
        }
        Button {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            text: "Reject"
            visible: (newCard == "true" ? true : false)
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
            preferredWidth: 100
            preferredHeight: 100

            onStopped: {
            }
        }
    }
}