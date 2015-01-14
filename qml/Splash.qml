import QtQuick 2.2
import Bacon2D 1.0

Item {
    id: splash
    anchors.fill: parent
    rotation: parent.width > parent.height ? 0 : 90
    property bool running: opacity > 0.0

    Image {
        anchors.fill: parent
        rotation: parent.width > parent.height ? 0 : 90
        source: "images/scene/bg.png"
    }

    Sprite {
        id: sprite
        anchors.centerIn: parent
        width: 142
        height: 236
        animation: "running"
        spriteState: splash.running ? Bacon2D.Running : Bacon2D.Inactive
        animations: [
            SpriteAnimation {
                name: "running"
                source: "images/loading/loading.png"
                frames: 4
                duration: 200
                loops: Animation.Infinite
            }]
    }

    Timer {
        running: true
        interval: 1500
        onTriggered: splash.opacity = 0.0
    }
}
