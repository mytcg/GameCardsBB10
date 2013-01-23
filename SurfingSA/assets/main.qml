// Navigation pane project template
import bb.cascades 1.0

MainMenu {
    id: mainMenu
    
    function checkLoggedIn() {
        var loggedIn = app.loggedIn()
        
        if (loggedIn == "false") {
            // show detail page when the button is clicked
            loginSheet.open()
        }
    }
    
    attachedObjects: [
        Sheet {
            id: loginSheet
            Login {
                objectName: "loginPage"
                
                onCancel: {
                    loginSheet.close();
                }
            }
        }
    ]
    
    onCreationCompleted: {
        checkLoggedIn()
    }
}
