// Navigation pane project template
import bb.cascades 1.0

Page {
    
    content: Container {
        Container {
            layout: StackLayout {}
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            Container {
                
                horizontalAlignment: HorizontalAlignment.Center
			    
			    layout: StackLayout {
			        orientation: LayoutOrientation.LeftToRight
			    }
			    
			    // An ImageButton
				ImageButton {
				    id: headerCoreButton
				    defaultImageSource: "asset:///images/header/crosslogo.png"
				    pressedImageSource: "asset:///images/header/crosslogo.png"
				    disabledImageSource: "asset:///images/header/crosslogo.png"
				    enabled: true
				    verticalAlignment: VerticalAlignment.Center
			        horizontalAlignment: HorizontalAlignment.Center
				    
				    onClicked: {
				        mainMenu.showCoreMenu()
				    }
				}// ImageButton
				
				// An ImageButton
				ImageButton {
				    id: headerSurfButton
				    defaultImageSource: "asset:///images/header/surfSection.png"
				    pressedImageSource: "asset:///images/header/surfSection.png"
				    disabledImageSource: "asset:///images/header/surfSection.png"
				    enabled: true
				    verticalAlignment: VerticalAlignment.Center
			        horizontalAlignment: HorizontalAlignment.Center
				    
				    onClicked: {
				        mainMenu.showSurfMenu()
				    }
			    }// ImageButton
			    
			    scaleX: 1
			    preferredHeight: 350.0
			    minHeight: 300.0
			    maxHeight: 500.0
			}
			
			Container {
			    MainMenu {
                    id: mainMenu
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
			}
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