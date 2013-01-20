import bb.cascades 1.0

Container {
    layout: DockLayout {
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
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
         
            Option {
                text : "Hermanus"
                value : "-34.41,19.25"
                
                onSelectedChanged : {
                    if (selected == true) {
                        weatherClass.getWeather("-34.41,19.25");
                    }
                }
            }
            
            Option {
                text : "Knysna"
                value : "-34.03,23.03"
                
                onSelectedChanged : {
                    if (selected == true) {
                        weatherClass.getWeather("-34.03,23.03");
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
            
            Container {
                background: Color.Gray
                            
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                
                Label { 
                    text: "Time"
                    textStyle.fontSize: FontSize.XSmall
                }
                
                Label {
                    text: "Conditions"
                    textStyle.fontSize: FontSize.XSmall
                    bottomMargin: 44.0
                }
                Label {
                    text: "Wind Speed (Kmph)"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Wind Direction"
                    textStyle.fontSize: FontSize.XSmall
                    bottomMargin: 80.0
                }
                Label {
                    text: "Temperature (C)"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Cloud Cover"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Pressure (hPa)"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Humidity (%)"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Swell Height (m)"
                    textStyle.fontSize: FontSize.XSmall
                }
                Label {
                    text: "Swell Direction"
                    textStyle.fontSize: FontSize.XSmall
                    bottomMargin: 80.0
                }
            }
            ListView {
                id: listView
                objectName: "weatherListView"
                layout: StackListLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
            }
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
