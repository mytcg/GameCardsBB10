import bb.cascades 1.0

Container {
    layout: DockLayout {
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        leftPadding: 20
        rightPadding: 20
        topPadding: 10
        
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        DropDown {
            objectName: "locationDropDown"
            
            title : "Location"
         
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
        Label {
            objectName: "dateLabel"
            textStyle.fontSize: FontSize.Small
            textStyle.color: Color.DarkGray
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Right
            leftPadding: 50
            bottomMargin: 15
            Label {
                text: "Max "
                textStyle.fontSize: FontSize.Large
                visible: false
                objectName: "maxTempLabelHeader"
                textStyle.fontWeight: FontWeight.W300
                textStyle.color: Color.DarkGray
                verticalAlignment: VerticalAlignment.Bottom
            }
            Label {
                objectName: "maxTempLabel"
                textStyle.fontSize: FontSize.XXLarge
                textStyle.fontWeight: FontWeight.W300
                textStyle.color: Color.DarkGray
            }
            Label {
                text: "Min "
                textStyle.fontSize: FontSize.Large
                visible: false
                objectName: "minTempLabelHeader"
                textStyle.fontWeight: FontWeight.W300
                textStyle.color: Color.DarkGray
                verticalAlignment: VerticalAlignment.Bottom
            }
            Label {
                objectName: "minTempLabel"
                textStyle.fontSize: FontSize.XXLarge
                textStyle.fontWeight: FontWeight.W300
                textStyle.color: Color.DarkGray
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    text: "Time"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Conditions"
                    textStyle.fontSize: FontSize.XXSmall
                    bottomMargin: 50.0
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Wind Speed (Kmph)"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Wind Direction"
                    textStyle.fontSize: FontSize.XXSmall
                    bottomMargin: 34.0
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Temperature (C)"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Cloud Cover"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Pressure (hPa)"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Humidity (%)"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Swell Height (m)"
                    textStyle.fontSize: FontSize.XXSmall
                    textStyle.color: Color.DarkGray
                }
                Label {
                    text: "Swell Direction"
                    textStyle.fontSize: FontSize.XXSmall
                    bottomMargin: 36.0
                    textStyle.color: Color.DarkGray
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
