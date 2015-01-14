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

PhysicsEntity {
    id: fuel
    objectName: "fuel"
    width: 90
    height: 77
    fixedRotation: true
    linearVelocity.x: -10
    linearVelocity.y: 0
    bodyType: Body.Kinematic

    fixtures: Box {
        width: 36
        height: 36
        density: 0
        friction: 0.2
        sensor: true
        categories: Box.Category3
        collidesWith: Box.Category4
        onBeginContact: fuel.destroy(1);
    }

    Sprite {
        animation: "fuelcell"
        animations: SpriteAnimation {
            name: "fuelcell"
            frames: 4
            duration: 400
            loops: Animation.Infinite
            source: "images/fuelcell/fuelcell.png"
        }
    }
}
