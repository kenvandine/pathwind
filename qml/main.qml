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
import Ubuntu.Components 0.1

MainView {
    id: mainView
    width: 854
    height: 480
    applicationName: gameView.gameName

    Page {
        id: root
        anchors.fill: parent
        opacity: splash.opacity < 1 ? 1.0 : 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 1500
            }
        }

        OrientationHelper {
            id: orientHelper
            transitionEnabled: false
            orientationAngle: parent.width > parent.height ? 0 : 90

            GameView {
                id: gameView
                anchors.fill: parent
            }
        }
    }

    Splash {
        id: splash
        anchors.fill: parent
        rotation: parent.width > parent.height ? 0 : 90
        Behavior on opacity {
            NumberAnimation {
                duration: 1500
            }
        }
    }
}
