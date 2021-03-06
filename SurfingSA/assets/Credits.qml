import bb.cascades 1.0

Page {
    id: creditsPage
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
                        text: "CREDITS"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                leftPadding: 20
                rightPadding: 20
                topPadding: 10

                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill

                Label {
                    id: creditsLabel
                    objectName: "creditsLabel"
                    text: "0"
                    visible: false
                }
                Label {
                    text: "Credits"
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle.color: Color.DarkGray
                }
                TextField {
                    id: creditsText
                    objectName: "creditsText"
                    text: "0"
                    enabled: false
                }
                Label {
                    text: "Premium"
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle.color: Color.DarkGray
                }
                TextField {
                    id: premiumText
                    objectName: "premiumText"
                    text: "0"
                    enabled: false
                }
                ListView {
                    objectName: "creditsView"
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center

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
        }
        
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "loadCreditsIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
            }
        }
    }
}
