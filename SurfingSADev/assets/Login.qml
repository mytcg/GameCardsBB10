// Default empty project template
import bb.cascades 1.0
import bb.system 1.0

// creates one page with a label
Page {
    id: loginQml
    
    signal cancel ()
    
    property string state: "login"
    
    function cancelLoginScreen() {
        if (loggedLabel.text == "1") {
            loginQml.cancel()
        }
        else if (loggedLabel.text == "2") {
            dialogLabel.text = loggedResponseLabel.text
            errorPopup.open()
        }
    }
    
    function cancelRegScreen() {
        if (registeredLabel.text == "1") {
            loginQml.cancel()
        }
        else if (registeredLabel.text == "2") {
            dialogLabel.text = registeredResponseLabel.text
            errorPopup.open()
        }
    }
    
    function showLogin() {
        addBar.title = "Login Details"
        actionItem.title = "Log In"
        state = "login"
        loginContainer.visible = true
        registerContainer.visible = false
    }
    
    function showRegister() {
        addBar.title = "Registration"
        actionItem.title = "Register"
        state = "register"
        loginContainer.visible = false
        registerContainer.visible = true
    }
    
    attachedObjects: [
        ImagePaintDefinition {
            id: backgroundPaint
            imageSource: "asset:///images/customcomponents/popup.png"
            repeatPattern: RepeatPattern.XY
        },
        
        Dialog {
           id: errorPopup
 
           Container {
               layout: DockLayout {
                   
               }
               horizontalAlignment: HorizontalAlignment.Fill
               verticalAlignment: VerticalAlignment.Fill
               
               Container {
                   topPadding: 15
                   rightPadding: 15
                   bottomPadding: 15
                   leftPadding: 15
                   background: backgroundPaint.imagePaint
                   layout: StackLayout {
                       orientation: LayoutOrientation.TopToBottom
                   }
                   horizontalAlignment: HorizontalAlignment.Center
                   verticalAlignment: VerticalAlignment.Center
                   
                   Label {
                       id: dialogLabel
                       horizontalAlignment: HorizontalAlignment.Center
                       text: ""
                       multiline: true
   	               }
   	                  
   	               Button {
   	                   horizontalAlignment: HorizontalAlignment.Center
   	                   text: "ok"
   	                   onClicked: errorPopup.close()
   	               }
               }
           }
       }
   ]
    
    titleBar: TitleBar {
        id: addBar
        title: "Login Details"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            id: actionItem
            title: "Log In"
            onTriggered: {
                if (state == "login") {
                    loginClass.attemptLogin(usernameText.text, passwordText.text);
                }
                else if (state == "register") {
                    registerClass.attemptRegistration(regUsernameText.text, regPasswordText.text, emailText.text, referrerText.text);
                }
            }
        }
    }
    
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        background: Color.create("#ededed");
        
        Container {
            id: loginContainer
            
            layout: DockLayout {
                
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                leftPadding: 20
                rightPadding: 20
                topPadding: 10
                
                Label {
                    text: "Username:"
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: usernameText
                    objectName: "usernameText"
                    
                    hintText: "Enter username"
                }
                Label {
                    text: "Password:"
                }
                TextField {
                    id: passwordText
                    objectName: "passwordText"
                    
                    hintText: "Enter password"
                    inputMode: TextFieldInputMode.Password
                }
                
                //0 for nothing, 1 for success, 2 for error
                Label {
                    id: loggedLabel
                    objectName: "loggedLabel"
                    text: "0"
                    visible: false
                }
                Label {
                    id: loggedResponseLabel
                    objectName: "loggedResponseLabel"
                    text: ""
                    visible: false
                }
                
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    topPadding: 20
                    
                    Label {
                        text: "Not a member?"
                        verticalAlignment: VerticalAlignment.Center
                    }
                    
                    Button {
                        text: "Register!"
                        
                        onClicked: {
                            showRegister()
                        }
                    }
                }
            }
            
            ActivityIndicator {
                objectName: "loginIndicator"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 200
                preferredHeight: 200
                
                onStopped: {
                    cancelLoginScreen()
                }
            }
        }
        
        Container {
            id: registerContainer
            visible: false
            
            layout: DockLayout {
                
            }
            
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                leftPadding: 20
                rightPadding: 20
                topPadding: 10
                
                Label {
                    text: "Username:"
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: regUsernameText
                    
                    hintText: "Enter username"
                }
                Label {
                    text: "Password:"
                }
                TextField {
                    id: regPasswordText
                    
                    hintText: "Enter password"
                    inputMode: TextFieldInputMode.Password
                }
                Label {
                    text: "Email:"
                }
                TextField {
                    id: emailText
                    
                    hintText: "Enter email"
                    inputMode: TextFieldInputMode.EmailAddress
                }
                Label {
                    text: "Referrer:"
                }
                TextField {
                    id: referrerText
                    
                    hintText: "Enter referrer (optional)"
                }
                
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    topPadding: 20
                    
                    Label {
                        text: "Already a member?"
                        verticalAlignment: VerticalAlignment.Center
                    }
                    
                    Button {
                        text: "Log in!"
                        
                        onClicked: {
                            showLogin()
                        }
                    }
                }
                
                //0 for nothing, 1 for success, 2 for error
                Label {
                    id: registeredLabel
                    objectName: "registeredLabel"
                    text: "0"
                    visible: false
                }
                Label {
                    id: registeredResponseLabel
                    objectName: "registeredResponseLabel"
                    text: ""
                    visible: false
                }
            }
            
            ActivityIndicator {
                objectName: "registerIndicator"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 200
                preferredHeight: 200
                
                onStopped: {
                    cancelRegScreen()
                }
            }
        }
    }
}
