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
#include <iostream>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
        QObject()
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
//    m_pInvokeManager = new bb::system::InvokeManager(this);
    networkmgr = new QNetworkAccessManager();

    mNewsClassId = "T1295501906343";
    initNewsHash();
    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this,
            SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);
    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);
}

void ApplicationUI::initNewsHash()
{
    newsHash.insert("T1295501906343", "头条");
    newsHash.insert("T1347415223240", "安卓头条");
    newsHash.insert("T1295505301714", "社会");
    newsHash.insert("T1295505330581", "国内");
    newsHash.insert("T1295505403327", "国际");
    newsHash.insert("T1295505447897", "军事");
    newsHash.insert("T1295505484037", "深度");
    newsHash.insert("T1295505518398", "评论");
    newsHash.insert("T1295505544569", "探索");
    newsHash.insert("T1295505705196", "财经");
    newsHash.insert("T1295505762641", "产经");
    newsHash.insert("T1295505791581", "商业");
    newsHash.insert("T1295505812128", "理财");
    newsHash.insert("T1295505852042", "股票");
    newsHash.insert("T1296114379050", "创业板");
    newsHash.insert("T1296114456030", "新股");
    newsHash.insert("T1296114477031", "基金");
    newsHash.insert("T1296114887709", "港股");
    newsHash.insert("T1296114911017", "美股");
    newsHash.insert("T1296115644988", "外汇");
    newsHash.insert("T1296115663524", "期货");
    newsHash.insert("T1295505916992", "体育");
    newsHash.insert("T1295505940145", "NBA（显示）");
    newsHash.insert("T1297306446792", "火箭");
    newsHash.insert("T1297306494919", "姚明");
    newsHash.insert("T1297306587395", "奇才");
    newsHash.insert("T1297306610518", "易建联");
    newsHash.insert("T1297306626183", "热火");
    newsHash.insert("T1297306643277", "湖人");
    newsHash.insert("T1297306738973", "NBA东部");
    newsHash.insert("T1297306761721", "NBA西部");
    newsHash.insert("T1297306817918", "足球");
    newsHash.insert("T1297306854577", "英超");
    newsHash.insert("T1297306872184", "西甲");
    newsHash.insert("T1297306895740", "意甲");
    newsHash.insert("T1297306926417", "德甲");
    newsHash.insert("T1297306961414", "欧冠");
    newsHash.insert("T1297306986517", "曼联");
    newsHash.insert("T1297307403944", "CBA");
    newsHash.insert("T1297307072804", "阿森纳");
    newsHash.insert("T1297307091762", "利物浦");
    newsHash.insert("T1297307131881", "皇马");
    newsHash.insert("T1297307153125", "巴萨");
    newsHash.insert("T1297307190360", "国米");
    newsHash.insert("T1297307228896", "AC米兰");
    newsHash.insert("T1297307262664", "尤文");
    newsHash.insert("T1297307285777", "罗马");
    newsHash.insert("T1297307305260", "拜仁");
    newsHash.insert("T1297307324042", "中国足球");
    newsHash.insert("T1297307342683", "中超");
    newsHash.insert("T1297307441269", "综合体育");
    newsHash.insert("T1297307467625", "网球");
    newsHash.insert("T1297307488976", "台球");
    newsHash.insert("T1297307510449", "F1");
    newsHash.insert("T1297307529314", "排球");
    newsHash.insert("T1297307551489", "乒乓球");
    newsHash.insert("T1297307582101", "羽毛球");
    newsHash.insert("T1297307028509", "切尔西");
    newsHash.insert("T1295506658957", "娱乐");
    newsHash.insert("T1295506688215", "明星");
    newsHash.insert("T1297307629444", "内地明星");
    newsHash.insert("T1297307690498", "港台明星");
    newsHash.insert("T1297307738982", "欧美明星");
    newsHash.insert("T1297307759820", "日韩明星");
    newsHash.insert("T1297307805142", "娱乐酷评");
    newsHash.insert("T1297307826360", "狗仔直击");
    newsHash.insert("T1297307872142", "电影");
    newsHash.insert("T1297307917589", "电视");
    newsHash.insert("T1297307966539", "音乐");
    newsHash.insert("T1295506798584", "女人");
    newsHash.insert("T1295506885366", "情感");
    newsHash.insert("T1297308027338", "星座");
    newsHash.insert("T1316405154348", "时尚");
    newsHash.insert("T1316411034878", "美容");
    newsHash.insert("T1337243860949", "情感（测试）");
    newsHash.insert("T1295507084100", "科技");
    newsHash.insert("T1295507110031", "新视野");
    newsHash.insert("T1297308061486", "互联网");
    newsHash.insert("T1297308083510", "通信");
    newsHash.insert("T1297308102740", "IT业界");
    newsHash.insert("T1297308162866", "科技深度");
    newsHash.insert("T1297308197260", "每日一站");
    newsHash.insert("T1295507162882", "手机");
    newsHash.insert("T1295507189852", "手机应用");
    newsHash.insert("T1297308230907", "手机行情");
    newsHash.insert("T1297308261694", "新机速递");
    newsHash.insert("T1297308310680", "手机测评");
    newsHash.insert("T1297308355219", "购机指南");
    newsHash.insert("T1346904170077", "移动互联网");
    newsHash.insert("T1295507237702", "数码");
    newsHash.insert("T1295507258836", "笔记本");
    newsHash.insert("T1297308390212", "电脑硬件");
    newsHash.insert("T1297308431904", "数码相机");
    newsHash.insert("T1297308468608", "家电");
    newsHash.insert("T1295507338077", "汽车");
    newsHash.insert("T1295507366689", "最新车讯");
    newsHash.insert("T1297308594651", "国内新车");
    newsHash.insert("T1297308660418", "国际新车");
    newsHash.insert("T1297308678963", "汽车导购");
    newsHash.insert("T1295507421461", "房产");
    newsHash.insert("T1297308742564", "广州房产");
    newsHash.insert("T1297308862936", "北京房产");
    newsHash.insert("T1297308890599", "上海房产");
    newsHash.insert("T1297308919616", "深圳房产");
    newsHash.insert("T1295507471479", "游戏");
    newsHash.insert("T1305878067824", "新游戏");
    newsHash.insert("T1305877423150", "玩家");
    newsHash.insert("T1305876760515", "魔兽世界");
    newsHash.insert("T1319167678452", "暗黑3");
    newsHash.insert("T1305877288270", "电子竞技");
    newsHash.insert("T1305881698978", "单机游戏");
    newsHash.insert("T1305887134238", "电视游戏");
    newsHash.insert("T1305887169397", "综合");
    newsHash.insert("T1309515731593", "话题");
    newsHash.insert("T1295507537904", "旅游");
    newsHash.insert("T1334130115711", "话题深度");
    newsHash.insert("T1334130148846", "话题评论");
    newsHash.insert("T1334130296157", "博客精选");
    newsHash.insert("T1334130320521", "论坛精华");
    newsHash.insert("T1336528712077", "另一面");
    newsHash.insert("T1336528876783", "专业控");
    newsHash.insert("T1336528754726", "数读");
    newsHash.insert("T1336528929188", "独家解读");
    newsHash.insert("T1309330208915", "体育测试栏目");
    newsHash.insert("T1309853102105", "财经测试栏目");
    newsHash.insert("T1309853125355", "娱乐测试栏目");
    newsHash.insert("T1309853165503", "科技测试栏目");
    newsHash.insert("T1314265664936", "汽车客户端资讯列表");
    newsHash.insert("T1314268465672", "汽车客户端头条幻灯");
    newsHash.insert("T1337667621110", "奥运头条");
    newsHash.insert("T1337595389264", "奥运乒乓球");
    newsHash.insert("T1337595419661", "奥运羽毛球");
    newsHash.insert("T1337595503219", "奥运刘翔");
    newsHash.insert("T1337595525050", "奥运田径");
    newsHash.insert("T1337595546846", "奥运男篮");
    newsHash.insert("T1337595566947", "奥运女篮");
    newsHash.insert("T1337595585741", "奥运男足");
    newsHash.insert("T1337595618981", "奥运女足");
    newsHash.insert("T1337595643458", "奥运游泳");
    newsHash.insert("T1337595665899", "奥运跳水");
    newsHash.insert("T1337595680842", "奥运体操");
    newsHash.insert("T1337595696041", "奥运举重");
    newsHash.insert("T1337595711624", "奥运射击");
    newsHash.insert("T1337595729452", "奥运网球");
    newsHash.insert("T1337595745949", "奥运排球");
    newsHash.insert("T1337595760687", "奥运击剑");
    newsHash.insert("T1337595807428", "奥运手球/曲棍球");
    newsHash.insert("T1337595836853", "奥运柔道/跆拳道");
    newsHash.insert("T1337598523902", "奥运手球");
    newsHash.insert("T1337595851687", "奥运摔跤/拳击");
    newsHash.insert("T1337598540965", "奥运曲棍球");
    newsHash.insert("T1337595871698", "奥运赛艇/皮划艇/帆船帆板");
    newsHash.insert("T1337598554998", "奥运柔道");
    newsHash.insert("T1337595886624", "奥运马术/现代五项/铁人三项");
    newsHash.insert("T1337598571399", "奥运跆拳道");
    newsHash.insert("T1337598586701", "奥运拳击");
    newsHash.insert("T1337598602860", "奥运摔跤");
    newsHash.insert("T1337598618033", "奥运帆船帆板");
    newsHash.insert("T1337598632993", "奥运皮划艇");
    newsHash.insert("T1337598652365", "奥运赛艇");
    newsHash.insert("T1337598668828", "奥运现代五项");
    newsHash.insert("T1337598683934", "奥运铁人三项");
    newsHash.insert("T1337598701626", "奥运马术");
    newsHash.insert("T1337595900660", "奥运自行车");
    newsHash.insert("T1337595917590", "奥运射箭");
    newsHash.insert("T1337595967526", "国家页");
    newsHash.insert("T1337595984841", "中国军团");
    newsHash.insert("T1337596003702", "世界诸强");
    newsHash.insert("T1337596043466", "奥运专栏(评论)");
    newsHash.insert("T1337596022681", "奥运访谈");
    newsHash.insert("T1337596068742", "奥运策划");
    newsHash.insert("T1340678408888", "视频头图");
    newsHash.insert("T1337596082719", "伦敦眼");
    newsHash.insert("T1337596097600", "奥运印记");
    newsHash.insert("T1337596114008", "实力榜");
    newsHash.insert("T1343802726546", "家居");
    newsHash.insert("T1347935644175", "教育");
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
//    // invoke the system image viewer
//    InvokeRequest* request = new InvokeRequest();
//    // Set the URI
//    request->setUri(path);
//    request->setTarget("sys.pictures.card.previewer");
//    request->setAction("bb.action.VIEW");
//    // Send the invocation request
//    InvokeTargetReply *cardreply = m_pInvokeManager->invoke(request);
//    Q_UNUSED(cardreply);
}

QString ApplicationUI::getNewsClassId()
{
    return mNewsClassId;
}

QString ApplicationUI::getNewsClassName()
{
    QHash<QString, QString>::const_iterator iter;
    iter = newsHash.find(mNewsClassId);
    if (iter != newsHash.end()) {
        return iter.value();
    }
    return "";
}

void ApplicationUI::setNewsClassId(QString newsClassId)
{
    mNewsClassId = newsClassId;
    emit newsTypeChanged(mNewsClassId);
}
