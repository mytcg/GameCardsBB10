// Navigation pane project template
#ifndef Login_HPP_
#define Login_HPP_

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
class Login : public QObject
{
    Q_OBJECT
public:
    Login(AbstractPane *root);
    virtual ~Login() {}

    Q_INVOKABLE void attemptLogin(QString username, QString password);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mLoggedIn;
};

#endif /* Login_HPP_ */
