/****************************************************************************
** Meta object code from reading C++ file 'Notifications.h'
**
** Created: Mon 14. Jan 17:04:41 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/functionality/Notifications.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Notifications.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Notifications[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      21,   15,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
      53,   14,   14,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_Notifications[] = {
    "Notifications\0\0reply\0"
    "requestFinished(QNetworkReply*)\0"
    "loadNotifications()\0"
};

void Notifications::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Notifications *_t = static_cast<Notifications *>(_o);
        switch (_id) {
        case 0: _t->requestFinished((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 1: _t->loadNotifications(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Notifications::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Notifications::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Notifications,
      qt_meta_data_Notifications, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Notifications::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Notifications::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Notifications::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Notifications))
        return static_cast<void*>(const_cast< Notifications*>(this));
    return QObject::qt_metacast(_clname);
}

int Notifications::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
