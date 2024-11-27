//@ This file is part of opal-linkhandler.
//@ https://github.com/Pretty-SFOS/opal-linkhandler
//@ SPDX-FileCopyrightText: 2021-2023 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.Notifications 1.0
import Sailfish.Share 1.0
import Nemo.DBus 2.0
import '..'

Page {
    id: root
    property url externalUrl
    property string title: '' // optional
    property int previewType: LinkPreviewType.auto

    allowedOrientations: Orientation.All

    Component {
        id: webViewComponent
        Page {
            id: webViewPage
            allowedOrientations: Orientation.All
            property bool __linkhandler_webview: true
            property var __webview

            onStatusChanged: if (status == PageStatus.Active)
                __webview = Qt.createQmlObject("import Sailfish.WebView 1.0
WebView {
    anchors.fill: parent
    url: externalUrl
}", webViewPage); else if (__webview) __webview.destroy()
            Component.onCompleted: statusChanged()
        }
    }

    Timer {
        id: pushWebviewTimer
        interval: 0
        onTriggered: pageStack.pushAttached(webViewComponent)
    }

    DBusInterface {
        // Sailjail info: if we don't specify Internet permission, we won't have access to this service, and as a result no webview will pop up
        // And WebView permission doesn't seem to change anything
        bus: DBus.SystemBus
        service: 'net.connman'
        iface: 'net.connman.Manager'
        path: '/'

        signalsEnabled: LinkPreviewType.auto || previewType === LinkPreviewType.internetOnly

        function checkState(state) {
            if (state === "online") {
                if (previewType !== LinkPreviewType.internetOnly) {
                    try {
                        const tester = Qt.createQmlObject("import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.WebView 1.0
Item{}", root, 'WebviewTester [inline]')
                    } catch(err) { console.log(err); return }
                    if (typeof tester === 'undefined') return
                    tester.destroy()
                }

                if (!pageStack.nextPage())
                    pageStack.pushAttached(webViewComponent)
            } else if (pageStack.nextPage() && pageStack.nextPage().__linkhandler_webview)
                pageStack.popAttached()
        }

        function propertyChanged(name, value) {
            if (name === 'State') checkState(value)
        }

        Component.onCompleted:{
            switch (previewType) {
            case LinkPreviewType.disable:
                break
            case LinkPreviewType.enable:
                // pageStack.completeAnimation doesn't work
                pushWebviewTimer.start()
                break
            default:
                call('GetProperties', [], function(properties) {
                    checkState(properties.State)
                })
            }
        }
    }

    ShareAction {
        id: shareHandler
        mimeType: 'text/x-url'
        title: qsTranslate("Opal.LinkHandler", "Share link")
    }

    Notification {
        id: copyNotification
        previewSummary: qsTranslate("Opal.LinkHandler", "Copied to clipboard: %1").arg(Clipboard.text)
        // previewSummary: qsTranslate("Opal.LinkHandler", "URL copied to clipboard")
        // previewBody: externalUrl
        isTransient: true
        appIcon: "icon-lock-information"
        icon: "icon-lock-information"
    }

    Column {
        width: parent.width
        spacing: (root.orientation & Orientation.LandscapeMask &&
                  Screen.sizeCategory <= Screen.Medium) ?
                     Theme.itemSizeExtraSmall : Theme.itemSizeSmall
        y: (root.orientation & Orientation.LandscapeMask &&
           Screen.sizeCategory <= Screen.Medium) ?
               Theme.paddingLarge : Theme.itemSizeExtraLarge

        Label {
            text: title ? title : qsTranslate("Opal.LinkHandler", "External Link")
            width: parent.width - 2*Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeExtraLarge
            wrapMode: Text.Wrap
        }

        Label {
            text: externalUrl
            width: parent.width - 2*Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.Wrap
        }
    }

    Column {
        anchors {
            bottom: parent.bottom
            bottomMargin: (root.isLandscape &&
                           Screen.sizeCategory <= Screen.Medium) ?
                              Theme.itemSizeExtraSmall : Theme.itemSizeMedium
        }
        width: parent.width
        spacing: Theme.paddingLarge

        ButtonLayout {
            id: firstRow
            preferredWidth: (root.isPortrait || Screen.sizeCategory > Screen.Medium) ?
                                Theme.buttonWidthLarge : Theme.buttonWidthSmall

            Button {
                text: qsTranslate("Opal.LinkHandler", "Copy text to clipboard")
                visible: title
                onClicked: {
                    Clipboard.text = title
                    copyNotification.publish()
                    pageStack.pop()
                }
            }

            Button {
                ButtonLayout.newLine: root.isPortrait || Screen.sizeCategory > Screen.Medium
                text: qsTranslate("Opal.LinkHandler", "Copy to clipboard")
                onClicked: {
                    Clipboard.text = externalUrl
                    copyNotification.publish()
                    pageStack.pop()
                }
            }
        }

        ButtonLayout {
            preferredWidth: firstRow.preferredWidth
            Button {
                text: qsTranslate("Opal.LinkHandler", "Share")
                onClicked: {
                    shareHandler.resources = [{
                        'type': 'text/x-url',
                        'linkTitle': title, // '' by default
                        'status': externalUrl.toString()
                        }]
                    shareHandler.trigger()
                    pageStack.pop()
                }
            }

            Button {
                ButtonLayout.newLine: root.isPortrait || Screen.sizeCategory > Screen.Medium
                text: /^http[s]?:\/\//.test(externalUrl) ?
                        qsTranslate("Opal.LinkHandler", "Open in browser") :
                        qsTranslate("Opal.LinkHandler", "Open externally")
                onClicked: {
                    Qt.openUrlExternally(externalUrl)
                    pageStack.pop()
                }
            }
        }

        Label {
            text: qsTr("Swipe left to preview")
            visible: pageStack.nextPage() && pageStack.nextPage().__linkhandler_webview
            width: parent.width - 2*Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.Wrap
        }
    }
}
