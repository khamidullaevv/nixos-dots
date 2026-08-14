pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var values: []

    readonly property bool running:
        cava.running

    Process {
        id: cava

        command: [
            "sh",
            "-c",
            "cava -p /dev/stdin"
        ]

        stdinEnabled: true

        stdout: SplitParser {
            onRead: data => {
                root.parse(data)
            }
        }

        stderr: StdioCollector {}

        onStarted: {
            write(
                "[general]\n" +
                "bars = 32\n" +
                "framerate = 30\n" +
                "\n" +
                "[output]\n" +
                "method = raw\n" +
                "data_format = ascii\n" +
                "ascii_max_range = 100\n"
            )
        }
    }

    Component.onCompleted: {
        cava.running = true
    }

    function parse(data) {
        if (!data)
            return

        const values = []

        for (const char of data.trim()) {
            const value =
                char.charCodeAt(0)

            values.push(
                Math.max(
                    0,
                    Math.min(
                        1,
                        value / 100
                    )
                )
            )
        }

        if (values.length > 0)
            root.values = values
    }
}