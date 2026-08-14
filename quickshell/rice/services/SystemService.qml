pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real cpu: 0
    property real ram: 0
    property string ramText: "0 / 0 GB"
    property real disk: 0
    property string diskText: "0 / 0 GB"
    property string uptime: "--"
    property string network: "Offline"

    Process {
        id: stats

        command: [
            "sh",
            "-c",
            "free -b | awk '/Mem:/ {printf \"RAM %.0f %.0f %.0f\\n\", $3, $2, $3/$2*100}' ; " +
            "df -B1 / | awk 'NR==2 {printf \"DISK %.0f %.0f %.0f\\n\", $3, $2, $5}' ; " +
            "uptime -p | sed 's/^up //' ; " +
            "ip route get 1.1.1.1 2>/dev/null | grep -q 'src' && echo 'NETWORK Online' || echo 'NETWORK Offline'"
        ]

        stdout: SplitParser {
            onRead: data => {
                root.parse(data)
            }
        }

        stderr: StdioCollector {}
    }

    Timer {
        interval: 2000
        running: true
        repeat: true

        onTriggered: {
            stats.running = false
            stats.running = true
        }
    }

    Component.onCompleted: {
        stats.running = true
    }

    function parse(line) {
        if (!line)
            return

        const parts =
            line.trim().split(" ")

        if (parts[0] === "RAM") {
            const used =
                Number(parts[1])

            const total =
                Number(parts[2])

            root.ram =
                Number(parts[3]) / 100

            root.ramText =
                formatBytes(used) +
                " / " +
                formatBytes(total)

            return
        }

        if (parts[0] === "DISK") {
            const used =
                Number(parts[1])

            const total =
                Number(parts[2])

            root.disk =
                Number(parts[3]) / 100

            root.diskText =
                formatBytes(used) +
                " / " +
                formatBytes(total)

            return
        }

        if (line.startsWith("NETWORK")) {
            root.network =
                line.substring(8).trim()

            return
        }

        root.uptime = line.trim()
    }

    function formatBytes(bytes) {
        if (bytes >= 1024 * 1024 * 1024)
            return (
                bytes /
                (1024 * 1024 * 1024)
            ).toFixed(1) + " GB"

        return (
            bytes /
            (1024 * 1024)
        ).toFixed(0) + " MB"
    }
}