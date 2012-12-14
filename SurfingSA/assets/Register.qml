import bb.cascades 1.0

Page {
    Container {
        Label {
            text: "Username"
        }
        TextField {
            id: txtUsername
        }
        Label {
            text: "Password"
        }
        TextField {
            id: txtPassword
        }
        Label {
            text: "Email"
        }
        TextField {
            id: txtEmail
        }
        Label {
            text: "Referrer"
        }
        TextArea {
            id: txtReferrer
        }
        Button {
            text: "Register"
        }
        Button {
            text: "Back"
        }
    }
}
