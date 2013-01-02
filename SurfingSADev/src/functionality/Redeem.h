// Navigation pane project template
#ifndef Redeem_HPP_
#define Redeem_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/QmlDocument>
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
class Redeem : public QObject
{
    Q_OBJECT
public:
    Redeem(AbstractPane *root);
    virtual ~Redeem() {}

    Q_INVOKABLE void redeem(QString redeemCode);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mRedeem;
};

#endif /* Redeem_HPP_ */
