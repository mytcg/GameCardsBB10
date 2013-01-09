/****************************************************************************
** Meta object code from reading C++ file 'Credits.h'
**
** Created: Wed 9. Jan 14:16:49 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/functionality/Credits.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Credits.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Credits[] = {

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
      15,    9,    8,    8, 0x08,

 // methods: signature, parameters, type, tag, flags
      47,    8,    8,    8, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_Credits[] = {
    "Credits\0\0reply\0requestFinished(QNetworkReply*)\0"
    "loadCredits()\0"
};

void Credits::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Credits *_t = static_cast<Credits *>(_o);
        switch (_id) {
        case 0: _t->requestFinished((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 1: _t->loadCredits(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Credits::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Credits::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Credits,
      qt_meta_data_Credits, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Credits::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Credits::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Credits::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Credits))
        return static_cast<void*>(const_cast< Credits*>(this));
    return QObject::qt_metacast(_clname);
}

int Credits::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
