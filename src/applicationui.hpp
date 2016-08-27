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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <bb/cascades/Invocation>
#include <bb/cascades/InvokeQuery>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeTargetReply>
#include <QObject>
//#include <QtNetwork/QNetworkReply>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QtNetwork/QNetworkConfigurationManager>
#include <QHash>
#include <bb/device/DisplayInfo>

//#include "D:/bbndk/target_10_3_1_995/qnx6/usr/include/qt4/QtCore/QString"
//#include "D:/bbndk/target_10_3_1_995/qnx6/usr/include/qt4/QtNetwork/QtNetwork"

namespace bb
{
    namespace system
    {
        class InvokeManager;
    } /* namespace system */
} /* namespace bb */

namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;
/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI: public QObject
{
Q_OBJECT
    Q_PROPERTY(QString newsClassId READ getNewsClassId WRITE setNewsClassId NOTIFY newsTypeChanged FINAL)
    Q_PROPERTY(QString newsClassName READ getNewsClassName CONSTANT)
    Q_PROPERTY(QString networkTypeName READ getNetworkType CONSTANT)
    Q_PROPERTY(float displayWidth READ getDisplayPixelsWidth CONSTANT)

public:
    ApplicationUI();
    virtual ~ApplicationUI()
    {
    }

    Q_INVOKABLE void get(const QString endpoint);
    Q_SIGNAL void returned(bool success, QString resp);
    Q_INVOKABLE static void setv(const QString &objectName, const QString &inputValue);
    Q_INVOKABLE static QString getv(const QString &objectName, const QString &defaultValue);
    Q_INVOKABLE void viewimage(QString path);

    QString getNewsClassId();
    QString getNewsClassName();
    QString getNetworkType();
    float getDisplayPixelsWidth();
    void setNewsClassId(QString newsClassId);

    QHash<QString,QString> newsHash;

private slots:
    void onSystemLanguageChanged();

    void onArticleCreated();
    void onErrorOcurred(QNetworkReply::NetworkError error);
    void onConfigurationChanged();

signals:
    void newsTypeChanged(QString newsClassId);

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

    QNetworkReply *reply;
    QNetworkAccessManager *networkmgr;
    QNetworkConfigurationManager *networkConfigMgr;
    bb::system::InvokeManager* m_pInvokeManager;

    QString mNewsClassId;
    QString mNewsClassName;
    QString mNetworkTypeName;
    bb::device::DisplayInfo dspInfo;
    void initNewsHash();
};

#endif /* ApplicationUI_HPP_ */
