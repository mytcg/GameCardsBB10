/****************************************************************************
** Meta object code from reading C++ file 'InviteFriend.h'
**
** Created: Wed 2. Jan 17:40:26 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/functionality/InviteFriend.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'InviteFriend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_InviteFriend[] = {

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
      20,   14,   13,   13, 0x08,

 // methods: signature, parameters, type, tag, flags
      74,   52,   13,   13, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_InviteFriend[] = {
    "InviteFriend\0\0reply\0requestFinished(QNetworkReply*)\0"
    "username,email,number\0"
    "inviteFriend(QString,QString,QString)\0"
};

void InviteFriend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        InviteFriend *_t = static_cast<InviteFriend *>(_o);
        switch (_id) {
        case 0: _t->requestFinished((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 1: _t->inviteFriend((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData InviteFriend::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject InviteFriend::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_InviteFriend,
      qt_meta_data_InviteFriend, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &InviteFriend::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *InviteFriend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *InviteFriend::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_InviteFriend))
        return static_cast<void*>(const_cast< InviteFriend*>(this));
    return QObject::qt_metacast(_clname);
}

int InviteFriend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
