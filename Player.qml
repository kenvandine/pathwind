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

Entity {
    id: player

    objectName: "player"
    property real fuel: 1.0
    property int fuelPlus: 0
    property bool alive: true
    property string playerState: "falling"
    signal gameOver

    width: 120
    height: 132
    bullet: true
    fixedRotation: true
    sleepingAllowed: false
    bodyType: Body.Dynamic
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
            categories: Box.Category4
            onBeginContact: handleCollision(other);
        },
        Box {
            x: 22
            y: 60
            width: 35
            height: 65
            density: 1
            friction: 1
            categories: Box.Category4
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

    Audio {
        id: jetSound
        muted: false
        volume: 0.7
        loops: Audio.Infinite
        source: "sounds/jet.wav"
    }

    Audio {
        id: hitSound
        muted: false
        volume: 0.7
        source: "sounds/hit.wav"
    }

    Audio {
        id: gasSound
        muted: false
        volume: 0.8
        source: "sounds/gas.wav"
    }

    Component.onCompleted: reset()

    function reset() {
        player.x = parent.width * 0.2;
        player.y = height;
        player.fuel = 1.0;
        player.fuelPlus = 0;
        player.alive = true;
        player.playerState = "falling";
        player.linearVelocity.x = 0.1;
    }

    function advance() {
        if (player.alive && (player.x < (parent.width * 0.4))) 
            player.linearVelocity.x = 0.4;
        else if (player.alive && (player.x > (parent.width/2))) 
            player.linearVelocity.x = 0;
        else if (player.alive && (player.x < (parent.width/4))) 
            player.linearVelocity.x =  0.8;

        if (player.playerState == "falling")
            player.applyLinearImpulse(Qt.point(0, 1), getWorldCenter());

        if (player.playerState == "flying") {
            player.linearVelocity.x = 0.5;
            var impulse = Qt.point(0, -1);
            player.fuel = Math.max(0, player.fuel - 0.044);

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
            player.fuel = Math.min(1.0, player.fuel + 0.010);
        }

        if (player.x + player.width < -parent.x) {
            player.gameOver();
        }

    }

    function handleCollision(other) {
        // ceil collision
        if (other.categories == Box.Category6)
            return;

        // ground collision
        if (other.categories == Box.Category2) {
            player.playerState = "walking";
            return;
        }

        // bonus collision
        if (other.categories == Box.Category3) {
            if (player.fuelPlus == 0)
                player.fuelPlus++;
            gasSound.play();
            return;
        }

        // enemy collision
        if (player.alive) {
            hitSound.play();
            player.alive = false;
        }
    }

    function fly() {
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
