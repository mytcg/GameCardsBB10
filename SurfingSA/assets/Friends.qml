import bb.cascades 1.0

Page {
    id: friendsPage
    property NavigationPane navParent: null
    signal cancel ()
    
    Container {
        layout: DockLayout {
        }
        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
            }
        ]

        background: backgroundPaint.imagePaint
        Container {
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

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
                        text: "FRIENDS"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

            Label {
                id: friendsLabel
                objectName: "friendsLabel"
                text: "0"
                visible: false
            }
            ListView {
                objectName: "friendsView"
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill

                layout: FlowListLayout {

                }

                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        /*StandardListItem {
                         * 
                         * description: ListItemData.usr + "\n" +
                         * ListItemData.val+ "\n" +ListItemData.desc
                         * 
                         * }*/
                        Container {
                            //touchPropagationMode: TouchPropagationMode.Full
                            rightPadding: 5.0
                            topPadding: 5.0
                            bottomPadding: 5.0
                            leftPadding: 5.0
                            Label {
                                text: ListItemData.usr
                                textStyle.color: Color.DarkGray
                            }
                            Label {
                                text: ListItemData.val
                                textStyle.color: Color.DarkGray
                            }
                            Label {
                                text: ListItemData.desc
                                textStyle.color: Color.DarkGray
                            }
                            Divider {
                                verticalAlignment: VerticalAlignment.Bottom
                                horizontalAlignment: HorizontalAlignment.Center
                            }
                        }
                    }
                ]
            }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadFriendsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }    
    }
}
