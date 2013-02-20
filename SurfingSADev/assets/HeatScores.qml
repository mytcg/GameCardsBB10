import bb.cascades 1.0

Page {
    property bool currentEvent : false

    property alias event: eventLabel.text
    property alias group: groupLabel.text
    property alias heat: heatLabel.text
    

    id: heatScoresPage
    signal cancel ()

	function init(heat, current) {
        currentEvent = current

        heatScoreClass.getHeatScores(heat, current)
    }

    titleBar: TitleBar {
        title: "Scores"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Back"
            onTriggered: {
                if (currentEvent) {
                    scoresRefreshingLabel.text = ""
                    heatScoreClass.stopRefresh()
                }
                heatScoresPage.cancel();
            }
        }
    }
    
    Container {
        layout: DockLayout {
        }
        
        background: Color.create("#ededed")

        topPadding: 10
	    bottomPadding: 10
	    leftPadding: 10
	    rightPadding: 10

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                Label {
                    text: "Event: "
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
                    text: "Group: "
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

            Container {
	            horizontalAlignment: HorizontalAlignment.Fill
	            verticalAlignment: VerticalAlignment.Fill
	
	            layout: StackLayout {
	                orientation: LayoutOrientation.LeftToRight
	            }
	
	            Container {
	                layout: StackLayout {
	                    orientation: LayoutOrientation.TopToBottom
	                }
	
	                verticalAlignment: VerticalAlignment.Fill
	                topPadding: 20
	
	                Label {
	                    objectName: "heatParticipantsLabel"
	                    visible: false
	                    text: "Participants\n "
	                    textStyle.fontSize: FontSize.XSmall
	                    textStyle.color: Color.DarkGray
	                    multiline: true
	                }
	
	                Container {
	                    layout: StackLayout {
	                        orientation: LayoutOrientation.TopToBottom
	                    }
	                    objectName: "heatWaveList"
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
                preferredWidth: 200
                preferredHeight: 200

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
}