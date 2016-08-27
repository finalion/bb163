/****************************************************************************
** Meta object code from reading C++ file 'applicationui.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/applicationui.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationui.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       4,   64, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      28,   15,   14,   14, 0x06,
      63,   51,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      88,   14,   14,   14, 0x08,
     114,   14,   14,   14, 0x08,
     139,  133,   14,   14, 0x08,
     183,   14,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
     217,  208,   14,   14, 0x02,
     252,  230,   14,   14, 0x02,
     306,  282,  274,   14, 0x02,
     333,  328,   14,   14, 0x02,

 // properties: name, type, flags
      51,  274, 0x0a495903,
     352,  274, 0x0a095903,
     366,  274, 0x0a095401,
     388,  382, 0x87095401,

 // properties: notify_signal_id
       1,
       0,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0success,resp\0"
    "returned(bool,QString)\0newsClassId\0"
    "newsTypeChanged(QString)\0"
    "onSystemLanguageChanged()\0onArticleCreated()\0"
    "error\0onErrorOcurred(QNetworkReply::NetworkError)\0"
    "onConfigurationChanged()\0endpoint\0"
    "get(QString)\0objectName,inputValue\0"
    "setv(QString,QString)\0QString\0"
    "objectName,defaultValue\0getv(QString,QString)\0"
    "path\0viewimage(QString)\0newsClassName\0"
    "networkTypeName\0float\0displayWidth\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->returned((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: _t->newsTypeChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->onSystemLanguageChanged(); break;
        case 3: _t->onArticleCreated(); break;
        case 4: _t->onErrorOcurred((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        case 5: _t->onConfigurationChanged(); break;
        case 6: _t->get((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 7: _t->setv((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 8: { QString _r = _t->getv((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 9: _t->viewimage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getNewsClassId(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getNewsClassName(); break;
        case 2: *reinterpret_cast< QString*>(_v) = getNetworkType(); break;
        case 3: *reinterpret_cast< float*>(_v) = getDisplayPixelsWidth(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setNewsClassId(*reinterpret_cast< QString*>(_v)); break;
        case 1: setNewsClassName(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ApplicationUI::returned(bool _t1, QString _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ApplicationUI::newsTypeChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
