pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    // ─────────────────────────────────────────────
    // Player
    // ─────────────────────────────────────────────

    readonly property var players:
        Mpris.players.values

    readonly property var active: {
        const playing = players.find(player => player.isPlaying)
        return playing || players[0] || null
    }

    readonly property bool hasPlayer:
        active !== null

    // ─────────────────────────────────────────────
    // Track
    // ─────────────────────────────────────────────

    readonly property string title:
        hasPlayer && active.trackTitle
            ? active.trackTitle
            : "Ничего не играет"

    readonly property string artist:
        hasPlayer
            ? (active.trackArtist || "")
            : ""

    readonly property string album:
        hasPlayer
            ? (active.trackAlbum || "")
            : ""

    readonly property string artUrl:
        hasPlayer
            ? (active.trackArtUrl || "")
            : ""

    readonly property string playerName:
        hasPlayer
            ? active.identity
            : ""

    // ─────────────────────────────────────────────
    // Playback
    // ─────────────────────────────────────────────

    readonly property bool isPlaying:
        hasPlayer && active.isPlaying

    readonly property real position:
        hasPlayer
            ? active.position
            : 0

    readonly property real length:
        hasPlayer
            ? active.length
            : 0

    readonly property real progress:
        length > 0
            ? Math.max(
                  0,
                  Math.min(1, position / length)
              )
            : 0

    // ─────────────────────────────────────────────
    // Controls
    // ─────────────────────────────────────────────

    function togglePlaying() {
        if (!hasPlayer || !active.canTogglePlaying)
            return

        active.togglePlaying()
    }

    function next() {
        if (!hasPlayer || !active.canGoNext)
            return

        active.next()
    }

    function previous() {
        if (!hasPlayer || !active.canGoPrevious)
            return

        active.previous()
    }

    function seek(offset) {
        if (!hasPlayer || !active.canSeek)
            return

        active.seek(offset)
    }
}