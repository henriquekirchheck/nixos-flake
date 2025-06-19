import "root:/widgets"
import "root:/services"
import "root:/config"
import QtQuick
import QtQuick.Controls

Row {
  id: root

  anchors.top: parent.top
  anchors.bottom: parent.bottom

  padding: Appearance.padding.large
  spacing: Appearance.spacing.normal

  Resource {
    icon: "memory"
    value: SystemUsage.cpuPerc
    colour: Colours.palette.m3primary
  }

  Resource {
    icon: "memory_alt"
    value: SystemUsage.memPerc
    colour: Colours.palette.m3secondary
  }

  Resource {
    icon: "hard_disk"
    value: SystemUsage.storagePerc
    colour: Colours.palette.m3tertiary
  }

  component Resource: Item {
    id: res

    required property string icon
    required property real value
    required property color colour

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.margins: Appearance.padding.large
    implicitWidth: icon.implicitWidth

    StyledRect {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      anchors.bottom: icon.top
      anchors.bottomMargin: Appearance.spacing.small

      implicitWidth: Config.dashboard.sizes.resourceProgessThickness

      color: Colours.palette.m3surfaceContainerHigh
      radius: Appearance.rounding.full

      StyledRect {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitHeight: res.value * parent.height

        color: res.colour
        radius: Appearance.rounding.full
      }
    }

    MaterialIcon {
      id: icon

      anchors.bottom: parent.bottom

      text: res.icon
      color: res.colour
    }

    Behavior on value {
      NumberAnimation {
        duration: Appearance.anim.durations.large
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
      }
    }
  }
}
