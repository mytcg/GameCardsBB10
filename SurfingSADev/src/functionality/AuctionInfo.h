// Navigation pane project template
#ifndef AuctionInfo_HPP_
#define AuctionInfo_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/Label>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class ActivityIndicator;
		class AbstractPane;
		class Label;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class AuctionInfo : public QObject
{
    Q_OBJECT
public:
    AuctionInfo(AbstractPane *root);
    virtual ~AuctionInfo() {}

    Q_INVOKABLE void placeBid(QString auctionId, QString username, QString bid);
    Q_INVOKABLE void buyNow(QString auctionId, QString username, QString buynowprice, QString usercardId);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mAuctionInfo;
};

#endif /* AuctionInfo_HPP_ */
