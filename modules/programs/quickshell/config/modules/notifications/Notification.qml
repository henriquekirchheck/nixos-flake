pragma ComponentBehavior: Bound

import "root:/widgets"
import "root:/services"
import "root:/config"
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

StyledRect {
  id: root

  required property Notifs.Notif modelData
  readonly property bool hasImage: modelData.image.length > 0
  readonly property bool hasAppIcon: modelData.appIcon.length > 0
  readonly property int nonAnimHeight: summary.implicitHeight + (root.expanded ? appName.height + body.height + actions.height + actions.anchors.topMargin : bodyPreview.height) + inner.anchors.margins * 2
  property bool expanded

  color: root.modelData.urgency === NotificationUrgency.Critical ? Colours.palette.m3secondaryContainer : Colours.palette.m3surfaceContainer
  radius: Appearance.rounding.normal
  implicitWidth: Config.notifs.sizes.width
  implicitHeight: inner.implicitHeight

  x: Config.notifs.sizes.width
  Component.onCompleted: x = 0

  RetainableLock {
    object: root.modelData.notification
    locked: true
  }

  MouseArea {
    property int startY

    anchors.fill: parent
    hoverEnabled: true
    cursorShape: pressed ? Qt.ClosedHandCursor : undefined
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
    preventStealing: true

    onEntered: root.modelData.timer.stop()
    onExited: root.modelData.timer.start()

    drag.target: parent
    drag.axis: Drag.XAxis

    onPressed: event => {
      startY = event.y;
      if (event.button === Qt.MiddleButton)
        root.modelData.notification.dismiss();
    }
    onReleased: event => {
      if (Math.abs(root.x) < Config.notifs.sizes.width * Config.notifs.clearThreshold)
        root.x = 0;
      else
        root.modelData.popup = false;
    }
    onPositionChanged: event => {
      if (pressed) {
        const diffY = event.y - startY;
        if (Math.abs(diffY) > Config.notifs.expandThreshold)
          root.expanded = diffY > 0;
      }
    }
    onClicked: event => {
      if (!Config.notifs.actionOnClick || event.button !== Qt.LeftButton)
        return;

      const actions = root.modelData.actions;
      if (actions?.length === 1)
        actions[0].invoke();
    }
  }

  Behavior on x {
    NumberAnimation {
      duration: Appearance.anim.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Appearance.anim.curves.emphasizedDecel
    }
  }

  Item {
    id: inner

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: Appearance.padding.normal

    implicitHeight: root.nonAnimHeight

    Behavior on implicitHeight {
      Anim {
        duration: Appearance.anim.durations.expressiveDefaultSpatial
        easing.bezierCurve: Appearance.anim.curves.expressiveDefaultSpatial
      }
    }

    Loader {
      id: image

      active: root.hasImage
      asynchronous: true

      anchors.left: parent.left
      anchors.top: parent.top
      width: Config.notifs.sizes.image
      height: Config.notifs.sizes.image
      visible: root.hasImage || root.hasAppIcon

      sourceComponent: ClippingRectangle {
        radius: Appearance.rounding.full
        implicitWidth: Config.notifs.sizes.image
        implicitHeight: Config.notifs.sizes.image

        Image {
          anchors.fill: parent
          source: Qt.resolvedUrl(root.modelData.image)
          fillMode: Image.PreserveAspectCrop
          cache: false
          asynchronous: true
        }
      }
    }

    Loader {
      id: appIcon

      active: root.hasAppIcon || !root.hasImage
      asynchronous: true

      anchors.horizontalCenter: root.hasImage ? undefined : image.horizontalCenter
      anchors.verticalCenter: root.hasImage ? undefined : image.verticalCenter
      anchors.right: root.hasImage ? image.right : undefined
      anchors.bottom: root.hasImage ? image.bottom : undefined

      sourceComponent: StyledRect {
        radius: Appearance.rounding.full
        color: root.modelData.urgency === NotificationUrgency.Critical ? Colours.palette.m3error : root.modelData.urgency === NotificationUrgency.Low ? Colours.palette.m3surfaceContainerHighest : Colours.palette.m3tertiaryContainer
        implicitWidth: root.hasImage ? Config.notifs.sizes.badge : Config.notifs.sizes.image
        implicitHeight: root.hasImage ? Config.notifs.sizes.badge : Config.notifs.sizes.image

        Loader {
          id: icon

          active: root.hasAppIcon
          asynchronous: true

          anchors.centerIn: parent
          visible: !root.modelData.appIcon.endsWith("symbolic")

          width: Math.round(parent.width * 0.6)
          height: Math.round(parent.width * 0.6)

          sourceComponent: IconImage {
            implicitSize: Math.round(parent.width * 0.6)
            source: Quickshell.iconPath(root.modelData.appIcon)
            asynchronous: true
          }
        }

        Loader {
          active: root.modelData.appIcon.endsWith("symbolic")
          asynchronous: true
          anchors.fill: icon

          sourceComponent: Colouriser {
            source: icon
            colorizationColor: root.modelData.urgency === NotificationUrgency.Critical ? Colours.palette.m3onError : root.modelData.urgency === NotificationUrgency.Low ? Colours.palette.m3onSurface : Colours.palette.m3onTertiaryContainer
          }
        }

        Loader {
          active: !root.hasAppIcon
          asynchronous: true
          anchors.centerIn: parent

          sourceComponent: MaterialIcon {
            text: {
              const summary = root.modelData.summary.toLowerCase();
              if (summary.includes("reboot"))
                return "restart_alt";
              if (summary.includes("recording"))
                return "screen_record";
              if (summary.includes("battery"))
                return "power";
              if (summary.includes("screenshot"))
                return "screenshot_monitor";
              if (summary.includes("welcome"))
                return "waving_hand";
              if (summary.includes("time") || summary.includes("a break"))
                return "schedule";
              if (summary.includes("installed"))
                return "download";
              if (summary.includes("update"))
                return "update";
              if (summary.startsWith("file"))
                return "folder_copy";
              if (summary.startsWith("unable to"))
                return "deployed_code_alert";
              if (root.modelData.urgency === NotificationUrgency.Critical)
                return "release_alert";
              return "chat";
            }

            color: root.modelData.urgency === NotificationUrgency.Critical ? Colours.palette.m3onError : root.modelData.urgency === NotificationUrgency.Low ? Colours.palette.m3onSurface : Colours.palette.m3onTertiaryContainer
            font.pointSize: Appearance.font.size.large
          }
        }
      }
    }

    StyledText {
      id: appName

      anchors.top: parent.top
      anchors.left: image.right
      anchors.leftMargin: Appearance.spacing.smaller

      animate: true
      text: appNameMetrics.elidedText
      maximumLineCount: 1
      color: Colours.palette.m3onSurfaceVariant
      font.pointSize: Appearance.font.size.small

      opacity: root.expanded ? 1 : 0

      Behavior on opacity {
        Anim {}
      }
    }

    TextMetrics {
      id: appNameMetrics

      text: root.modelData.appName
      font.family: appName.font.family
      font.pointSize: appName.font.pointSize
      elide: Text.ElideRight
      elideWidth: expandBtn.x - time.width - timeSep.width - summary.x - Appearance.spacing.small * 3
    }

    StyledText {
      id: summary

      anchors.top: parent.top
      anchors.left: image.right
      anchors.leftMargin: Appearance.spacing.smaller

      animate: true
      text: summaryMetrics.elidedText
      maximumLineCount: 1
      height: implicitHeight

      states: State {
        name: "expanded"
        when: root.expanded

        PropertyChanges {
          summary.maximumLineCount: undefined
        }

        AnchorChanges {
          target: summary
          anchors.top: appName.bottom
        }
      }

      transitions: Transition {
        PropertyAction {
          target: summary
          property: "maximumLineCount"
        }
        AnchorAnimation {
          duration: Appearance.anim.durations.normal
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.anim.curves.standard
        }
      }

      Behavior on height {
        Anim {}
      }
    }

    TextMetrics {
      id: summaryMetrics

      text: root.modelData.summary
      font.family: summary.font.family
      font.pointSize: summary.font.pointSize
      elide: Text.ElideRight
      elideWidth: expandBtn.x - time.width - timeSep.width - summary.x - Appearance.spacing.small * 3
    }

    StyledText {
      id: timeSep

      anchors.top: parent.top
      anchors.left: summary.right
      anchors.leftMargin: Appearance.spacing.small

      text: "•"
      color: Colours.palette.m3onSurfaceVariant
      font.pointSize: Appearance.font.size.small

      states: State {
        name: "expanded"
        when: root.expanded

        AnchorChanges {
          target: timeSep
          anchors.left: appName.right
        }
      }

      transitions: Transition {
        AnchorAnimation {
          duration: Appearance.anim.durations.normal
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.anim.curves.standard
        }
      }
    }

    StyledText {
      id: time

      anchors.top: parent.top
      anchors.left: timeSep.right
      anchors.leftMargin: Appearance.spacing.small

      animate: true
      horizontalAlignment: Text.AlignLeft
      text: root.modelData.timeStr
      color: Colours.palette.m3onSurfaceVariant
      font.pointSize: Appearance.font.size.small
    }

    Item {
      id: expandBtn

      anchors.right: parent.right
      anchors.top: parent.top

      implicitWidth: expandIcon.height
      implicitHeight: expandIcon.height

      StateLayer {
        radius: Appearance.rounding.full

        function onClicked() {
          root.expanded = !root.expanded;
        }
      }

      MaterialIcon {
        id: expandIcon

        anchors.centerIn: parent

        animate: true
        text: root.expanded ? "expand_less" : "expand_more"
        font.pointSize: Appearance.font.size.normal
      }
    }

    StyledText {
      id: bodyPreview

      anchors.left: summary.left
      anchors.right: expandBtn.left
      anchors.top: summary.bottom
      anchors.rightMargin: Appearance.spacing.small

      animate: true
      textFormat: Text.MarkdownText
      text: bodyPreviewMetrics.elidedText
      color: Colours.palette.m3onSurfaceVariant
      font.pointSize: Appearance.font.size.small

      opacity: root.expanded ? 0 : 1

      Behavior on opacity {
        Anim {}
      }
    }

    TextMetrics {
      id: bodyPreviewMetrics

      text: root.modelData.body
      font.family: bodyPreview.font.family
      font.pointSize: bodyPreview.font.pointSize
      elide: Text.ElideRight
      elideWidth: bodyPreview.width
    }

    StyledText {
      id: body

      anchors.left: summary.left
      anchors.right: expandBtn.left
      anchors.top: summary.bottom
      anchors.rightMargin: Appearance.spacing.small

      animate: true
      textFormat: Text.MarkdownText
      text: root.modelData.body
      color: Colours.palette.m3onSurfaceVariant
      font.pointSize: Appearance.font.size.small
      wrapMode: Text.WrapAtWordBoundaryOrAnywhere

      opacity: root.expanded ? 1 : 0

      Behavior on opacity {
        Anim {}
      }
    }

    RowLayout {
      id: actions

      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: body.bottom
      anchors.topMargin: Appearance.spacing.small

      spacing: Appearance.spacing.smaller

      opacity: root.expanded ? 1 : 0

      Behavior on opacity {
        Anim {}
      }

      Repeater {
        model: root.modelData.actions

        delegate: StyledRect {
          id: action

          required property NotificationAction modelData

          radius: Appearance.rounding.full
          color: Colours.palette.m3surfaceContainerHigh

          Layout.preferredWidth: actionText.width + Appearance.padding.normal * 2
          Layout.preferredHeight: actionText.height + Appearance.padding.small * 2
          implicitWidth: actionText.width + Appearance.padding.normal * 2
          implicitHeight: actionText.height + Appearance.padding.small * 2

          StateLayer {
            radius: Appearance.rounding.full

            function onClicked(): void {
              action.modelData.invoke();
            }
          }

          StyledText {
            id: actionText

            anchors.centerIn: parent
            text: actionTextMetrics.elidedText
            color: Colours.palette.m3onSurfaceVariant
            font.pointSize: Appearance.font.size.small
          }

          TextMetrics {
            id: actionTextMetrics

            text: modelData.text
            font.family: actionText.font.family
            font.pointSize: actionText.font.pointSize
            elide: Text.ElideRight
            elideWidth: {
              const numActions = root.modelData.actions.length;
              return (inner.width - actions.spacing * (numActions - 1)) / numActions - Appearance.padding.normal * 2;
            }
          }
        }
      }
    }
  }

  component Anim: NumberAnimation {
    duration: Appearance.anim.durations.normal
    easing.type: Easing.BezierSpline
    easing.bezierCurve: Appearance.anim.curves.standard
  }
}
