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

Item {
    id: root
    width: image.width
    height: image.height

    property int deviation: 6
    property alias data: board.children
    property alias showSmallBird: smallBird.visible
    property bool animating: root.visible

    Image {
        id: image
        source: "images/about/flag.png"

        Item {
            id: board
            anchors {
                fill: parent
                topMargin: 30
                leftMargin: 40
                rightMargin: 100
                bottomMargin: 30
            }
        }

        LoopImage {
            z: -1
            anchors {
                right: parent.left
                verticalCenter: parent.verticalCenter
                rightMargin: -8
            }
            frameCount: 4
            duration: 400
            running: root.animating
            path: "images/about/stripes"
        }

        LoopImage {
            x: 402
            y: 30
            frameCount: 6
            duration: 150
            running: root.animating
            path: "images/birds/big"
        }

        SequentialAnimation on y {
            running: root.animating
            loops: Animation.Infinite

            NumberAnimation {
                from: -root.deviation
                to: root.deviation
                duration: 800
                easing.type: Easing.InQuad
            }
            NumberAnimation {
                from: root.deviation
                to: -root.deviation
                duration: 800
                easing.type: Easing.OutQuad
            }
        }
    }

    LoopImage {
        id: smallBird
        x: 540
        y: 120
        frameCount: 6
        duration: 150
        running: root.animating
        path: "images/birds/small"

        SequentialAnimation on y {
            running: root.animating
            loops: Animation.Infinite

            NumberAnimation {
                from: -root.deviation
                to: root.deviation
                duration: 600
                easing.type: Easing.InQuad
            }
            NumberAnimation {
                from: root.deviation
                to: -root.deviation
                duration: 600
                easing.type: Easing.OutQuad
            }
        }
    }
}
