// Navigation pane project template
#ifndef Shop_HPP_
#define Shop_HPP_

#include "ImageLoader.h"

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
class Shop : public QObject
{
    Q_OBJECT
public:
    Shop(AbstractPane *root, ImageLoader *loader);
    virtual ~Shop() {}

    Q_INVOKABLE void loadProducts();

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
    Label *mShop;

    ImageLoader *imageLoader;
};

#endif /* Shop_HPP_ */
