import QtQuick 2.2
import U1db 1.0 as U1db

U1db.Document {
    id: propertyStorage

    property string name
    property variant defaultValue

    //empty by default (will be overwritten)
    //Must be variant so we can use any datatype
    property variant value: false

    // A little hack so value can be used like a normal property
    Component.onCompleted : {
        if(propertyStorage.contents !== undefined)
            value = propertyStorage.contents.value
        else {
            console.log("Settings property '" + name + "' created")
            // This will create the database (with onValueChanged
            value = defaultValue
        }
    }

    onValueChanged: {
        // There is a "bug" that forces us to set it like this
        propertyStorage.contents = { "value": value }
    }

    docId: name
    create: true
    defaults: { "value": defaultValue }
}
