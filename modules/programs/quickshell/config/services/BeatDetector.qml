pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property real bpm

  Process {
    running: true
    command: ["beat-detector", "--no-log", "--no-stats", "--no-visual"]
    stdout: SplitParser {
      onRead: data => {
        const match = data.match(/BPM: ([0-9]+\.[0-9])/);
        if (match)
          root.bpm = parseFloat(match[1]);
      }
    }
  }
}
