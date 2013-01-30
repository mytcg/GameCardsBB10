import bb.cascades 1.0

Container {
    layout: DockLayout {
        
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        leftPadding: 15
        rightPadding: 15
        topPadding: 10
        
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        DropDown {
            objectName: "locationDropDown"
            
            title : "Location"
         
            onSelectedIndexChanged : {
                console.log("SelectedIndex was changed to " + selectedIndex);
                console.log("selectedOption.value " + selectedOption.value);
                console.log("selectedOption.text: " + selectedOption.text);
                weatherClass.getWeather(selectedOption.value);
            }
            
            Option { text: "Anstey's Beach"; value: "coords-29.92,31.01" }
			Option { text: "Bayhead"; value: "coords-29.89,31.01" }
			Option { text: "Betty's Bay"; value: "coords-34.34,18.92" }
			Option { text: "Big Bay"; value: "coords-33.79,18.45" }
			Option { text: "Bluewater Bay"; value: "coords-33.84,25.63" }
			Option { text: "Bonza Bay"; value: "coords-32.97,27.95" }
			Option { text: "Brandfontein"; value: "coords-34.76,19.88" }
			Option { text: "Brandvlei"; value: "coords-30.46,20.48" }
			Option { text: "Buffels Baai"; value: "coords-34.08,22.97" }
			Option { text: "Cannon Rocks"; value: "coords-33.75,26.54" }
			Option { text: "Cape Point"; value: "coords-34.25,18.41" }
			Option { text: "Cape Saint Francis"; value: "coords-34.19,24.83" }
			Option { text: "Cape Town"; value: "coords-33.92,18.42" }
			Option { text: "Clanwilliam Dam"; value: "coords-32.23,18.91" }
			Option { text: "Cola Beach"; value: "coords-34.03,22.81" }
			Option { text: "DerdeSteen"; value: "coords-33.76,18.44" }
			Option { text: "Dolphin Beach"; value: "coords-33.83,18.48" }
			Option { text: "Durban"; value: "coords-29.85,31.02" }
			Option { text: "East London"; value: "coords-32.98,27.86" }
			Option { text: "Elandsbaai"; value: "coords-32.31,18.35" }
			Option { text: "Fishhoek"; value: "coords-34.13,18.41" }
			Option { text: "Franskraal"; value: "coords-34.60,19.39" }
			Option { text: "Gansbaai"; value: "coords-34.58,19.34" }
			Option { text: "Gariep Dam"; value: "coords-30.62,25.50" }
			Option { text: "Glencairn"; value: "coords-34.16,18.42" }
			Option { text: "Grootdraai Dam"; value: "coords-26.90,29.30" }
			Option { text: "Haakgat"; value: "coords-33.75,18.43" }
			Option { text: "Hawston"; value: "coords-34.38,19.13" }
			Option { text: "Hazyview"; value: "coords-25.03,31.11" }
			Option { text: "Hermanus"; value: "coords-34.40,19.25" }
			Option { text: "Humewood Links"; value: "coords-33.94,25.60" }
			Option { text: "Jeffrey's Bay"; value: "coords-34.04,24.92" }
			Option { text: "Kenton on Sea"; value: "coords-33.68,26.67" }
			Option { text: "Kings Beach"; value: "coords-33.96,25.64" }
			Option { text: "Kleinmond"; value: "coords-34.33,19.01" }
			Option { text: "Knysna"; value: "coords-34.03,23.06" }
			Option { text: "Kommetjie / Witsands"; value: "coords-34.14,18.32" }
			Option { text: "Koppies Dam"; value: "coords-27.25,27.67" }
			Option { text: "La Mercy Lagoon"; value: "coords-29.64,31.12" }
			Option { text: "Langebaan"; value: "coords-33.09,18.03" }
			Option { text: "Macassar"; value: "coords-34.04,18.74" }
			Option { text: "Maitlands"; value: "coords-33.98,25.29" }
			Option { text: "Margate"; value: "coords-30.85,30.37" }
			Option { text: "Melkbos Beach"; value: "coords-33.72,18.44" }
			Option { text: "Middle Beach"; value: "coords-34.18,18.35" }
			Option { text: "Milnerton"; value: "coords-33.86,18.50" }
			Option { text: "Misty Cliffs"; value: "coords-34.18,18.36" }
			Option { text: "Mossel Bay"; value: "coords-34.18,22.13" }
			Option { text: "Muizenberg"; value: "coords-34.08,18.49" }
			Option { text: "Mykonos"; value: "coords-33.04,18.04" }
			Option { text: "Myoli Beach"; value: "coords-34.03,22.80" }
			Option { text: "Nahoon Beach"; value: "coords-32.98,27.94" }
			Option { text: "Noordhoek Beach"; value: "coords-34.09,18.36" }
			Option { text: "Palm Beach"; value: "coords-30.97,30.27" }
			Option { text: "Pearly Beach / Dyer Island"; value: "coords-34.65,19.48" }
			Option { text: "Pelican Island"; value: "coords-28.80,32.08" }
			Option { text: "Plettenberg Bay"; value: "coords-34.05,23.36" }
			Option { text: "Port Alfred"; value: "coords-33.60,26.88" }
			Option { text: "Port Elizabeth"; value: "coords-33.93,25.56" }
			Option { text: "Porterville"; value: "coords-33.01,18.98" }
			Option { text: "Pringle Bay"; value: "coords-34.35,18.81" }
			Option { text: "Richards Bay"; value: "coords-28.78,32.03" }
			Option { text: "Rietvlei"; value: "coords-25.87,28.27" }
			Option { text: "Sandy Bay Beach"; value: "coords-34.02,18.33" }
			Option { text: "Sardinia Bay"; value: "coords-34.01,24.50" }
			Option { text: "Scarborough"; value: "coords-34.19,18.37" }
			Option { text: "Scottburg"; value: "coords-30.28,30.75" }
			Option { text: "Sedgefield"; value: "coords-34.02,22.80" }
			Option { text: "Shark Bay"; value: "coords-33.98,25.64" }
			Option { text: "Shelley Point"; value: "coords-32.71,17.97" }
			Option { text: "Silverstroomstrand"; value: "coords-33.58,18.35" }
			Option { text: "Sodwana Bay"; value: "coords-27.55,32.66" }
			Option { text: "Sterkfontein Dam"; value: "coords-28.44,29.02" }
			Option { text: "Stilbaai"; value: "coords-34.36,21.43" }
			Option { text: "Stony Point"; value: "coords-33.02,27.85" }
			Option { text: "Strand"; value: "coords-34.10,18.81" }
			Option { text: "Strandfontein"; value: "coords-34.07,18.57" }
			Option { text: "Struisbaai"; value: "coords-34.80,20.04" }
			Option { text: "Suiderstrand"; value: "coords-34.81,19.95" }
			Option { text: "Sunset Beach"; value: "coords-33.85,18.49" }
			Option { text: "Swartriet"; value: "coords-32.95,17.90" }
			Option { text: "Theewater"; value: "coords-33.89,18.66" }
			Option { text: "Tsitsikamma national park, Storms river"; value: "coords-32.21,26.58" }
			Option { text: "Umdloti"; value: "coords-29.66,31.11" }
			Option { text: "Umhlanga"; value: "coords-29.72,31.08" }
			Option { text: "Vaaldam"; value: "coords-26.94,28.17" }
			Option { text: "Vetch's Beach"; value: "coords-29.88,30.99" }
			Option { text: "Voëlvlei"; value: "coords-33.92,18.66" }
			Option { text: "Warner Beach"; value: "coords-30.08,30.86" }
			Option { text: "Wilderness, Garden Route"; value: "coords-33.99,22.58" }
			Option { text: "Witsand (Breede River)"; value: "coords-34.39,20.85" }
			Option { text: "Yzerfontein"; value: "coords-33.35,18.15" }
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
            visible: false
            objectName: "weatherTitleList"
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
