import bb.cascades 1.0
import bb.data 1.0

Container {
    layout: DockLayout {
    }

    property NavigationPane newsPane: null

    ListView {
        id: myListView
        dataModel: dataModel
        listItemComponents: [
            ListItemComponent {
                type: "item"

                // Use a standard list item to display the data in the data
                // model
                StandardListItem {

                    title: ListItemData.title
                    description: ListItemData.description

                }

            }
        ]
        onTriggered: {
            var feedItem = dataModel.data(indexPath);

            var page = detailsPage.createObject();
            page.htmlContent = feedItem.link;
            newsPane.push(page);
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: dataModel

            // Sort the data in the data model by the "pubDate" field, in
            // descending order, without any automatic grouping
            sortingKeys: [ "pubDate"
            ]
            sortedAscending: false
            grouping: ItemGrouping.ByFullValue
        },
        DataSource {
            id: dataSource

            // Load the XML data from a remote data source, specifying that the
            // "item" data items should be loaded
            source: "http://feeds.feedburner.com/blackberry/CAxx/"
            query: "/rss/channel/item"
            type: DataSourceType.Xml

            onDataLoaded: {
                // After the data is loaded, clear any existing items in the data
                // model and populate it with the new data
                dataModel.clear();
                dataModel.insertList(data)
            }
        },
        ComponentDefinition {
            id: detailsPage
            source: "NewsDetails.qml"
        }
    ]
    onCreationCompleted: {
        // When the top-level Page is created, direct the data source to start
        // loading data
        dataSource.load();
    }
}