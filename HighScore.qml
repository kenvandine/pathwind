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

Image {
    source: "images/sprites/wood.png"

    Sprite {
        x: -150
        width: 160
        height: 67
        animation: "highscore"
        animations: SpriteAnimation {
            name: "highscore"
            frames: 6
            duration: 400
            loops: Animation.Infinite
            source: "images/highscore/highscore.png"
        }
    }
}
