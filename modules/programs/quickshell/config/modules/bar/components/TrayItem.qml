pragma ComponentBehavior: Bound

import "root:/widgets"
import "root:/config"
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

MouseArea {
  id: root

  required property SystemTrayItem modelData

  acceptedButtons: Qt.LeftButton | Qt.RightButton
  implicitWidth: Appearance.font.size.small * 2
  implicitHeight: Appearance.font.size.small * 2

  onClicked: event => {
    if (event.button === Qt.LeftButton)
      modelData.activate();
    else if (modelData.hasMenu)
      menu.open();
  }

  // TODO custom menu
  QsMenuAnchor {
    id: menu

    menu: root.modelData.menu
    anchor.window: this.QsWindow.window
  }

  IconImage {
    id: icon

    source: {
      let icon = root.modelData.icon;
      if (icon.includes("?path=")) {
        const [name, path] = icon.split("?path=");
        icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
      }
      return icon;
    }
    asynchronous: true
    anchors.fill: parent
  }
}
