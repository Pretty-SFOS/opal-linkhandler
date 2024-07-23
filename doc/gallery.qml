/*
 * This file is part of harbour-opal.
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Mirian Margiani
 */

import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.LinkHandler 1.0 as L

S.Page {
    id: root
    allowedOrientations: S.Orientation.All

    S.SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        S.VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: S.Theme.paddingMedium

            S.PageHeader {
                title: "External links"
            }

            S.SectionHeader {
                text: "Basic usage"
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: root.width - 2*x
                wrapMode: Text.Wrap
                text: "This label contains an " +
                      '<a href="https://example.org">external link</a> that you can activate. ' +
                      "Once clicked, a new page will prompt you to either open " +
                      "or copy the URL."
                color: S.Theme.highlightColor
                linkColor: S.Theme.primaryColor
                onLinkActivated: L.LinkHandler.openOrCopyUrl(link)
            }

            S.SectionHeader {
                text: "Advanced usage"
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: root.width - 2*x
                wrapMode: Text.Wrap
                text: "There can be different kinds of links in a label and " +
                      "they can be handled individually. This is " +
                      '<a href="tel:+4100000000">a phone number</a> while this is ' +
                      '<a href="https://example.org">a website</a>.'
                color: S.Theme.highlightColor
                linkColor: S.Theme.primaryColor
                onLinkActivated: {
                    if (/^tel:/.test(link)) {
                        L.LinkHandler.openOrCopyUrl(link, "Phone number")
                    } else {
                        L.LinkHandler.openOrCopyUrl(link, "Website")
                    }
                }
            }

            S.SectionHeader {
                text: "Silica tools"
            }

            S.LinkedLabel {
                x: S.Theme.horizontalPageMargin
                width: root.width - 2*x
                shortenUrl: true
                plainText: "Silica provides the “LinkedLabel” item that automatically " +
                           "finds links and phone numbers in its text and makes them " +
                           "clickable. This number +4100000000 and " +
                           "this URL https://example.org/very-long?extra-long-data-" +
                           "which-will-be-shortened-automatically are automatically " +
                           "formatted as links. Also note how the long URL is shortened."

                defaultLinkActions: false
                onLinkActivated: {
                    if (/^tel:/.test(link)) {
                        L.LinkHandler.openOrCopyUrl(link, "Phone number")
                    } else {
                        L.LinkHandler.openOrCopyUrl(link, "Website")
                    }
                }
            }
        }
    }
}
