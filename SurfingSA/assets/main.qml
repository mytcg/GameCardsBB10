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
        }
        Label {
            text: "Password:"
        }
        TextField {
            id: passwordText
        }
        Button {
            id: login
            text: "Log In"
            onClicked: app.initiateRequest()
            
        }
    }
}
