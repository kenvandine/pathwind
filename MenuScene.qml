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
import Bacon2D 1.0

Scene {
    id: menuScene
    anchors.fill: parent

    signal playClicked()
    signal replayClicked()
    signal aboutClicked()

    property bool replayEnabled: false
    property bool muted: true

    Item {
        anchors.centerIn: parent
        Image {
            id: sign
            anchors.centerIn: parent
            source: "images/menu/big_sign.png"

            Score {
                x: 224
                y: 62
                rotation: -12
                value: highscore.value
                transformOrigin: Item.TopLeft
            }

            LoopImage {
                x: 112
                y: 8
                z: -1
                frameCount: 6
                duration: 350
                running: menuScene.running
                path: "images/highscore"
            }

            LoopImage {
                x: 318
                y: 84
                frameCount: 4
                duration: 250
                running: menuScene.running
                path: "images/menu/fan"
            }
        }

        Image {
            anchors.left: sign.right
            anchors.bottom: sign.bottom
            source: "images/menu/play.png"

            MouseArea {
                x: 20
                y: 30
                width: 140
                height: 70
                rotation: 10
                onClicked: {
                    replayEnabled = true;
                    menuScene.playClicked();
                }
            }
        }

        Image {
            id: aboutSign
            anchors.right: sign.left
            anchors.bottom: sign.bottom
            source: "images/menu/about.png"

            MouseArea {
                anchors.fill: parent
                onClicked: menuScene.aboutClicked()
            }
        }

        Image {
            x: aboutSign.x + 135
            y: aboutSign.y + 70
            source: menuScene.muted ? "images/menu/sound_off.png"
                : "images/menu/sound_on.png"

            MouseArea {
                anchors.fill: parent
                onClicked: menuScene.muted = !menuScene.muted
            }
        }
    }

    Item {
        anchors.bottom: parent.bottom
        x: parent.width / 3
        height: 144
        Image {
            x: 210
            y: menuScene.replayEnabled ? 0: 600
            visible: menuScene.replayEnabled
            source: "images/menu/replay.png"

            Behavior on y {
                NumberAnimation { duration: 2000 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: menuScene.replayClicked();
            }
        }

        Image {
            anchors.bottom: parent.bottom
            x: 360
            source: "images/menu/wood.png"
        }
    }
}
