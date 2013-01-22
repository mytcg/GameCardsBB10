// Navigation pane project template
#ifndef Registration_HPP_
#define Registration_HPP_

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
class Registration : public QObject
{
    Q_OBJECT
public:
    Registration(AbstractPane *root);
    virtual ~Registration() {}

    Q_INVOKABLE void attemptRegistration(QString username, QString password, QString email, QString referrer);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mRegistered, *mResponse;

    QString encrypt;
};

#endif /* Registration_HPP_ */
