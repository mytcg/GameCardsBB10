import bb.cascades 1.0

Page {
    Container {
        Label {
            text: "Earn credits by filling in profile details."
        }
        Label {
            text: "Profile"
        }
        ListView {
            id: lstProfile
        }
        Button {
            text: "Save"
        }
        Button {
            text: "Back"
        }
    }
}
