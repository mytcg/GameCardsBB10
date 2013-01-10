// Navigation pane project template
#ifndef ImageLoader_HPP_
#define ImageLoader_HPP_

#include <QObject>

#include <bb/cascades/AbstractPane>
#include <bb/cascades/StandardListItem>
#include <bb/cascades/ImageView>
#include <bb/ImageData>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class ActivityIndicator;
		class AbstractPane;
		class StandardListItem;
		class ImageView;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ImageLoader : public QObject
{
    Q_OBJECT
public:
    ImageLoader(AbstractPane *root);
    virtual ~ImageLoader() {}

    Q_INVOKABLE void loadImage(QString imageUrl, QObject * parent);

private slots:
	/*!
	 * Handles the network reply.
	 */
	void onReplyFinished(QNetworkReply* reply);

private:
	bb::ImageData imageToData(QImage & qImage);
    QNetworkAccessManager *mNetworkAccessManager;
    AbstractPane *root;
    QString m_imageUrl;
    ImageView *mParent;
};

#endif /* ImageLoader_HPP_ */
