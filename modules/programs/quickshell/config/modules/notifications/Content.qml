import "root:/widgets"
import "root:/services"
import "root:/config"
import Quickshell
import Quickshell.Widgets
import QtQuick

Item {
  id: root

  readonly property int padding: Appearance.padding.large

  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.right: parent.right

  implicitWidth: Config.notifs.sizes.width + padding * 2
  implicitHeight: {
    const count = list.count;
    if (count === 0)
      return 0;

    let height = (count - 1) * Appearance.spacing.smaller;
    for (let i = 0; i < count; i++)
      height += list.itemAtIndex(i)?.nonAnimHeight ?? 0;

    const screen = QsWindow.window?.screen;
    const visibilities = Visibilities.screens[screen];
    const panel = Visibilities.panels[screen];
    if (visibilities && panel) {
      if (visibilities.osd) {
        const h = panel.osd.y - Config.border.rounding * 2;
        if (height > h)
          height = h;
      }

      if (visibilities.session) {
        const h = panel.session.y - Config.border.rounding * 2;
        if (height > h)
          height = h;
      }
    }

    return Math.min((screen?.height ?? 0) - Config.border.thickness * 2, height + padding * 2);
  }

  ClippingWrapperRectangle {
    anchors.fill: parent
    anchors.margins: root.padding

    color: "transparent"
    radius: Appearance.rounding.normal

    ListView {
      id: list

      model: ScriptModel {
        values: [...Notifs.popups].reverse()
      }

      anchors.fill: parent

      orientation: Qt.Vertical
      spacing: 0
      cacheBuffer: QsWindow.window?.screen.height ?? 0

      delegate: Item {
        id: wrapper

        required property Notifs.Notif modelData
        required property int index
        readonly property alias nonAnimHeight: notif.nonAnimHeight
        property int idx

        onIndexChanged: {
          if (index !== -1)
            idx = index;
        }

        implicitWidth: notif.implicitWidth
        implicitHeight: notif.implicitHeight + (idx === 0 ? 0 : Appearance.spacing.smaller)

        ListView.onRemove: removeAnim.start()

        SequentialAnimation {
          id: removeAnim

          PropertyAction {
            target: wrapper
            property: "ListView.delayRemove"
            value: true
          }
          PropertyAction {
            target: wrapper
            property: "enabled"
            value: false
          }
          PropertyAction {
            target: wrapper
            property: "implicitHeight"
            value: 0
          }
          PropertyAction {
            target: wrapper
            property: "z"
            value: 1
          }
          Anim {
            target: notif
            property: "x"
            to: (notif.x >= 0 ? Config.notifs.sizes.width : -Config.notifs.sizes.width) * 2
            duration: Appearance.anim.durations.normal
            easing.bezierCurve: Appearance.anim.curves.emphasized
          }
          PropertyAction {
            target: wrapper
            property: "ListView.delayRemove"
            value: false
          }
        }

        ClippingRectangle {
          anchors.top: parent.top
          anchors.topMargin: wrapper.idx === 0 ? 0 : Appearance.spacing.smaller

          color: "transparent"
          radius: notif.radius
          implicitWidth: notif.implicitWidth
          implicitHeight: notif.implicitHeight

          Notification {
            id: notif

            modelData: wrapper.modelData
          }
        }
      }

      move: Transition {
        Anim {
          property: "y"
        }
      }

      displaced: Transition {
        Anim {
          property: "y"
        }
      }
    }
  }

  Behavior on implicitHeight {
    Anim {}
  }

  component Anim: NumberAnimation {
    duration: Appearance.anim.durations.expressiveDefaultSpatial
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
  }
}
