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
    property real fuel: 0.0
    property int fuelPlus: 0

    signal togglePause

    Item {
        id: topBar
        height: 50
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

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
                rightMargin: 10
            }
            width: childrenRect.width
        }

        FuelIndicator {
            id: fuelIndicator
            value: fuel
            count: fuelPlus
            anchors {
                top: parent.top
                right: pauseButton.left
                topMargin: 20
                rightMargin: 10
            }
        }

        Image {
            id: pauseButton
            anchors.top: parent.top
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
        muted: settings.noSound
        volume: 0.0
        source: "sounds/wind.wav"
        loops: SoundEffect.Infinite
        Behavior on volume {
            NumberAnimation {
                duration: 1000
            }
        }
        onPlayingChanged: {
            if (playing)
                volume = 0.4;
            else
                volume = 0.0;
        }
    }

    SoundEffect {
        id: tuneSound
        muted: settings.noSound
        volume: 0.0
        source: "sounds/tune.wav"
        loops: SoundEffect.Infinite
        Behavior on volume {
            NumberAnimation {
                duration: 1000
            }
        }
        onPlayingChanged: {
            if (playing)
                volume = 0.4;
            else
                volume = 0.0;
        }
    }

    Component.onCompleted: {
        windSound.play();
        tuneSound.play();
    }
}
