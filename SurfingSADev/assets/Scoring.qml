import bb.cascades 1.0
NavigationPane {
    id: navPane

    peekEnabled: false
    property Page heatScorePage: null
    property bool loaded: false

    function loadEvents() {
        loaded = true;
        scoreContainer.enabled = false;

        eventDropDown.removeAll()
        categoryDropDown.removeAll()
        roundDropDown.removeAll()
        heatDropDown.removeAll()

        if (radioGroup.selectedIndex == 0) {
            scoringClass.getCurrentEvents()
        } else if (radioGroup.selectedIndex == 1) {
            scoringClass.getArchiveEvents()
        }
    }

    function loadCategories() {
        scoreContainer.enabled = false;

        categoryDropDown.removeAll()
        roundDropDown.removeAll()
        heatDropDown.removeAll()

        if (eventDropDown.selectedIndex >= 0) {
            scoringClass.getCategories(eventDropDown.selectedValue)
        }
    }

    function loadRounds() {
        scoreContainer.enabled = false;

        roundDropDown.removeAll()
        heatDropDown.removeAll()

        if (categoryDropDown.selectedIndex >= 0) {
            scoringClass.getRounds(categoryDropDown.selectedValue)
        }
    }

    function loadHeats() {
        scoreContainer.enabled = false;

        heatDropDown.removeAll()

        if (roundDropDown.selectedIndex >= 0) {
            scoringClass.getHeats(roundDropDown.selectedValue)
        }
    }
    Page {

		Container {
		    
		    layout: DockLayout {
		        
		    }
		    
	        /*ImageView {
	            horizontalAlignment: HorizontalAlignment.Fill
	            verticalAlignment: VerticalAlignment.Fill
	            imageSource: "asset:///images/backgrounds/bg.jpg"
	        }*/
	
	        attachedObjects: [
	            ImagePaintDefinition {
	                id: backgroundPaint
	                imageSource: "asset:///images/backgrounds/bg.jpg"
	                repeatPattern: RepeatPattern.Fill
	            }
	        ]
	
	        background: backgroundPaint.imagePaint
	
	        horizontalAlignment: HorizontalAlignment.Fill
	        verticalAlignment: VerticalAlignment.Fill
	
            Container {
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top

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
                    ImageView {
                        imageSource: "asset:///images/tabs/scoring_icon_tab.png"
                        verticalAlignment: VerticalAlignment.Center
                    }
                    Label {
                        text: "SCORES"
                        textStyle.color: Color.LightGray
                        verticalAlignment: VerticalAlignment.Center
                        textStyle.fontSize: FontSize.Small
                    }
                }
            }

			ScrollView {
                // Scrolling is restricted to vertical direction only, in this particular case.
                scrollViewProperties {
                    scrollMode: ScrollMode.Vertical
                }

                Container {
                    topPadding: 165
                    bottomPadding: 10
                    leftPadding: 10
                    rightPadding: 10

                    id: scoreContainer
                    objectName: "scoreContainer"
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

                    Container {
                        RadioGroup {
                            id: radioGroup

                            Option {
                                text: "Live Events"
                                selected: true
                            }

                            Option {
                                text: "Archive"
                            }

                            onSelectedIndexChanged: {
                                loadEvents()
                            }
                        }
                        attachedObjects: [
                            ImagePaintDefinition {
                                id: radioBack
                                imageSource: "asset:///images/backgrounds/big_label.png"
                                repeatPattern: RepeatPattern.XY
                            }
                        ]
                        background: radioBack.imagePaint
                    }

                    DropDown {
                        objectName: "scoringEventDropDown"
                        id: eventDropDown
                        horizontalAlignment: HorizontalAlignment.Center
                        bottomMargin: 50

                        title: "Competition"

                        onSelectedIndexChanged: {
                            loadCategories()
                        }
                    }

                    DropDown {
                        objectName: "scoringCategoryDropDown"
                        id: categoryDropDown
                        horizontalAlignment: HorizontalAlignment.Center
                        bottomMargin: 50

                        title: "Division"

                        onSelectedIndexChanged: {
                            loadRounds()
                        }
                    }

                    DropDown {
                        objectName: "scoringRoundDropDown"
                        id: roundDropDown
                        horizontalAlignment: HorizontalAlignment.Center
                        bottomMargin: 50

                        title: "Round"

                        onSelectedIndexChanged: {
                            loadHeats()
                        }
                    }
                    
                    DropDown {
                        objectName: "scoringHeatDropDown"
                        id: heatDropDown
                        horizontalAlignment: HorizontalAlignment.Center
                        bottomMargin: 50

                        title: "Heat"

                        onSelectedIndexChanged: {
                            if (selectedIndex != -1) {
                                if (heatScorePage == null) {
                                    heatScorePage = heatScoreDefinition.createObject()
                                }
                                navPane.push(heatScorePage)
                                heatScorePage.navParent = navPane;
                                heatScorePage.event = eventDropDown.selectedOption.text
                                heatScorePage.group = categoryDropDown.selectedOption.text
                                heatScorePage.round = roundDropDown.selectedOption.text
                                heatScorePage.heat = heatDropDown.selectedOption.text
                                heatScorePage.init(heatDropDown.selectedValue, (radioGroup.selectedIndex == 0))
                            }
                        }
                    }
                    /*Button {
                     * id: findScoreButton
                     * text: "View Scores"
                     * horizontalAlignment: HorizontalAlignment.Center
                     * 
                     * enabled: {
                     * heatDropDown.selectedIndex >= 0
                     * }
                     * 
                     * onClicked: {
                     * if (heatScorePage == null) {
                     * heatScorePage = heatScoreDefinition.createObject();
                     * }
                     * navPane.push(heatScorePage);
                     * heatScorePage.navParent = navPane;
                     * heatScorePage.event = eventDropDown.selectedOption.text
                     * heatScorePage.group = categoryDropDown.selectedOption.text
                     * heatScorePage.heat = heatDropDown.selectedOption.text
                     * heatScorePage.init(heatDropDown.selectedValue, (radioGroup.selectedIndex == 0))
                     * }
                     * }*/
                }
            }
		
		    // The activity indicator has an object name set so that
		    // we can start and stop it from C++
		    ActivityIndicator {
		        objectName: "scoringIndicator"
		        verticalAlignment: VerticalAlignment.Center
		        horizontalAlignment: HorizontalAlignment.Center
		        preferredWidth: 100
		        preferredHeight: 100
		        
		        onStopped: {
		            //cancelScreen()
		        }
		    }
		}
		
		attachedObjects: [
	        ComponentDefinition {
                id:heatScoreDefinition
                source: "HeatScores.qml"
            }
        ]
	}
}
