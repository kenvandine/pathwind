/****************************************************************************
**
** Copyright (C) 2011 Nokia Institute of Technology.
** All rights reserved.
** Contact: Manager (renato.chencarek@openbossa.org)
**
** This file is part of the PathWind project.
**
** GNU Lesser General Public License Usage
**
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
****************************************************************************/

import QtQuick 2.2
import QtMultimedia 5.0
import Bacon2D 1.0

PhysicsEntity {
    id: player

    objectName: "player"
    property real fuel: 1.0
    property int fuelPlus: 0
    property bool alive: true
    property string playerState: "falling"
    signal gameOver

    onPlayerStateChanged: print (playerState)

    width: 120
    height: 132
    bullet: false
    fixedRotation: true
    sleepingAllowed: true
    bodyType: Body.Dynamic
    //gravityScale: 2
    x: parent.width * 0.2
    y: parent.height * 0.5
    linearVelocity.x: 0
    //onLinearVelocityChanged: print (linearVelocity)

    behavior: ScriptBehavior {
        script: advance()
    }

    fixtures: [
        Box {
            id: playerFixture
            x: 28
            y: 14
            width: 66
            height: 55
            density: 1
            friction: 1
            restitution: 0
            categories: Fixture.Category4
            onBeginContact: handleCollision(other);
        },
        Box {
            x: 22
            y: 60
            width: 35
            height: 65
            density: 1
            friction: 1
            restitution: 0
            categories: Fixture.Category4
            onBeginContact: handleCollision(other);
        }
    ]

    Sprite {
        id: sprite
        anchors.fill: parent
        animation: player.playerState
        animations: [
            SpriteAnimation {
                name: "walking"
                source: "images/sprites/player/walking/walking.png"
                frames: 6
                duration: 400
                loops: Animation.Infinite
            },
            SpriteAnimation {
                name: "falling"
                source: "images/sprites/player/falling/falling.png"
                frames: 3
                duration: 200
                loops: Animation.Infinite
            },
            SpriteAnimation {
                name: "jumping"
                source: "images/sprites/player/jumping/jumping.png"
                frames: 2
                duration: 200
                loops: 1
                onFinished: player.playerState = "flying"
            },
            SpriteAnimation {
                name: "flying"
                source: "images/sprites/player/flying/flying.png"
                frames: 3
                duration: 200
                loops: Animation.Infinite
                onRunningChanged: {
                    if (running)
                        jetSound.play();
                    else
                        jetSound.stop();
                }
            }
        ]
    }

    SoundEffect {
        id: jetSound
        muted: settings.noSound
        volume: 0.5
        loops: SoundEffect.Infinite
        source: "sounds/jet.wav"
    }

    SoundEffect {
        id: hitSound
        muted: settings.noSound
        volume: 0.5
        source: "sounds/hit.wav"
    }

    SoundEffect {
        id: gasSound
        muted: settings.noSound
        volume: 0.5
        source: "sounds/gas.wav"
    }

    function reset() {
        player.x = parent.width * 0.2;
        player.y = parent.height * 0.5;
        player.fuel = 1.0;
        player.fuelPlus = 0;
        player.alive = true;
        player.playerState = "falling";
        player.linearVelocity.x = 0;
    }

    function advance() {
        if (player.alive)
            player.linearVelocity.x = 0;
        else
            player.linearVelocity.x = -20;

        if (player.playerState == "falling")
            player.applyLinearImpulse(Qt.point(0, 2), getWorldCenter());

        if (player.playerState == "flying") {
            var impulse = Qt.point(0, -2);
            //FIXME for testing only
            //player.fuel = Math.max(0, player.fuel - 0.044);

            if (player.fuel <= 0) {
                if (player.fuelPlus == 0) {
                    player.stop();
                } else {
                    player.fuelPlus--;
                    player.fuel = 1.0;
                }
            } else {
                player.applyLinearImpulse(impulse, getWorldCenter());
            }
        } else {
            player.fuel = Math.min(1.0, player.fuel + 0.05);
        }

        if (player.x + player.width < -parent.x) {
            player.linearVelocity.x = 0;
            player.gameOver();
        }
    }


    function handleCollision(other) {
        //print (Fixture.Category2);
        // ground collision
        if (other.categories == Fixture.Category2) {
            player.playerState = "walking";
            return;
        }
        var target = other.getBody().target;
        //print (target)
        // ignore debris collision
        if (target.objectName === "debris")
            return;
        // ceiling collision
        if (other.categories == Fixture.Category6) {
            player.linearVelocity.y = 2;
            return;
        }

        // bonus collision
        if (target.objectName === "fuel" ) {
            if (player.fuelPlus == 0)
                player.fuelPlus++;
            gasSound.play();
            return;
        }

        // enemy collision
        if ((target.objectName === "obstacle") ||
            (target.objectName === "bird")) {
            var valA = player.x + (player.width/2);
            var valB = target.x + (target.width/2);

            if (valA < valB) {
                hitSound.play();
                player.alive = false;
            }
        }
    }

    function fly() {
        print ("FLY: fuel: " + player.fuel + " state: " + player.playerState);
        if (player.fuel <= 0)
            return;

        if (player.playerState == "walking")
            player.playerState = "jumping";
        else {
            player.playerState = "flying";
        }
    }

    function stop() {
        if (player.playerState == "flying")
            player.playerState = "falling";
        else if (player.playerState == "jumping")
            player.playerState = "walking";
    }
}
