/****************************************************************************
** Meta object code from reading C++ file 'Employee.h'
**
** Created: Mon 24. Dec 16:33:12 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/objects/Employee.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Employee.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Employee[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       3,   29, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      18,   10,    9,    9, 0x0a,
      40,   10,    9,    9, 0x0a,
      71,   61,    9,    9, 0x0a,

 // properties: name, type, flags
     102,   94, 0x0a095903,
     112,   94, 0x0a095903,
     125,  121, 0x02095903,

       0        // eod
};

static const char qt_meta_stringdata_Employee[] = {
    "Employee\0\0newName\0setFirstName(QString)\0"
    "setLastName(QString)\0newNumber\0"
    "setEmployeeNumber(int)\0QString\0firstName\0"
    "lastName\0int\0employeeNumber\0"
};

void Employee::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Employee *_t = static_cast<Employee *>(_o);
        switch (_id) {
        case 0: _t->setFirstName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->setLastName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->setEmployeeNumber((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Employee::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Employee::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Employee,
      qt_meta_data_Employee, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Employee::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Employee::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Employee::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Employee))
        return static_cast<void*>(const_cast< Employee*>(this));
    return QObject::qt_metacast(_clname);
}

int Employee::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = firstName(); break;
        case 1: *reinterpret_cast< QString*>(_v) = lastName(); break;
        case 2: *reinterpret_cast< int*>(_v) = employeeNumber(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setFirstName(*reinterpret_cast< QString*>(_v)); break;
        case 1: setLastName(*reinterpret_cast< QString*>(_v)); break;
        case 2: setEmployeeNumber(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
