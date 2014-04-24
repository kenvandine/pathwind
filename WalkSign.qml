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

Obstacle {
    path: "images/sprites/obstacles/sign2.png"

    fixtures: [
        Circle {
            anchors {
                top: parent.top
                left: parent.left
            }
            radius: 28
            friction: 0.1
            density: parent.density
            restitution: 0.7
        },
        Box {
            x: 25
            y: 5
            width: 6
            height: 126
            friction: 0.1
            density: parent.density
            restitution: 0.7
        }
    ]
}
