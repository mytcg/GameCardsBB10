// Navigation pane project template
#ifndef HeatScores_HPP_
#define HeatScores_HPP_

#include "../customcomponents/ScoreItemFactory.h"

#include <QObject>
#include <QTimer>

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
class HeatScores : public QObject
{
    Q_OBJECT
public:
    HeatScores(AbstractPane *root);
    virtual ~HeatScores() {}

    Q_INVOKABLE void getHeatScores(QString id, bool current);

    Q_INVOKABLE void stopRefresh();

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

	/*!
	 * Handles the timer.
	 */
	void refreshScores();

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;

    ScoreItemFactory *mScoreFactory;

    QTimer *mTimer;
    bool mLoading;
    QString mHeatId;
};

#endif /* HeatScores_HPP_ */
