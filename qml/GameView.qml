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
import Bacon2D 1.0
import U1db 1.0 as U1db

Game {
    id: game
    currentScene: menuScene
    gameName: mainView.applicationName

    Image {
        anchors.fill: parent
        source: "images/scene/bg.png"
    }

    PlayingScene {
        id: playingScene
    }

    MenuScene {
        id: menuScene
        onPlayClicked: game.currentScene = playingScene
        onReplayClicked: { playingScene.reset(); game.currentScene = playingScene; }
        onAboutClicked: game.currentScene = aboutScene
    }

    AboutScene {
        id: aboutScene
        onBackClicked: game.currentScene = menuScene
    }

    Screen {
        id: screen
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        z: 1
        visible: game.currentScene === playingScene
        fuel: playingScene.fuel
        fuelPlus: playingScene.fuelPlus
        onTogglePause: playingScene.running = !playingScene.running
    }

    Settings {
        id: settings
        property int highScore: 0
        property bool noSound: false
    }
}
