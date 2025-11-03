pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.components

Scope {
  id: bar

  Variants {
    model: Quickshell.screens

    LazyLoader {
      id: barLoader
      active: true
      required property ShellScreen modelData
      component: PanelWindow {
        id: barRoot
        screen: barLoader.modelData
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Bottom

        anchors {
          top: true
          left: true
          right: true
        }

        implicitHeight: 25
        Item {
          id: barContent
          anchors.fill: parent
          Rectangle {
            anchors.fill: parent
            color: "black"
          }
        }

        Item {
          id: roundDecorators
          anchors {
            left: parent.left
            right: parent.right
            top: barContent.bottom
          }

          implicitHeight: 200

          RoundCorner {
            id: leftCorner
            color: "black"
            anchors {
              top: parent.top
              bottom: parent.bottom
              left: parent.left
            }
            implicitSize: 200

            corner: RoundCorner.CornerEnum.TopLeft
          }
          RoundCorner {
            id: rightCorner
            color: "black"
            anchors {
              top: parent.top
              bottom: parent.bottom
              right: parent.right
            }
            implicitSize: 200

            corner: RoundCorner.CornerEnum.TopRight
          }
        }
      }
    }
  }
}
