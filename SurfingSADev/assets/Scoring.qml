import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: "Surfing SA"
        visibility: ChromeVisibility.Visible
    }
    
    function loadEvents() {
        scoreContainer.enabled = false;
        
        eventDropDown.removeAll()
        categoryDropDown.removeAll()
        heatDropDown.removeAll()
        
        if (radioGroup.selectedIndex == 0) {
            scoringClass.getCurrentEvents()
        }
        else if (radioGroup.selectedIndex == 1) {
            scoringClass.getArchiveEvents()
        }
    }
    
    function loadCategories() {
        scoreContainer.enabled = false;
        
        categoryDropDown.removeAll()
        heatDropDown.removeAll()
        
        if (eventDropDown.selectedIndex >= 0) {
            scoringClass.getCategories(eventDropDown.selectedValue)
        }
    }
    
    function loadHeats() {
        scoreContainer.enabled = false;
        
        heatDropDown.removeAll()
        
        if (categoryDropDown.selectedIndex >= 0) {
            scoringClass.getHeats(categoryDropDown.selectedValue)
        }
    }
    
	Container {
	    
	    layout: DockLayout {
	        
	    }
	    
	    background: Color.create("#ededed");
        
        topPadding: 10
	    bottomPadding: 10
	    leftPadding: 10
	    rightPadding: 10
	    
	    horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
	    
	    Container {
	        id: scoreContainer
	        objectName: "scoreContainer"
	        layout: StackLayout {
	            orientation: LayoutOrientation.TopToBottom
	        }
	        horizontalAlignment: HorizontalAlignment.Fill
	        verticalAlignment: VerticalAlignment.Fill

            RadioGroup {
	            id: radioGroup
	            
	            Option { 
	                text: "Live Scores"
	                selected: true
	            }
	            
	            Option { 
	                text: "Archive"
	            }
	            
	            onSelectedIndexChanged: {
	                loadEvents()
	            }
	        }

            DropDown {
	            objectName: "scoringEventDropDown"
	            id: eventDropDown
	            horizontalAlignment: HorizontalAlignment.Center
	            bottomMargin: 50
	                        
	            title : "Event"
	         
	            onSelectedIndexChanged : {
	                loadCategories()
	            }
	        }
	        
	        DropDown {
	            objectName: "scoringCategoryDropDown"
	            id: categoryDropDown
	            horizontalAlignment: HorizontalAlignment.Center
	            bottomMargin: 50
	            
	            title : "Group"
	         
	            onSelectedIndexChanged : {
	                loadHeats()
	            }
	        }
	        
	        DropDown {
	            objectName: "scoringHeatDropDown"
	            id: heatDropDown
	            horizontalAlignment: HorizontalAlignment.Center
	            bottomMargin: 50
	            
	            title : "Heat"
	        }
	        Button {
	            id: findScoreButton
	            text: "View Scores"
	            horizontalAlignment: HorizontalAlignment.Center
	            
	            enabled: {heatDropDown.selectedIndex >= 0}
	            
	            onClicked: {
                    heatSheet.open()
                    heatScores.event = eventDropDown.selectedOption.text
                    heatScores.group = categoryDropDown.selectedOption.text
                    heatScores.heat = heatDropDown.selectedOption.text
                    heatScores.init(heatDropDown.selectedValue, (radioGroup.selectedIndex == 0))
	            }
	        }
	    }
	
	    // The activity indicator has an object name set so that
	    // we can start and stop it from C++
	    ActivityIndicator {
	        objectName: "scoringIndicator"
	        verticalAlignment: VerticalAlignment.Center
	        horizontalAlignment: HorizontalAlignment.Center
	        preferredWidth: 200
	        preferredHeight: 200
	        
	        onStopped: {
	            //cancelScreen()
	        }
	    }
	}
	
	attachedObjects: [
        Sheet {
            id: heatSheet
            peekEnabled: false
            HeatScores{
                id: heatScores
                
                onCancel: {
                    heatSheet.close();
                }
            }
        }
    ]
}
