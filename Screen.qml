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

Item {
    id: screen

    property int score: 0
    property int levelCount: 1
    property int offset: 0
    property int metersByPixel: 120
    property real verticalProgress: 0.0
    property int highScore: 0
    property bool muted
    property real fuel: 0.0
    property int fuelPlus: 0

    signal togglePause

    Item {
        id: topBar
        height: 50
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        x: 100

        LevelIndicator {
            id: level
            value: screen.levelCount
            height: fuelIndicator.height
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
        }

        Score {
            id: score
            value: screen.score
            height: fuelIndicator.height 
            anchors {
                verticalCenter: parent.verticalCenter
                right: fuelIndicator.left
                rightMargin: 80
            }
        }

        FuelIndicator {
            id: fuelIndicator
            value: fuel
            count: fuelPlus
            anchors {
                bottom: parent.bottom
                right: pauseButton.left
                bottomMargin: 10
                rightMargin: 10
            }
        }

        Image {
            id: pauseButton
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            source: "images/pause.png"
            height: topBar.height * 3
            width: height
            MouseArea {
                anchors.fill: parent
                onClicked: screen.togglePause();
            }
        }
    }

    SoundEffect {
        id: windSound
        muted: screen.muted
        volume: 0.4
        source: "sounds/wind.wav"
        loops: SoundEffect.Infinite
    }

    SoundEffect {
        id: tuneSound
        muted: screen.muted
        volume: 0.4
        source: "sounds/tune.wav"
        loops: SoundEffect.Infinite
    }

    Component.onCompleted: {
        windSound.play();
        tuneSound.play();
    }
}
