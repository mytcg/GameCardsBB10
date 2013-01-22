// Navigation pane project template
#ifndef Booster_HPP_
#define Booster_HPP_

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
class Booster : public QObject
{
    Q_OBJECT
public:
    Booster(AbstractPane *root);
    virtual ~Booster() {}

    Q_INVOKABLE void booster(QString id);

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

#endif /* Booster_HPP_ */
