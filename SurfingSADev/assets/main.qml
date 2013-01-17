// Navigation pane project template
import bb.cascades 1.0

Page {
    
    titleBar: TitleBar {
        title: "Surfing SA"
        visibility: ChromeVisibility.Visible
    }
    
    content: Container {
        layout: DockLayout {}
        
	    MainMenu {
            id: mainMenu
            
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
        }
    }
    
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
