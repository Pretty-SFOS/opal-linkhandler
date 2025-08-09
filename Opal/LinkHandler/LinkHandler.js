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
  \qmlmethod bool LinkHandler::openOrCopyUrl(externalUrl, title, previewType)

  This function shows a page that lets the user preview
  an external link (\a externalUrl) before either copying it to the clipboard,
  copying its title (if available), sharing it
  or opening it externally. The \a title argument is optional.
  This module includes an algorithm for checking if the WebView module is installed,
  Internet connection is established, Sailjail permissions include Internet usage
  and the scheme provided is an Internet scheme.
  You can override this algorithm with \a previewType property which can be one of the following:
  
  \list
      \li \c LinkPreviewType.auto - default
      \li \c LinkPreviewType.internetOnly - skips WebView and scheme check, recommended for internet links where scheme should not be checked
      \li \c LinkPreviewType.schemeOnly - skips WebView and internet check
      \li \c LinkPreviewType.internetAndScheme - skips WebView check, recommended for links where you can't fully know if scheme is http or https
      \li \c LinkPreviewType.disable - skips all checks and disables preview, recommended for apps without Internet and WebVoew permissions
      \li \c LinkPreviewType.enable - skips all checks and enables preview
      
  \endlist
    
  It is recommended to set a value different from auto to skip unnecessary checks for performance.

  \sa Qt::openUrlExternally
*/
function openOrCopyUrl(externalUrl, title, previewType) {
    pageStack.push(Qt.resolvedUrl("private/ExternalUrlPage.qml"),
                   {'externalUrl': externalUrl, 'title': !!title ? title : '', 'previewType': typeof previewType !== 'undefined' ? previewType : 0})
}