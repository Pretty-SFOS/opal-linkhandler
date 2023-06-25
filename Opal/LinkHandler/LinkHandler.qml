//@ This file is part of opal-linkhandler.
//@ https://github.com/Pretty-SFOS/opal-linkhandler
//@ SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0

/*!
    \qmltype LinkHandler
    \inqmlmodule Opal.LinkHandler
    \inherits QtObject
    \brief Provides link handlers.

    Use the \l openOrCopyUrl in \c onLinkActivated handlers in \c Label items.

    Example:

    \qml
    import Opal.LinkHandler 1.0

    Label {
        text: 'This is my text, and <a href="https://example.org">this is my link</a>.'
        color: Theme.highlightColor
        linkColor: Theme.primaryColor  // important, as the default color is plain blue
        onLinkActivated: LinkHandler.openOrCopyUrl(link)
    }
    \endqml
*/
QtObject {
    id: root

    /*!
      This function shows a page that lets the user preview
      an external link (\a externalUrl) before either copying it to the clipboard
      or opening it externally. The \a title argument is optional.

      \sa Qt::openUrlExternally
    */
    function openOrCopyUrl(externalUrl, title) {
        pageStack.push(Qt.resolvedUrl("private/ExternalUrlPage.qml"),
            {'externalUrl': externalUrl, 'title': !!title ? title : ''})
    }
}
