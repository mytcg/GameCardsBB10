import bb.cascades 1.0

Page {
    property NavigationPane navParent: null
    property bool currentEvent : false

    property alias event: eventLabel.text
    property alias group: groupLabel.text
    property alias round: roundLabel.text
    property alias heat: heatLabel.text
    

    id: heatScoresPage
    signal cancel ()

	function init(heat, current) {
        currentEvent = current

        heatScoreClass.getHeatScores(heat, current)
    }
    
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
                        text: "HEAT SCORE"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                topPadding: 10
                bottomPadding: 10
                leftPadding: 10
                rightPadding: 10

                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    Label {
                        text: "Competition: "
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }

                    Label {
                        id: eventLabel
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    Label {
                        text: "Division: "
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }

                    Label {
                        id: groupLabel
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    Label {
                        text: "Round: "
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }

                    Label {
                        id: roundLabel
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    bottomMargin: 20

                    Label {
                        text: "Heat: "
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }

                    Label {
                        id: heatLabel
                        textStyle.fontSize: FontSize.Large
                        textStyle.color: Color.DarkGray
                    }
                }

                ListView {
                    id: listView
                    objectName: "heatListView"
                    layout: StackListLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                }
            }
        }
        
		Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            // The activity indicator has an object name set so that
            // we can start and stop it from C++
            ActivityIndicator {
                objectName: "heatScoreIndicator"
                preferredWidth: 100
                preferredHeight: 100

                onStopped: {
                    //cancelScreen()
                }
            }
            Label {
                id: scoresRefreshingLabel
                objectName: "scoresRefreshingLabel"
                textStyle.fontSize: FontSize.XXSmall
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
    }

    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                if (currentEvent) {
                    scoresRefreshingLabel.text = ""
                    heatScoreClass.stopRefresh()
                }
                navParent.pop();
            }
        }
    }
}