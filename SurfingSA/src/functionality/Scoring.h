// Navigation pane project template
#ifndef Scoring_HPP_
#define Scoring_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class ActivityIndicator;
		class AbstractPane;
		class QmlDocument;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class Scoring : public QObject
{
    Q_OBJECT
public:
    Scoring(AbstractPane *root);
    virtual ~Scoring() {}

    Q_INVOKABLE void getCurrentEvents();

    Q_INVOKABLE void getArchiveEvents();

    Q_INVOKABLE void getCategories(QString id);

    Q_INVOKABLE void getHeats(QString id);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;

    QString idString, nameString, dropDownString, mapString;
};

#endif /* Scoring_HPP_ */
