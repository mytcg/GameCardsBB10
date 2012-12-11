// Default empty project template
#ifndef SurfingSA_HPP_
#define SurfingSA_HPP_

#include <QObject>

#include <bb/cascades/TextField>
#include <bb/cascades/ActivityIndicator>

using namespace bb::cascades;

namespace bb {
	namespace cascades {
		class Application;
		class TextField;
		class ActivityIndicator;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class SurfingSA : public QObject
{
    Q_OBJECT
public:
    SurfingSA(bb::cascades::Application *app);
    virtual ~SurfingSA() {}
    Q_INVOKABLE void initiateRequest();

    private slots:
        /*!
         * Handles the network reply.
         */
        void requestFinished(QNetworkReply* reply);

    private:
        QNetworkAccessManager *mNetworkAccessManager;
        TextField *mUsernameText;
        TextField *mPasswordText;
        ActivityIndicator *mActivityIndicator;
};


#endif /* SurfingSA_HPP_ */
