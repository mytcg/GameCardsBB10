import bb.cascades 1.0

Page {
    Container {
        Label {
            text: "Go to www.mytcg.net to find out how to get more credits."
        }
        Label {
            text: "Credits"
        }
        TextField {
            id: txtCredits
        }
        Label {
            text: "Premium"
        }
        TextField {
            id: txtPremium
        }
        Label {
            text: "Last Transactions:"
        }
        ListView {
            id: lstTransactions
        }
        Button {
            text: "Buy"
        }
        Button {
            text: "Back"
        }
    }
}
