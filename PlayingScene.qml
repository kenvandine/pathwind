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
    property alias fuel: player.fuel
    property alias fuelPlus: player.fuelPlus

    onRunningChanged: {
        if (!running) 
            game.currentScene = menuScene;
    }

    function reset() {
        player.reset();
        screen.score = 0;
        screen.levelCount = 1;
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
        pixelsPerMeter: units.gu(5)

        property var debrisImages: [ "dust1", "dust2", "dust3", "leaf1", "leaf2", "leaf3" ]
        property var obstacles: [ "Guitar", "Clock", "Door", "BoxObj", "Sign", "Television", "Trash", "Umbrella", "WalkSign", "Wheel" ]
        property int levelLength: 50
        property int obstacleInterval: 10
        property int fuelInterval: 20

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
                scene.reset();
                game.currentScene = menuScene;
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
            updateInterval: 20000
            behavior: ScriptBehavior {
                script: {
                    var object = birdComp.createObject(world,
                                                        {"x": player.x + world.width,
                                                        "y": world.y + Math.max((world.height * Math.random()), world.height/2)});
                }
            }
        }

        Entity {
            updateInterval: 12000
            behavior: ScriptBehavior {
                script: {
                    var object = fuelComp.createObject(world,
                                                        {"x": player.x + world.width,
                                                        "y": world.height - (world.height/4 * Math.random())});
                }
            }
        }

        Entity {
            updateInterval: 1000
            behavior: ScriptBehavior {
                script: {
                    screen.score++;
                    if (screen.score > highscore.value)
                        highscore.value = screen.score;
<<<<<<< HEAD
                }
            }
        }

        Entity {
            updateInterval: 5000
            behavior: ScriptBehavior {
                script: {
                    var i = Math.floor(Math.random() * world.obstacles.length);
                    var comp = Qt.createComponent(world.obstacles[i]+".qml");
                    if (comp.status == Component.Ready) {
                        var object = comp.createObject(world,
                                                       {"x": player.x + world.width,
                                                        "y": world.height - (world.height/4 * Math.random()),
                                                        "linearVelocity.x": -10});
                        if (!object.fixedRotation)
                            object.rotation = 10 + Math.random() * 340;
                        world.createdObstacles.push(object);
=======
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
>>>>>>> use U1db to store the highscore
                    }
                }
            }
        }

        Entity {
            updateInterval: 60000
            behavior: ScriptBehavior {
                script: {
                    var object = fanComp.createObject(world,
                                                      {"x": player.x + (world.width * 2)});
                    object.running = true;
                    world.createdObstacles.push(object);
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
                    if (x < -world.width) {
                        running = false;
                        destroy();
                    }
                }
                SoundEffect {
                    id: fanSound
                    muted: screen.muted
                    volume: Math.max(0.0, Math.min(0.4, Math.abs(1.0 - (Math.abs(x - player.x) / 150) / 10)));
                    source: "sounds/fan.wav"
                    loops: SoundEffect.Infinite
                }
            }
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
                    if (x < -world.width) {
                        running = false;
                        destroy();
                    }
                }
                SoundEffect {
                    id: fanSound
                    muted: screen.muted
                    volume: Math.max(0.0, Math.min(0.4, Math.abs(1.0 - (Math.abs(x - player.x) / 150) / 10)));
                    source: "sounds/fan.wav"
                    loops: SoundEffect.Infinite
                }
            }
        }

        /*
        DebugDraw {
            anchors.fill: parent
            world: world
            visible: false
        }
        */
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
