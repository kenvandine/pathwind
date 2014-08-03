/*
 * Copyright 2014 Ken VanDine <ken.vandine@ubuntu.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

import QtQuick 2.2
import QtMultimedia 5.0
import Bacon2D 1.0

Scene {
    id: scene
    physics: true
    gravity: Qt.point(0, 0)
    pixelsPerMeter: 18
    height: parent.height + parent.height/2
    width: parent.width
    property alias fuel: player.fuel
    property alias fuelPlus: player.fuelPlus

    onRunningChanged: {
        if (!running) 
            game.currentScene = menuScene;
    }

    function cleanObstacles() {
        for (var i = 0; i < scene.children.length; i++) {
            var obj = scene.children[i];
            if (obj != null) {
                if (((obj.bodyType === Entity.Dynamic || obj.bodyType === Entity.Kinematic)) && (obj.objectName !== "player")) {
                    obj.destroy();
                }
            }
        }
    }

    function reset() {
        scene.cleanObstacles();
        player.reset();
        screen.score = 0;
        screen.levelCount = 0;
        screen.levelCount = 1;
        obstacleInterval.updateInterval = 5000;
        fuelInterval.updateInterval = 12000;
        birdInterval.updateInterval = 20000;
    }

    viewport: Viewport {
        id: gameViewport

        yOffset: player.y - 100
        animationDuration: 0
    }

    ImageLayer {
        id: mountain
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 152
        //width: 2000
        animated: true
        source: "images/scene/mountain.png"
        horizontalStep: -2
        layerType: Layer.Mirrored
    }

    ImageLayer {
        id: ground
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 136
        //width: 2000
        animated: true
        source: "images/scene/ground.png"
        horizontalStep: -5
        layerType: Layer.Mirrored
    }


    property var debrisImages: [ "dust1", "dust2", "dust3", "leaf1", "leaf2", "leaf3" ]
    property var obstacles: [ "Guitar", "Clock", "Door", "BoxObj", "Sign", "Television", "Trash", "Umbrella", "WalkSign", "Wheel" ]
    property int levelLength: 50
    property int fuelInterval: 20

    HowToFlag {
        id: howTo
        y: (parent.height/2) - height/3
        x: parent.width * 0.2
        visible: x > (parent.x - width)
        showSmallBird: false
        Behavior on x {
            NumberAnimation { duration: 3000 }
        }
    }

    Player {
        id: player
        z: 1
        onGameOver: {
            game.currentScene = menuScene;
            scene.reset();
       }
    }

    Wall {
        id: leftWall
        width: 0
        anchors {
            right: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Floor {
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        width: parent.width + player.width
    }

    Ceil {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.top
        }
    }

    HighScore {
        id: highScoreFlag
        y: 300
        visible: false
    }

    Entity {
        updateInterval: 100
        behavior: ScriptBehavior {
            script: {
                var i = Math.floor(Math.random() * scene.debrisImages.length);
                var comp = Qt.createComponent("Debris.qml");
                if (comp.status == Component.Ready)
                    var object = comp.createObject(scene,
                                                   {"x": player.x + scene.width,
                                                    "y": (scene.height - 20) - Math.max((game.height * Math.random()), (game.height - height)),
                                                    "path": "images/particles/"+scene.debrisImages[i]+".png",
                                                    "linearVelocity.x": -(10 + (10 * Math.random()))});
            }
        }
    }

    Entity {
        id: birdInterval
        updateInterval: 20000
        behavior: ScriptBehavior {
            script: {
                var object = birdComp.createObject(scene,
                                                   {"x": player.x + scene.width,
                                                   "y": (scene.y + scene.height * 0.3) + Math.max(((game.height * 0.7) * Math.random()), (game.height/2 - height))});
            }
        }
    }

    Entity {
        id: fuelInterval
        updateInterval: 12000
        behavior: ScriptBehavior {
            script: {
                var object = fuelComp.createObject(scene,
                                                    {"x": player.x + scene.width,
                                                     "y": (scene.height - 20) - Math.max((game.height * Math.random()), (game.height - height))});
            }
        }
    }

    Entity {
        updateInterval: 1000
        behavior: ScriptBehavior {
            script: {
                screen.score = screen.score + screen.levelCount;
                if (screen.score > settings.highScore)
                    settings.highScore = screen.score;
            }
        }
    }

    Entity {
        id: obstacleInterval
        updateInterval: 5000
        behavior: ScriptBehavior {
            script: {
                var i = Math.floor(Math.random() * scene.obstacles.length);
                var comp = Qt.createComponent(scene.obstacles[i]+".qml");
                if (comp.status == Component.Ready) {
                    var object = comp.createObject(scene,
                                                   {"x": player.x + scene.width,
                                                    "y": scene.height - Math.max((game.height * Math.random()), (game.height - height)),
                                                    "linearVelocity.x": -(screen.levelCount * 2)});
                    if (!object.fixedRotation)
                        object.rotation = 10 + Math.random() * 340;
                }
            }
        }
    }

    Entity {
        id: fanInterval
        updateInterval: (screen.levelCount * 20000)
        behavior: ScriptBehavior {
            script: {
                var object = fanComp.createObject(scene,
                                                  {"x": player.x + (scene.width * 1.5)});
                object.running = true;
                screen.levelCount++;
            }
        }
    }

    Component {
        id: fuelComp
        Fuel {}
    }

    Component {
        id: birdComp
        Bird {}
    }

    Component {
        id: fanComp
        Fan {
            onRunningChanged: {
                if (running)
                    fanSound.play();
                else
                    fanSound.stop();
            }
            onXChanged: {
                if (x < -scene.width) {
                    running = false;
                    destroy();
                }
            }
            SoundEffect {
                id: fanSound
                muted: settings.noSound
                volume: Math.max(0.0, Math.min(0.4, Math.abs(1.0 - (Math.abs(x - player.x) / 150) / 10)));
                source: "sounds/fan.wav"
                loops: SoundEffect.Infinite
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: { 
              howTo.x = -parent.width;
              player.fly();
        }
        onReleased: player.stop();
    }
}
