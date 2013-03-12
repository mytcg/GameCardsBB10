// Navigation pane project template
import bb.cascades 1.0

Home {
	id: home
    function checkLoggedIn() {
        var loggedIn = app.loggedIn()

        if (loggedIn == "false") {
            // show detail page when the button is clicked
            home.loggedIn = false
        } else {
            home.loggedIn = true
        }
    }

    onCreationCompleted: {
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.DisplayPortrait;
        checkLoggedIn()
        app.registerApplication()
    }
}
