// Navigation pane project template
#ifndef InviteFriend_HPP_
#define InviteFriend_HPP_

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
class InviteFriend : public QObject
{
    Q_OBJECT
public:
    InviteFriend(AbstractPane *root);
    virtual ~InviteFriend() {}

    Q_INVOKABLE void inviteFriend(QString username, QString email, QString number);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mInviteFriend;
};

#endif /* InviteFriend_HPP_ */
