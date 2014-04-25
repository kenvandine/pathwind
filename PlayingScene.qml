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
import Ubuntu.Components 0.1

Scene {
    id: scene
    height: parent.height * 2
    width: parent.width
    property bool muted
    property int highscore: 0

    onRunningChanged: {
        if (!running) 
            game.currentScene = menuScene;
    }

    function reset() {
        player.reset();
        scene.cleanObstacles();
        screen.score = 0;
    }

    function cleanObstacles() {
        var obj;
        for (var i = 0; i < world.createdObstacles.length; i++) {
            obj = world.createdObstacles[i];
            if (obj != null) {
                obj.visible = false;
                obj = null;
            }
        }
        world.createdObstacles = [];
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
            bottom: parent.bottom
        }
        height: 152
        width: 3416
        animated: true
        source: "images/scene/mountain.png"
        horizontalStep: -2
        drawType: Bacon2D.PlaneDrawType
        layerType: Bacon2D.MirroredType
    }

    ImageLayer {
        id: ground
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        height: 136
        width: 3416
        animated: true
        source: "images/scene/ground.png"
        horizontalStep: -5
        drawType: Bacon2D.PlaneDrawType
        layerType: Bacon2D.MirroredType
    }

    World {
        id: world
        anchors.fill: parent
        gravity: Qt.point(0, 0)
        running: scene.running
        visible: running
        pixelsPerMeter: units.gu(5)

        property var debrisImages: [ "dust1", "dust2", "dust3", "leaf1", "leaf2", "leaf3" ]
        property var obstacles: [ "Fuel", "Guitar", "Clock", "Door", "Bird", "BoxObj", "Sign", "Television", "Trash", "Umbrella", "WalkSign", "Wheel" ]
        property var createdObstacles: []
        property int levelLength: 50
        property var fan: null

        HowToFlag {
            id: howTo
            y: (parent.height/2) + height/2
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
                scene.running = false;
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
            }
            y: -scene.height - height
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
                    var i = Math.floor(Math.random() * world.debrisImages.length);
                    var comp = Qt.createComponent("Debris.qml");
                    if (comp.status == Component.Ready)
                        var object = comp.createObject(world, 
                                                       {"x": player.x + world.width, 
                                                        "y": (world.height/2 * Math.random()) + world.height/2,
                                                        "path": "images/particles/"+world.debrisImages[i]+".png",
                                                        "linearVelocity.x": -(10 + (10 * Math.random()))});
                }
            }
        }

        Entity {
            updateInterval: 500
            behavior: ScriptBehavior {
                script: {
                    screen.score++;
                    if (screen.score > highscore)
                        highscore = screen.score;
                    var r = screen.score % 5;
                    if (r === 0) {
                        var i = Math.floor(Math.random() * world.obstacles.length);
                        var comp = Qt.createComponent(world.obstacles[i]+".qml");
                        if (comp.status == Component.Ready) {
                            var object = comp.createObject(world,
                                                           {"x": player.x + world.width,
                                                            "y": (world.height/2 * Math.random()) + world.height/2,
                                                            "linearVelocity.x": -10});
                            if (!object.fixedRotation)
                                object.rotation = 10 + Math.random() * 340;
                            world.createdObstacles.push(object);
                        }

                        if (screen.score < world.levelLength)
                            screen.levelCount = 1;
                        if (screen.score > ((screen.levelCount + 1) * world.levelLength)) {
                            screen.levelCount++;
                            var comp = Qt.createComponent("Fan.qml");
                            if (comp.status == Component.Ready)
                                world.fan = comp.createObject(world, {"x": player.x + world.width});
                        }
                    }
                }
            }
        }

        Audio {
            id: fanSound
            muted: screen.muted
            source: "sounds/fan.wav"
            loops: Audio.Infinite
        }

        DebugDraw {
            anchors.fill: parent
            world: world
            visible: false
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

    Screen {
        id: screen
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height / 2
        fuel: player.fuel
        fuelPlus: player.fuelPlus
        muted: scene.muted
        onTogglePause: scene.running = !scene.running
    }
}
