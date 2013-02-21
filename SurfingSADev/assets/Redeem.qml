import bb.cascades 1.0

Page {
    id: redeemPage
    
    Container {

        attachedObjects: [
	        ImagePaintDefinition {
	            id: backgroundPaint
	            imageSource: "asset:///images/backgrounds/bg.jpg"
                repeatPattern: RepeatPattern.Fill
	        }
	    ]

        background: backgroundPaint.imagePaint

        layout: DockLayout {
     
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill

            Container {
	            layout: DockLayout {
	            }
	
	            ImageView {
	                horizontalAlignment: HorizontalAlignment.Fill
	                verticalAlignment: VerticalAlignment.Fill
	                imageSource: "asset:///images/header/header.png"
	            }
	
	            Container {
	                layout: StackLayout {
	                    orientation: LayoutOrientation.LeftToRight
	                }
	                leftPadding: 20
	                topPadding: 20
	                Label {
	                    text: "REDEEM"
	                    textStyle.color: Color.LightGray
	                    verticalAlignment: VerticalAlignment.Center
	                    textStyle.fontSize: FontSize.Small
	                }
	            }
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
	                text: "Redeem Code:"
	                textStyle.color: Color.DarkGray
	            }
	            TextField {
	                id: redeemText
	                objectName: "redeemText"
	                hintText: "Enter redeem code"
	            }
	            Label {
	                id: redeemLabel
	                objectName: "redeemLabel"
	                text: "0"
	                visible: false
	            }
	        }
        }
        // The activity indicator has an object name set so that
        // we can start and stop it from C++
        ActivityIndicator {
            objectName: "redeemIndicator"
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            preferredWidth: 100
            preferredHeight: 100
            
            onStopped: {
                //cancelScreen()
            }
        }
    }
    actions: [
        ActionItem {
            title: "Redeem"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                redeemClass.redeem(redeemText.text)
            }
            imageSource: "asset:///images/actionicons/redeem.png"
        }
    ]
}
