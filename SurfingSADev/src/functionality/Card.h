// Navigation pane project template
#ifndef Card_HPP_
#define Card_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Label>
#include <bb/cascades/ImageView>

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
class Card : public QObject
{
    Q_OBJECT
public:
    Card(AbstractPane *root);
    virtual ~Card() {}

    Q_INVOKABLE void save(QString cardId);
    Q_INVOKABLE void reject(QString cardId);
    Q_INVOKABLE void loadImage(QString image);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void requestFinished(QNetworkReply* reply);

private:
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    ActivityIndicator *mActivityIndicator;
    Label *mCard;
    ImageView * mCardView;
};

#endif /* Card_HPP_ */
