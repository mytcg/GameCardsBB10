// Default empty project template
import bb.cascades 1.0

// creates one page with a label
Page {
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
            objectName: "usernameText";
        }
        Label {
            text: "Password:"
        }
        TextField {
            id: passwordText
            objectName: "passwordText";
        }
        Button {
            id: login
            text: "Log In"
            onClicked: app.initiateRequest()
            
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
