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
    objectName: "bird"
    width: 90
    height: 77
    linearVelocity.x: -5
    linearVelocity.y: 0
    fixedRotation: true
    bodyType: Body.Kinematic

    fixtures: Box {
        width: 90
        height: 77
        density: 0.8
        friction: 0.2
        restitution: 0
    }

    Sprite {
        animation: "big"
        animations: [
            SpriteAnimation {
                name: "big"
                source: "images/birds/big/big.png"
                frames: 6
                duration: 600
                loops: Animation.Infinite
            }
        ]
    }
}
