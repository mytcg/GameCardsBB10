import bb.cascades 1.0

// Import the custom library that contains the Employee type, so you can use
// this type in QML. For example, you might need to use the Employee type in
// QML to respond to the selection of an employee in the list.
import myLibrary 1.0
  
Page {
    actions: [
        // An action item that calls the C++ function that retrieves
        // the contact list
        ActionItem {
            title: "Refresh"
            onTriggered: app.initiateRequest()
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]        
    content: Container {
        layout: DockLayout {}
        attachedObjects: [
            // Add the data model as an attached object. Make sure
            // to specify a value for the objectName property,
            // which is used to access the model from C++.
            GroupDataModel {
                id: groupDataModel
  
                // Sort the data first by last name, then by first
                // name
                sortingKeys: ["lastName", "firstName"]
            }
        ]
         
        // A list that has two list item components, one for a header
        // and one for contact names. The list has an object name so
        // that we can set the data model from C++.
        ListView {
            objectName: "list"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
                         
            layout: FlowListLayout {
                 
            }
            // A simple data model is loaded with just a header.
            // This will be replaced when we load the real one
            // from C++.
            dataModel: groupDataModel
             
            listItemComponents: [
                // The contact list item displays the name of the contact
                ListItemComponent {
                    type: "listItem"
                    StandardListItem {
                        title: ListItemData.lastName + ", " +
                                   ListItemData.firstName
                        description: ListItemData.employeeNumber
                    }
                }
            ]
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "indicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200    
            preferredHeight: 200   
        }
    }
}