import QtQuick 2.0
import Bacon2D 1.0

/*!
  \qmltype PhysicsSprite
  \inqmlmodule Bacon2D
  \inherits Body
  \brief A Sprite representation of an Entity, providing state based 
   management of multiple SpriteAnimation animations.
 */

Sprite {
    id: item

    transformOrigin: Item.TopLeft
    property alias body: itemBody

    // Body properties
    property alias world: itemBody.world
    property alias linearDamping: itemBody.linearDamping
    property alias angularDamping: itemBody.angularDamping
    property alias bodyType: itemBody.bodyType
    property alias bullet: itemBody.bullet
    property alias sleepingAllowed: itemBody.sleepingAllowed
    property alias fixedRotation: itemBody.fixedRotation
    property alias active: itemBody.active
    property alias awake: itemBody.awake
    property alias linearVelocity: itemBody.linearVelocity
    property alias angularVelocity: itemBody.angularVelocity
    property alias fixtures: itemBody.fixtures
    property alias gravityScale: itemBody.gravityScale

    Body {
        id: itemBody
        world: scene.world
        target: item
        signal beginContact(Fixture other)
        signal endContact(Fixture other)
    }
}
