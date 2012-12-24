import bb.cascades 1.0

Page {
    Container {
        Label {
            text: "Opening bid"
        }
        TextField {
            id: txtOpeningBid
        }
        Label {
            text: "Buy now price"
        }
        TextField {
            id: txtBuyNowPrice
        }
        Label {
            text: "Auction duration (days)"
        }
        TextField {
            id: txtDuration
        }
        Button {
            text: "Auction"
        }
        Button {
            text: "Back"
        }
    }
}
