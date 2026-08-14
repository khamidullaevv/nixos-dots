pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var lines: []

    property string plainLyrics: ""

    property bool loading: false

    readonly property bool available:
        lines.length > 0 || plainLyrics.length > 0

    readonly property int currentIndex: {
        if (!lines.length)
            return -1

        let result = -1

        for (let i = 0; i < lines.length; ++i) {
            if (MprisService.position >= lines[i].time)
                result = i
            else
                break
        }

        return result
    }

    readonly property string previousLine:
        currentIndex > 0
            ? lines[currentIndex - 1].text
            : ""

    readonly property string currentLine:
        currentIndex >= 0
            ? lines[currentIndex].text
            : ""

    readonly property string nextLine:
        currentIndex >= 0 &&
        currentIndex + 1 < lines.length
            ? lines[currentIndex + 1].text
            : ""

    Process {
        id: request

        stdout: StdioCollector {
            onStreamFinished: {
                root.loading = false
                root.parse(this.text)
            }
        }

        stderr: StdioCollector {}
    }

    Connections {
        target: MprisService

        function onTitleChanged() {
            root.load()
        }

        function onArtistChanged() {
            root.load()
        }

        function onAlbumChanged() {
            root.load()
        }
    }

    Component.onCompleted: {
        root.load()
    }

    function load() {
        if (!MprisService.hasPlayer)
            return

        if (!MprisService.title)
            return

        root.loading = true

        root.lines = []
        root.plainLyrics = ""

        const title =
            encodeURIComponent(MprisService.title)

        const artist =
            encodeURIComponent(MprisService.artist)

        const album =
            encodeURIComponent(MprisService.album)

        const duration =
            Math.round(MprisService.length)

        const url =
            "https://lrclib.net/api/get" +
            "?track_name=" + title +
            "&artist_name=" + artist +
            "&album_name=" + album +
            "&duration=" + duration

        request.exec([
            "curl",
            "-s",
            "-L",
            "--max-time",
            "8",
            "-A",
            "SairexShell/1.0",
            url
        ])
    }

    function parse(raw) {
        if (!raw)
            return

        try {
            const data = JSON.parse(raw)

            root.plainLyrics =
                data.plainLyrics || ""

            if (!data.syncedLyrics) {
                root.lines = []
                return
            }

            root.lines =
                parseSyncedLyrics(data.syncedLyrics)

        } catch (error) {
            console.log(
                "LyricsService:",
                error
            )

            root.lines = []
            root.plainLyrics = ""
        }
    }

    function parseSyncedLyrics(text) {
        const result = []

        for (const row of text.split("\n")) {
            const match =
                row.match(
                    /^\[(\d+):(\d+(?:\.\d+)?)\]\s*(.*)$/
                )

            if (!match)
                continue

            const minutes =
                Number(match[1])

            const seconds =
                Number(match[2])

            result.push({
                time:
                    minutes * 60 +
                    seconds,

                text:
                    match[3].trim()
            })
        }

        result.sort(
            (a, b) => a.time - b.time
        )

        return result
    }
}