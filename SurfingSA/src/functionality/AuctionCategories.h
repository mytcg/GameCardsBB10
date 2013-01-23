// Navigation pane project template
#ifndef AuctionCategories_HPP_
#define AuctionCategories_HPP_

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
class AuctionCategories : public QObject
{
    Q_OBJECT
public:
    AuctionCategories(AbstractPane *root);
    virtual ~AuctionCategories() {}

    Q_INVOKABLE void loadAuctionCategories(QString id);

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

#endif /* AuctionCategories_HPP_ */
