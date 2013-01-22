// Navigation pane project template
#ifndef AuctionCreate_HPP_
#define AuctionCreate_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/Label>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class ActivityIndicator;
		class AbstractPane;
		class QmlDocument;
		class Label;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class AuctionCreate : public QObject
{
    Q_OBJECT
public:
    AuctionCreate(AbstractPane *root);
    virtual ~AuctionCreate() {}

    Q_INVOKABLE void createAuction(QString cardId, QString bid, QString buynow, QString duration);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mAuctionCreate;
};

#endif /* AuctionCreate_HPP_ */
