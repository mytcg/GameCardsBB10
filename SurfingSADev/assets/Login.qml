// Default empty project template
import bb.cascades 1.0

// creates one page with a label
Page {
    id: loginQml
    
    signal cancel ()
    
    function cancelScreen() {
        if (loggedLabel.text == "1") {
            loginQml.cancel()
        }
        else {
        }
    }
    
    titleBar: TitleBar {
        id: addBar
        title: "Your Details"
        visibility: ChromeVisibility.Visible
        
        acceptAction: ActionItem {
            title: "Log In"
            onTriggered: {
                // Emit save signal with the new imageSource and greetings text as parameters.
                //sheetModify.save(fruitImage.imageSource, editBasketText.text);
                loginClass.attemptLogin(usernameText.text, passwordText.text);
                //loginQml.cancel();
            }
        }
    }
    
    Container {
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
            
            Label {
                id: loggedLabel
                objectName: "loggedLabel"
                text: "0"
                visible: false
            }
        }
        
        ActivityIndicator {
            objectName: "loginIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 200
            preferredHeight: 200
            
            onStopped: {
                cancelScreen()
            }
        }
    }
}
