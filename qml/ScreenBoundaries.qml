import QtQuick 2.0
import Bacon2D 1.0

/*
  This body places 32-pixel wide invisible static bodies around the screen,
  to avoid stuff getting out.
*/

Entity {
    id: item

    transformOrigin: Item.TopLeft
    property alias body: itemBody

    // Body properties
    property alias world: itemBody.world

    // Fixture properties
    property alias density: itemBody.density
    property alias friction: itemBody.friction
    property alias restitution: itemBody.restitution
    property alias sensor: itemBody.sensor
    property alias groupIndex: itemBody.groupIndex
    property alias categories: itemBody.categories

    Body {
        id: itemBody
        world: scene.world
        target: item
        bodyType: Body.Static
        property var scene: item.scene
        property real density
        property real friction
        property real restitution
        property bool sensor
        property int groupIndex
        property var categories: undefined
        
        signal beginContact(Fixture other)
        signal endContact(Fixture other)

        Box {
            y: scene.height
            width: scene.width
            height: 32
            density: itemBody.density
            friction: itemBody.friction
            restitution: itemBody.restitution
            sensor: itemBody.sensor
            groupIndex: itemBody.groupIndex
            categories: itemBody.categories
        }
        Box {
            y: -height
            height: 32
            width: scene.width
            density: itemBody.density
            friction: itemBody.friction
            restitution: itemBody.restitution
            sensor: itemBody.sensor
            groupIndex: itemBody.groupIndex
            categories: itemBody.categories
        }
        Box {
            x: -32
            width: 32
            height: scene.height
            density: itemBody.density
            friction: itemBody.friction
            restitution: itemBody.restitution
            sensor: itemBody.sensor
            groupIndex: itemBody.groupIndex
            categories: itemBody.categories
        }
        Box {
            x: scene.width
            width: 32
            height: scene.height
            density: itemBody.density
            friction: itemBody.friction
            restitution: itemBody.restitution
            sensor: itemBody.sensor
            groupIndex: itemBody.groupIndex
            categories: itemBody.categories
        }
    }
}
