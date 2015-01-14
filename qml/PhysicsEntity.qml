import QtQuick 2.0
import Bacon2D 1.0

/*!
  \qmltype PhysicsEntity
  \inqmlmodule Bacon2D
  \inherits Body Entity Scene
  \brief An \l Entity with that participates in the \l Box2D physics world
*/
Entity {
    id: item

    transformOrigin: Item.TopLeft
    property alias body: itemBody

    // Body properties
    property alias world: itemBody.world
    property alias target: itemBody.target

    property alias linearDamping: itemBody.linearDamping
    property alias angularDamping: itemBody.angularDamping
    property alias angularVelocity: itemBody.angularVelocity
    property alias linearVelocity: itemBody.linearVelocity
    property alias bodyType: itemBody.bodyType
    property alias active: itemBody.active
    property alias gravityScale: itemBody.gravityScale
    property alias bullet: itemBody.bullet
    property alias sleepingAllowed: itemBody.sleepingAllowed
    property alias fixedRotation: itemBody.fixedRotation
    property alias awake: itemBody.awake
    property alias fixtures: itemBody.fixtures
    function applyLinearImpulse(impulse, point) {
        itemBody.applyLinearImpulse(impulse, point);
    }
    function getWorldCenter() {
        return itemBody.getWorldCenter();
    }

    /*!
      \qmlmethod void PhysicsEntity::applyForce(const QPointF force, const QPointF point)
    */

    /*!
      \qmlmethod void PhysicsEntity::applyForceToCenter(const QPointF &force)
    */

    /*!
      \qmlmethod void PhysicsEntity::applyTorque(qreal torque)
    */

    /*!
      \qmlmethod void PhysicsEntity::applyLinearImpulse(const QPointF &impulse, const QPointF &point)
    */

    /*!
      \qmlmethod void PhysicsEntity::applyAngularImpulse(qreal impulse)
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::getWorldCenter() const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::getLocalCenter() const
    */

    /*!
      \qmlmethod float PhysicsEntity::getMass() const
    */

    /*!
      \qmlmethod float PhysicsEntity::resetMassData()
    */

    /*!
      \qmlmethod float PhysicsEntity::getInertia() const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::toWorldPoint(const QPointF &localPoint) const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::toWorldVector(const QPointF &localVector) const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::toLocalPoint(const QPointF &worldPoint) const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::toLocalVector(const QPointF &worldVector) const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::getLinearVelocityFromWorldPoint(const QPointF &point) const
    */

    /*!
      \qmlmethod QPointF PhysicsEntity::getLinearVelocityFromLocalPoint(const QPointF &point) const
    */

    /*!
      \qmlsignal void PhysicsEntity::bodyCreated()
      \brief Emitted when the Box2D body has finished initialization
    */

    Body {
        id: itemBody
        world: scene.world
        target: item
        signal beginContact(Fixture other)
        signal endContact(Fixture other)
    }
}


