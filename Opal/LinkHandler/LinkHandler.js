//@ This file is part of opal-linkhandler.
//@ https://github.com/Pretty-SFOS/opal-linkhandler
//@ SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

// Note: this file is not a marked as a library because it needs some variables
// from the calling context (pageStack).

/*!
    \qmltype LinkHandler
    \inqmlmodule Opal.LinkHandler
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

/*!
  \qmlmethod bool LinkHandler::openOrCopyUrl(url externalUrl, string title)

  This function shows a page that lets the user preview
  an external link (\a externalUrl) before either copying it to the clipboard,
  copying its title (if available), sharing it
  or opening it externally. The \a title argument is optional.

  \sa Qt::openUrlExternally
*/
function openOrCopyUrl(externalUrl, title) {
    pageStack.push(Qt.resolvedUrl("private/ExternalUrlPage.qml"),
                   {'externalUrl': externalUrl, 'title': !!title ? title : ''})
}

/*!
  \qmlmethod bool LinkHandler::openOrCopyMultipleUrls(array sets)

  This function is the same as \l openOrCopyUrl, except that it shows multiple
  URLs for opening or copying.

  Provide an array of objects in the \a sets parameter. Each object in the array
  must have the same keys that \l openOrCopyUrl takes as parameters: the
  \c externalUrl key is required, the \c title key is optional.

  \sa openOrCopyUrl
*/
function openOrCopyMultipleUrls(sets) {
    var pages = []

    for (var i = 0; i < sets.length; ++i) {
        pages.push({
            'page': Qt.resolvedUrl('ExternalUrlPage.qml'),
            'properties': {
                'externalUrl': sets[i].externalUrl,
                'title': sets[i].hasOwnProperty('title') ? sets[i].title : "",
            }
        })
    }

    pageStack.push(pages)
}
