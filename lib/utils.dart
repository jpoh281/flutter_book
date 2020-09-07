/// 코드 베이스안에서 여러 장소에서 필요로하는 글로벌 유틸리티들

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbook/base_model.dart';
import 'package:intl/intl.dart';

/// Contact avatar image files, DB files 를 위한 앱의 Document Directory.
Directory docsDir;

/// 유저로부터 선택된 날짜를 받아오는 함수
/// @param inContext 부모 위젯의 BuildContext
/// @return Future
Future selectDate(
    BuildContext inContext, BaseModel inModel, String inDateString) async {
  print("## globals.selectDate()");

  // 디폴트 값을 현재 날짜로 지정. (우리가 추가할 것을 가정)
  DateTime initialDate = DateTime.now();

  // 수정일 시, 기존의 생성일로 설정.
  if (inDateString != null) {
    List dateParts = inDateString.split(",");
    // dateParts로 부터 년 월 일을 불러와 DateTime 생성
    initialDate = DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]),
        int.parse(dateParts[2]));
  }

  // 날짜를 요청청
  DateTime picked = await showDatePicker(
      context: inContext,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  // 취소하지않으면 모델의 chosenDate를 업데이트한다.
  if (picked != null)
    inModel.setChosenDate(DateFormat.yMMMMd("en_US").format(picked.toLocal()));
  return "${picked.year},${picked.month},${picked.day}";
}
