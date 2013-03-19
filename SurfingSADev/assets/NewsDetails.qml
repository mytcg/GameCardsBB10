import bb.cascades 1.0

Page {
    property alias htmlContent: detailsView.url

    Container {
        layout: DockLayout {
        }

        ScrollView {

            scrollViewProperties.scrollMode: ScrollMode.Vertical
            scrollViewProperties {

            }

            WebView {
                id: detailsView
                settings.zoomToFitEnabled: true
                settings.activeTextEnabled: true
                settings.userAgent: "Mozilla/5.0 (BlackBerry; U; BlackBerry 9850; en-US) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.0.0.115 Mobile Safari/534.11+"

                onLoadProgressChanged: {
                    // Update the ProgressBar while loading.
                    progressIndicator.value = loadProgress / 100.0
                }
                onLoadingChanged: {
                    if (loadRequest.status == WebLoadStatus.Started) {
                        // Show the ProgressBar when loading started.
                        progressIndicator.opacity = 1.0
                    } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                        // Hide the ProgressBar when loading is complete.
                        progressIndicator.opacity = 0.0
                    } else if (loadRequest.status == WebLoadStatus.Failed) {
                        // If loading failed, fallback to inline HTML, by setting the HTML property directly.
                        html = "<html><head><title>Load Fail</title><style>* { margin: 0px; padding 0px; }body { font-size: 48px; font-family: monospace; border: 1px solid #444; padding: 4px; }</style> </head> <body>Loading failed! Please check your internet connection.</body></html>"
                        progressIndicator.opacity = 0.0
                    }
                }
            }

        }
        Container {
            bottomPadding: 25
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom

            ProgressIndicator {
                id: progressIndicator
                opacity: 0
            }
        }
    }
}