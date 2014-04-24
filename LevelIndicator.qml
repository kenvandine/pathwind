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

Item {
    property var value
    FontLoader { id: dPuntillasFont; source: "fonts/d-puntillas-D-to-tiptoe.ttf" }

    Text {
        id: levelText
        anchors { 
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        color: "white"
        font.family: dPuntillasFont.name
        font.pointSize: 20
        text: "Level"
    }

    Text {
        anchors { 
            verticalCenter: parent.verticalCenter
            left: levelText.right
            leftMargin: 10
        }
        color: "white"
        font.family: dPuntillasFont.name
        font.pointSize: 20
        text: value
    }
}
