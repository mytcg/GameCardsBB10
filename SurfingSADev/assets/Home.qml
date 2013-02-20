import bb.cascades 1.0

Page {
    id: homePage
    property bool loggedIn: false
    
    function openMenu(index) {
        mainMenu.showLoggin = !loggedIn;
        mainMenu.selectTab(index);
        mainMenuSheet.open();
    }
    
    Container {
        layout: DockLayout {
        }

        //background: Color.create("#ededed");
        ImageView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            imageSource: "asset:///images/backgrounds/home_bg.jpg"
        }

        Container {
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Top

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
                ImageView {
                    imageSource: "asset:///images/header/surfing_sa_logo.png"
                    verticalAlignment: VerticalAlignment.Center
                }
            }
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            
            preferredHeight: 984

            topPadding: 80
            bottomPadding: 80
            leftPadding: 30
            rightPadding: 30

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 2
                }
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill

                ImageButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

                    defaultImageSource: "asset:///images/customcomponents/home_label.png"
                    pressedImageSource: "asset:///images/customcomponents/home_label_selected.png"
                    
                    onClicked: {
                        openMenu(0);
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill

                    touchPropagationMode: TouchPropagationMode.None
                    ImageView {
                        imageSource: "asset:///images/customcomponents/surfing_cards_icon_home.png"
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 80
                        minWidth: 80
                    }

                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        topPadding: 15
                        leftPadding: 20
                        Label {
                        	text: "SURFING COLLECTABLE CARDS"
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.Small
                        }
                        Label {
                            text: "Collect your favourite South African Surfers. View their details, auction cards, share with friends!"
                            multiline: true
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.XXSmall
                        }
                    }
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 2
                }
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill

                ImageButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

                    defaultImageSource: "asset:///images/customcomponents/home_label.png"
                    pressedImageSource: "asset:///images/customcomponents/home_label_selected.png"

                    onClicked: {
                        openMenu(1);
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill

                    touchPropagationMode: TouchPropagationMode.None
                    ImageView {
                        imageSource: "asset:///images/customcomponents/weather_icon_home.png"
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 80
                        minWidth: 80
                    }

                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        topPadding: 15
                        leftPadding: 20
                        Label {
                            text: "WEATHER REPORT"
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.Small
                        }
                        Label {
                            text: "Check out the weather at your local surf spot! View temperature, wind direction, swell height & more!"
                            multiline: true
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.XXSmall
                        }
                    }
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 2
                }
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill

                ImageButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

                    defaultImageSource: "asset:///images/customcomponents/home_label.png"
                    pressedImageSource: "asset:///images/customcomponents/home_label_selected.png"

                    onClicked: {
                        openMenu(2);
                    }
                }

                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill

                    touchPropagationMode: TouchPropagationMode.None
                    ImageView {
                        imageSource: "asset:///images/customcomponents/news_icon_home.png"
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 80
                        minWidth: 80
                    }

                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        topPadding: 15
                        leftPadding: 20
                        Label {
                            text: "SURFING NEWS"
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.Small
                        }
                        Label {
                            text: "Get up to date with the latest news from the surfing front!"
                            multiline: true
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.XXSmall
                        }
                    }
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 2
                }
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                //overlapTouchPolicy: OverlapTouchPolicy.Allow
                touchPropagationMode: TouchPropagationMode.Full
                ImageButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill

                    defaultImageSource: "asset:///images/customcomponents/home_label.png"
                    pressedImageSource: "asset:///images/customcomponents/home_label_selected.png"

                    onClicked: {
                        openMenu(3);
                    }
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    leftPadding: 20
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill

                    touchPropagationMode: TouchPropagationMode.None
                    ImageView {
                        imageSource: "asset:///images/customcomponents/scoring_icon_home.png"
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 80
                        minWidth: 80
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        topPadding: 15
                        leftPadding: 20

                        Label {
                            text: "COMPETITION SCORING"
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.Small
                        }
                        Label {
                            text: "View live scoring, see competition results. Compare surfer's scores, check out previous competitions!"
                            multiline: true
                            textStyle.color: Color.create("#ffe6e6e6")
                            textStyle.fontSize: FontSize.XXSmall
                        }
                    }
                }
            }
        }

        ImageView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Bottom
            imageSource: "asset:///images/header/footer.png"
        }
    }
    
    attachedObjects: [
        Sheet {
            peekEnabled: false
            id: mainMenuSheet
            MainMenu {
                id: mainMenu
            }
        }
    ]
}