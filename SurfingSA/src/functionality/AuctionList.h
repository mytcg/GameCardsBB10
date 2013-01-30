// Navigation pane project template
#ifndef AuctionList_HPP_
#define AuctionList_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Label>
#include <bb/cascades/ListView>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class ActivityIndicator;
		class AbstractPane;
		class Label;
		class ListView;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class AuctionList : public QObject
{
    Q_OBJECT
public:
    AuctionList(AbstractPane *root);
    virtual ~AuctionList() {}

    Q_INVOKABLE void loadAuctionList(QString id);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    ListView *mListView;
};

#endif /* AuctionList_HPP_ */
