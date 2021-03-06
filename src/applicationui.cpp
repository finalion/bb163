/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/Container>
#include <bb/cascades/SceneCover>
#include <iostream>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
        QObject()
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this,
            SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);

    m_pInvokeManager = new bb::system::InvokeManager(this);
    networkmgr = new QNetworkAccessManager();
    networkConfigMgr = new QNetworkConfigurationManager();
//    res = QObject::connect(networkConfigMgr, SIGNAL(onlineStateChanged(bool)),this, SLOT(onOnlineStatusChanged(bool)));
//    Q_ASSERT(res);
    res = QObject::connect(networkConfigMgr, SIGNAL(configurationChanged(const QNetworkConfiguration &)), this, SLOT(onConfigurationChanged()));
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    mNewsClassName = "头条";
    initNewsHash();

    // initial load
    onSystemLanguageChanged();
    onConfigurationChanged();
    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);
    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

//    QmlDocument *qmlCover =
//        QmlDocument::create("asset:///cover.qml").parent(this);
//
//    if (!qmlCover->hasErrors()) {
//        // Create the QML Container from using the QMLDocument
//        Container *coverContainer =
//            qmlCover->createRootObject<Container>();
//
//        // Create a SceneCover and set the app cover
//        SceneCover *sceneCover =
//            SceneCover::create().content(coverContainer);
//        Application::instance()->setCover(sceneCover);
//    }
}

void ApplicationUI::onConfigurationChanged()
{
   mNetworkTypeName = networkmgr->activeConfiguration().bearerTypeName();
}

void ApplicationUI::initNewsHash()
{
//    newsHash.insert("T1348647909107", "头条");
//    newsHash.insert("T1467284926140", "精选");
//    newsHash.insert("T1348648517839", "娱乐");
//    newsHash.insert("T1348649079062", "体育");
//    newsHash.insert("T1348648756099", "财经");
//    newsHash.insert("T1348649580692", "科技");
//    newsHash.insert("T1348650593803", "时尚");
//    newsHash.insert("T1350383429665", "轻松一刻");
//    newsHash.insert("T1348648141035", "军事");
//    newsHash.insert("T1368497029546", "历史");
//    newsHash.insert("T1348654105308", "家居");
//    newsHash.insert("T1370583240249", "独家");
//    newsHash.insert("T1348654151579", "游戏");
//    newsHash.insert("T1414389941036", "健康");
//    newsHash.insert("T1414142214384", "政务");
//    newsHash.insert("T1444289532601", "哒哒趣闻");
//    newsHash.insert("T1348648037603", "社会");
//    newsHash.insert("T1347415223240", "安卓头条");
//    newsHash.insert("T1453259252417", "汽车");
//    newsHash.insert("T1453259517430", "房产");
//    newsHash.insert("T1453259717295", "原创");
//    newsHash.insert("T1453260808770", "本地");
//    newsHash.insert("T1453260901051", "图片");
//    newsHash.insert("T1453270030687", "影视");
//    newsHash.insert("T1453270107128", "手机");
//    newsHash.insert("T1453270159608", "数码");
//    newsHash.insert("T1453270478489", "亲子");
//    newsHash.insert("T1348654225495", "教育");
    newsHash.insert("头条", "T1348647909107");
    newsHash.insert("精选", "T1467284926140");
    newsHash.insert("娱乐", "T1348648517839");
    newsHash.insert("体育", "T1348649079062");
    newsHash.insert("财经", "T1348648756099");
    newsHash.insert("科技", "T1348649580692");
    newsHash.insert("时尚", "T1348650593803");
    newsHash.insert("轻松一刻", "T1350383429665");
    newsHash.insert("军事", "T1348648141035");
    newsHash.insert("历史", "T1368497029546");
    newsHash.insert("家居", "T1348654105308");
    newsHash.insert("独家", "T1370583240249");
    newsHash.insert("游戏", "T1348654151579");
    newsHash.insert("健康", "T1414389941036");
    newsHash.insert("政务", "T1414142214384");
    newsHash.insert("哒哒趣闻", "T1444289532601");
    newsHash.insert("社会", "T1348648037603");
    newsHash.insert("安卓头条", "T1347415223240");
    newsHash.insert("汽车", "T1453259252417");
    newsHash.insert("房产", "T1453259517430");
    newsHash.insert("原创", "T1453259717295");
    newsHash.insert("本地", "T1453260808770");
    newsHash.insert("图片", "T1453260901051");
    newsHash.insert("影视", "T1453270030687");
    newsHash.insert("手机", "T1453270107128");
    newsHash.insert("数码", "T1453270159608");
    newsHash.insert("亲子", "T1453270478489");
    newsHash.insert("教育", "T1348654225495");
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("TestCascadesProject_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::get(const QString endpoint)
{
    QUrl edp(endpoint);
    QNetworkRequest req(edp);
    req.setRawHeader(QString("User-Agent").toLatin1(),
            QString(
                    "Mozilla/5.0 (Linux; Android 6.0.1; XT1570 Build/MOB30R; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/51.0.2704.106 Mobile Safari/537.36").toLatin1());
    req.setRawHeader(QString("Referer").toLatin1(), QString("http://c.3g.163.com").toLatin1());
    req.setRawHeader(QString("Accept-Language").toLatin1(),
            QString("en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4").toLatin1());
    req.setRawHeader(QString("Accept-Encoding").toLatin1(), QString("deflate").toLatin1());
    req.setRawHeader(QString("Accept").toLatin1(),
            QString("text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8").toLatin1());
    req.setRawHeader(QString("Upgrade-Insecure-Requests").toLatin1(), QString("1").toLatin1());
    req.setRawHeader(QString("Host").toLatin1(), QString("c.3g.163.com").toLatin1());
    req.setRawHeader(QString("Content-Type").toLatin1(),
            QString("application/x-www-form-urlencoded").toLatin1());
//    QHttpMultiPart *multipart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
//    QHttpPart contentPart;
//    contentPart.setHeader(QNetworkRequest::ContentDispositionHeader,
//            QVariant("form-data; name=json"));
//    contentPart.setHeader(QNetworkRequest::ContentTypeHeader,
//            QVariant("text/plain; charset=unicode"));
//    contentPart.setBody(content.toUtf8());
//    multipart->append(contentPart);

    reply = networkmgr->get(req);
//    multipart->setParent(reply);

    connect(reply, SIGNAL(finished()), this, SLOT(onArticleCreated()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this,
            SLOT(onErrorOcurred(QNetworkReply::NetworkError)));
}

void ApplicationUI::onArticleCreated()
{
    QString data = (QString) (reply->readAll());
    qDebug() << data;
    if ((data.indexOf("postid") > 0)) {
        emit returned(true, data);
    } else {
        emit returned(false, data);
    }
    disconnect(reply);
    reply->deleteLater();
}
void ApplicationUI::onErrorOcurred(QNetworkReply::NetworkError error)
{
    qDebug() << error;
    emit returned(false, QString(error));
}

QString ApplicationUI::getv(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }
    qDebug() << "[SETTINGS]" << objectName << " is " << settings.value(objectName).toString();
    return settings.value(objectName).toString();
}

void ApplicationUI::setv(const QString &objectName, const QString &inputValue)
{
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
    qDebug() << "[SETTINGS]" << objectName << " set to " << inputValue;
}

void ApplicationUI::viewimage(QString path)
{
    // invoke the system image viewer
    bb::system::InvokeRequest request;
    // Set the URI
    request.setUri(path);
    request.setTarget("sys.pictures.card.previewer");
    request.setAction("bb.action.VIEW");
    // Send the invocation request
    bb::system::InvokeTargetReply *cardreply = m_pInvokeManager->invoke(request);
    Q_UNUSED(cardreply);
}

QString ApplicationUI::getNewsClassId()
{
    QHash<QString, QString>::const_iterator iter;
    iter = newsHash.find(mNewsClassName);
    if (iter != newsHash.end()) {
    qDebug() << "mapped:" <<iter.value();
        return iter.value();
    }
    return "";
}

void ApplicationUI::setNewsClassId(QString newsClassId)
{
    mNewsClassId = newsClassId;
    emit newsTypeChanged(mNewsClassId);
}

QString ApplicationUI::getNewsClassName()
{
    return mNewsClassName;
}

void ApplicationUI::setNewsClassName(QString newsClassName)
{
    mNewsClassName = newsClassName;
}

QString ApplicationUI::getNetworkType()
{
    return mNetworkTypeName;
}

float ApplicationUI::getDisplayPixelsWidth(){
    return dspInfo.pixelSize().width();
}
