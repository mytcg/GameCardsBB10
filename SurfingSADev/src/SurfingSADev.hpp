// Navigation pane project template
#ifndef SurfingSADev_HPP_
#define SurfingSADev_HPP_

#include "functionality/Login.h"

#include <QObject>

namespace bb {
	namespace cascades {
		class Application;
	}
}



/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class SurfingSADev : public QObject
{
    Q_OBJECT
public:
    SurfingSADev(bb::cascades::Application *app);
    virtual ~SurfingSADev() {}

    Q_INVOKABLE QString loggedIn();

    //functionality classes
    Login *mLogin;
};

#endif /* SurfingSADev_HPP_ */
