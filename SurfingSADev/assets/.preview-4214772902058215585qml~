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
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            text: "Username:"
            textStyle.fontSizeValue: 0.0
        }
        TextField {
            id: usernameText
            objectName: "usernameText"
            
            text: "jamess"
        }
        Label {
            text: "Password:"
        }
        TextField {
            id: passwordText
            objectName: "passwordText"
            
            text: "aaaaaa"
        }
        
        Label {
            id: loggedLabel
            objectName: "loggedLabel"
            text: "0"
            visible: false
        }
        /*Button {
            id: login
            text: "Log In"
            //onClicked: app.initiateRequest()
        }
        Button {
            text: "Back"
        }*/
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
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
