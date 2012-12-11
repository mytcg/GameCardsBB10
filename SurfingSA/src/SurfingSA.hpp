// Default empty project template
#ifndef SurfingSA_HPP_
#define SurfingSA_HPP_

#include <QObject>

#include <bb/cascades/TextField>
namespace bb { namespace cascades { class Application; }}

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
};


#endif /* SurfingSA_HPP_ */
