import bb.cascades 1.0

Page {
    Container {
        layout: DockLayout {
        }
        ListView {
            verticalAlignment: VerticalAlignment.Center
            dataModel: ArrayDataModel {
            }
            listItemComponents: [
                
            ]
        }
        Button {
            id: btnExit
            text: "Exit"
        }
    }
}
