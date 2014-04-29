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

Entity {
    id: obstacle
    objectName: "obstacle"
    bodyType: Body.Dynamic
    bullet: false
    sleepingAllowed: true
    fixedRotation: false
    //angularDamping: 0.5
    //linearDamping: 0.3
    linearVelocity.y: 2
    width: Math.max(image.width, 1)
    height: Math.max(image.height, 1)

    property var path
    property real density: 1

    Image {
        id: image
        source: path
    }

    behavior: ScriptBehavior {
        script: {
            if (obstacle.linearVelocity.y < 2) {
                obstacle.linearVelocity.y += 0.1;
                //print (obstacle.linearVelocity.y);
            }
            if (obstacle.linearVelocity.x > -7) {
                obstacle.linearVelocity.x -= 1;
            }
        }
    }
}
