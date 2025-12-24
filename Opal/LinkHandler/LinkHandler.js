//@ This file is part of opal-linkhandler.
//@ https://github.com/Pretty-SFOS/opal-linkhandler
//@ SPDX-FileCopyrightText: 2020-2025 Mirian Margiani
//@ SPDX-FileCopyrightText: 2025 roundedrectangle
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
  \qmlmethod bool LinkHandler::openOrCopyUrl(url externalUrl, string title, int previewMode)

  This function shows a page that lets the user preview
  an external link (\a externalUrl) before either copying it to the clipboard,
  copying its title (if available), sharing it
  or opening it externally. The \a title argument is optional.
  This module checks if the WebView module
  is installed for compatibility with older apps,
  if the Internet connection is established, as well as
  if Sailjail permissions include Internet usage
  and the scheme provided is an Internet scheme (HTTP or HTTPS).
  It is recommended to set the \a previewMode property to skip unnecessary checks,
  which can be one of the following:
  
  \list
      \li \c LinkPreviewMode.auto - default, not recommended. Enables the preview if WebView module is available and Internet is available.
      \li \c LinkPreviewMode.checkInternetOnly - enables the preview if Internet is available. Recommended for most apps
      \li \c LinkPreviewMode.checkSchemeOnly - enables the preview if the URL scheme is HTTP or HTTPS
      \li \c LinkPreviewMode.checkInternetAndScheme - enables the preview if Internet is available and the URL scheme is HTTP or HTTPS
      \li \c LinkPreviewMode.disabled - disables the preview
      \li \c LinkPreviewMode.enabled - enables the preview without checking for anything
      
  \endlist

  \sa Qt::openUrlExternally
*/
function openOrCopyUrl(externalUrl, title, previewMode) {
    pageStack.push(Qt.resolvedUrl("private/ExternalUrlPage.qml"),
                   {'externalUrl': externalUrl, 'title': !!title ? title : '', 'previewMode': typeof previewMode !== 'undefined' ? previewMode : 0})
}

/*!
  \qmlmethod bool LinkHandler::openOrCopyMultipleUrls(array sets)

  This function is the same as \l openOrCopyUrl, except that it shows multiple
  URLs for opening or copying.

  Provide an array of objects in the \a sets parameter. Each object in the array
  must have the same keys that \l openOrCopyUrl takes as parameters: the
  \c externalUrl key is required, the \c title and \c previewMode keys are optional.

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
                'previewMode': typeof sets[i].previewMode !== 'undefined' ? sets[i].previewMode : 0
            }
        })
    }

    pageStack.push(pages)
}