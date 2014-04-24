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

Image {
    id: root

    property string path
    property int frameCount: 1
    property bool running: true
    property int duration: 1000

    source: path + "/" + frame.index + ".png"

    QtObject {
        id: frame
        property int index: 1

        NumberAnimation on index {
            from: 1
            to: frameCount
            running: root.running
            duration: root.duration
            loops: Animation.Infinite
        }
    }
}
