pragma Singleton
import QtQuick 2.0

QtObject {
    readonly property int auto: 0
    readonly property int checkInternetOnly: 1
    readonly property int checkSchemeOnly: 2
    readonly property int checkInternetAndScheme: 3
    readonly property int enabled: 4
    readonly property int disabled: 5
}