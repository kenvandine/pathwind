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
import Ubuntu.Components 0.1

Entity {
    id: root
    objectName: "fan"
    anchors {
        bottom: parent.bottom
        bottomMargin: 40
    }

    width: 305
    height: 447
    fixedRotation: true
    bodyType: Entity.Dynamic
    linearVelocity.x: -(units.gu(1)/2)
    property bool running: false

    fixtures: Box {
        anchors.fill: parent
        sensor: true
    }

    Sprite {
        animation: "fan"
        animations: [ SpriteAnimation {
            name: "fan"
            frames: 7
            duration: 200
            loops: Animation.Infinite
            source: "images/sprites/obstacles/fan/fan.png"
            }
        ]
    }
}
