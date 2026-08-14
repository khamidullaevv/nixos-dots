pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property int barCount: 32

    property var values: Array(barCount).fill(0)
    property bool running: false

    function parseFrame(line) {
        var text = String(line).trim()

        if (text.length === 0)
            return

        var parts = text.split(";")

        if (parts.length < barCount)
            return

        var result = []

        for (var i = 0; i < barCount; ++i) {
            var value = Number(parts[i])

            if (isNaN(value))
                value = 0

            result.push(Math.max(0, Math.min(100, value)))
        }

        values = result
    }

    Process {
        id: cava

        command: [
            "/run/current-system/sw/bin/cava",
            "-p",
            "/etc/nixos/quickshell/rice/services/sairex-cava.conf"
        ]

        running: true

        stdout: SplitParser {
            splitMarker: "\n"

            onRead: function(data) {
                root.parseFrame(data)
            }
        }

        stderr: SplitParser {
            splitMarker: "\n"

            onRead: function(data) {
                console.log("[Sairex CAVA]", data)
            }
        }

        onRunningChanged: {
            root.running = running

            console.log(
                "[Sairex CAVA] running:",
                running
            )
        }
    }
}