import bb.cascades 1.0

Container {
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    
    DropDown {
        objectName: "locationDropDown"
        
        title : "Location"
        enabled : true
     
        onSelectedIndexChanged : {
            console.log("SelectedIndex was changed to " + selectedIndex);
        }
     
        // text + description
        Option {
            text : "George"
            value : "-33.97,22.45"
            
            onSelectedChanged : {
                if (selected == true) {
                    weatherClass.getWeather("-33.97,22.45");
               }
            }
        }
     
        Option {
            text : "Gordon's Bay"
            value : "-34.15,18.87"
      
            onSelectedChanged : {
                if (selected == true) {
                    weatherClass.getWeather("-34.15,18.87");
               }
            }
        }
     
        // text only
        Option {
            text : "Hermanus"
            value : "-34.41,19.25"
            
            onSelectedChanged : {
                if (selected == true) {
                    weatherClass.getWeather("-34.41,19.25");
                }
            }
        }
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Label {
            text: "Date: "
        }
        
        Label {
            objectName: "dateLabel"
        }   
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Label {
            text: "Time: "
        }
        
        Label {
            objectName: "timeLabel"
        }   
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Label {
            text: "Maximum Temperature: "
        }
        
        Label {
            objectName: "maxTempLabel"
        }  
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Label {
            text: "Minimum Temperature: "
        }
        
        Label {
            objectName: "minTempLabel"
        }  
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Label {
            text: "Current Temperature: "
        }
        
        Label {
            objectName: "currentTempLabel"
        }  
    }
    
    ActivityIndicator {
        objectName: "weatherIndicator"
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        preferredWidth: 200
        preferredHeight: 200
    }
}