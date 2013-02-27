// Default empty project template
import bb.cascades 1.0
import bb.system 1.0

// creates one page with a label
Container {
    id: mainContainer
    topPadding: 20
    leftPadding: 20
    rightPadding: 20

    function cancelLoginScreen() {
        if (loggedLabel.text == "1") {
            mainContainer.visible = false 
        }
        else if (loggedLabel.text == "2") {
            dialogLabel.text = loggedResponseLabel.text
            errorPopup.open()
        }
    }
    
    function cancelRegScreen() {
        if (registeredLabel.text == "1") {
            mainContainer.visible = false
        }
        else if (registeredLabel.text == "2") {
            dialogLabel.text = registeredResponseLabel.text
            errorPopup.open()
        }
    }
    
    function showLogin() {
        loginContainer.visible = true
        registerContainer.visible = false
    }
    
    function showRegister() {
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
    ScrollView {

        // Scrolling is restricted to vertical direction only, in this particular case.
        scrollViewProperties {
            scrollMode: ScrollMode.Vertical
        }
        Container {
        leftPadding: 20
        rightPadding: 20
        topPadding: 10
        bottomPadding: 20
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        attachedObjects: [
            ImagePaintDefinition {
                id: radioBack
                imageSource: "asset:///images/backgrounds/big_label.png"
                repeatPattern: RepeatPattern.XY
            }
        ]
        background: radioBack.imagePaint
        //background: Color.create("#ededed");
        RadioGroup {
            id: loginRadioGroup

            Option {
                text: "Login"
                selected: true
            }

            Option {
                text: "Register"
            }

            onSelectedIndexChanged: {
                if (loginRadioGroup.selectedIndex == 0) {
                    showLogin()
                }
                else if (loginRadioGroup.selectedIndex ==  1) {
                    showRegister()
                }
            }
        }
            
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
                
                Label {
                    text: "Username:"
                    textStyle.fontSizeValue: 0.0
                }
                TextField {
                    id: usernameText
                    objectName: "usernameText"

                    hintText: "Enter username"
                    inputMode: TextFieldInputMode.Text

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

                Button {
                	horizontalAlignment: HorizontalAlignment.Right
                    text: "Log In"

                    onClicked: {
                        loginClass.attemptLogin(usernameText.text, passwordText.text);
                    }
                }
            }

            ActivityIndicator {
                objectName: "loginIndicator"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 100
                preferredHeight: 100

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

            ScrollView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                // Scrolling is restricted to vertical direction only, in this particular case.
                scrollViewProperties {
                    scrollMode: ScrollMode.Vertical
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }

                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

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

                    Button {
                        horizontalAlignment: HorizontalAlignment.Right
                        text: "Register"

                        onClicked: {
                            registerClass.attemptRegistration(regUsernameText.text, regPasswordText.text, emailText.text, referrerText.text);
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
            }

            ActivityIndicator {
                objectName: "registerIndicator"
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 100
                preferredHeight: 100
                
                onStopped: {
                    cancelRegScreen()
                }
            }
        }
    }
}
}
