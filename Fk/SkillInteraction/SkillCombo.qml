// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import Fk.Pages

MetroButton {
  id: root
  property string skill
  property var choices: []
  property string default_choice
  property string answer: default_choice
  property bool detailed: false

  function processPrompt(prompt) {
    const data = prompt.split(":");
    let raw = Backend.translate(data[0]);
    const src = parseInt(data[1]);
    const dest = parseInt(data[2]);
    if (raw.match("%src")) raw = raw.replace(/%src/g, Backend.translate(getPhoto(src).general));
    if (raw.match("%dest")) raw = raw.replace(/%dest/g, Backend.translate(getPhoto(dest).general));
    if (raw.match("%arg")) raw = raw.replace(/%arg/g, Backend.translate(data[3]));
    if (raw.match("%arg2")) raw = raw.replace(/%arg2/g, Backend.translate(data[4]));
    return raw;
  }

  text: processPrompt(answer)

  onAnswerChanged: {
    if (!answer) return;
    Backend.callLuaFunction(
      "SetInteractionDataOfSkill",
      [skill, JSON.stringify(answer)]
    );
    roomScene.dashboard.startPending(skill);
  }

  onClicked: {
    if (detailed) {
      roomScene.popupBox.sourceComponent = Qt.createComponent("../RoomElement/DetailedChoiceBox.qml");
    } else {
      roomScene.popupBox.sourceComponent = Qt.createComponent("../RoomElement/ChoiceBox.qml");
    }
    const box = roomScene.popupBox.item;
    box.options = choices;
    box.accepted.connect(() => {
      answer = choices[box.result];
    });
  }

}
