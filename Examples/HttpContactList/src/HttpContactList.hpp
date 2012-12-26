#ifndef HttpContactList_HPP_
#define HttpContactList_HPP_

#include <QObject>
#include <QFile>

#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/ListView>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class Application;
		class ActivityIndicator;
		class ListView;
		class AbstractPane;
	}
}

/*!
 * @brief Application pane object
 *
 * Use this object to create and init app UI, to create context objects,
 * to register the new meta types etc.
 */
class HttpContactList : public QObject
{
    Q_OBJECT
public:
    /*!
     * Constructor.
     */
    HttpContactList(bb::cascades::Application *app);
    /*!
     * Initiates the network request.
     */
    Q_INVOKABLE void initiateRequest();

private slots:
    /*!
     * Handles the network reply.
     */
    void requestFinished(QNetworkReply* reply);

private:
    ActivityIndicator *mActivityIndicator;
    ListView *mListView;
    QNetworkAccessManager *mNetworkAccessManager;
    QFile *mFile;
    AbstractPane *root;
};


#endif /* HttpContactList_HPP_ */
