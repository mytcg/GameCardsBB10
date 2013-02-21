import bb.cascades 1.0

Page {
    id: albumViewPage
    property NavigationPane navParent: null
    //vars for pages
    property Page cardPage: null

    property string newCards: "false"

    signal cancel()

    function loadAlbum(String) {
        albumViewClass.loadAlbum(String);
    }

    Container {
        layout: DockLayout {
        }

        /*ImageView {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            imageSource: "asset:///images/backgrounds/bg.jpg"
        }*/
        //background: Color.create("#ededed");

        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
            }
        ]

        background: backgroundPaint.imagePaint

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            Container {
                layout: DockLayout {
                }

                ImageView {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    imageSource: "asset:///images/header/header.png"
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    topPadding: 20
                    Label {
                        text: "ALBUM"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

            ListView {
                objectName: "albumViewView"
                horizontalAlignment: HorizontalAlignment.Fill

                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            title: ListItemData.description + " (" + ListItemData.quantity + ")"
                            horizontalAlignment: HorizontalAlignment.Center
                            imageSource: (ListItemData.quantity=="0"?"asset:///images/emptythumb.png":"asset:///images/loading.jpg")
                            minHeight: 66
                            /*onCreationCompleted: {
                             * imageloaderClass.loadImage(ListItemData.thumburl, this);
                             * }*/
                        }
                    }
                ]
                onTriggered: {
                    clearSelection();
                    if (dataModel.data(indexPath).quantity != "0") {
                        if (albumViewPage.cardPage == null) {
                            albumViewPage.cardPage = cardDefinition.createObject();
                        }
                        navParent.push(albumViewPage.cardPage);

                        albumViewPage.cardPage.cardId = dataModel.data(indexPath).cardid;
                        albumViewPage.cardPage.newCard = newCards;
                        albumViewPage.cardPage.fronturl = dataModel.data(indexPath).fronturl;
                        albumViewPage.cardPage.backurl = dataModel.data(indexPath).backurl;
                        albumViewPage.cardPage.loadImage(dataModel.data(indexPath).fronturl);
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
            preferredWidth: 100
            preferredHeight: 100

            onStopped: {
            }
        }

        Label {
            id: albumLabel
            objectName: "albumViewLabel"
            text: "0"
            visible: false
        }
    }
    attachedObjects: [
        /*Sheet {
         * id: cardSheet
         * peekEnabled: false
         * Card{
         * id: card
         * 
         * onCancel: {
         * cardSheet.close();
         * }
         * }
         * }*/

        ComponentDefinition {
            id: cardDefinition
            source: "Card.qml"
        }
    ]
}
