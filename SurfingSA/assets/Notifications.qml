import bb.cascades 1.0

Page {
    id: notificationsPage
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
                        text: "NOTIFICATIONS"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

            Label {
                id: notificationsLabel
                objectName: "notificationsLabel"
                text: "0"
                visible: false
            }
            ListView {
                objectName: "notificationsView"
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill

                layout: FlowListLayout {

                }

                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            touchPropagationMode: TouchPropagationMode.Full
                            rightPadding: 5.0
                            topPadding: 5.0
                            bottomPadding: 5.0
                            leftPadding: 5.0
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
            objectName: "loadNotificationsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }    
    }
}
