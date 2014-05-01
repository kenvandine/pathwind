import QtQuick 2.2
import U1db 1.0 as U1db

U1db.Database {
    property string appName
    signal settingsLoaded

    id: db
    path: appName + "-settings.u1db"

    Component.onCompleted: {
        settingsLoaded();
    }
}
