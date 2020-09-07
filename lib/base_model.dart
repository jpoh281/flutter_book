import 'package:scoped_model/scoped_model.dart';

/// 모든 엔티티들이 상속받는 기본 클래스 모델
class BaseModel extends Model {
  /// 스택의 현재 페이지
  int stackIndex = 0;

  /// 엔티티들의 리스트
  List entityList = [];

  /// 편집중인 엔티티
  var entityBeingEdited;

  /// 사용자가 선택한 날짜. 사용자가 선택한 항목을 입력 화면에 표시할 수 있어야 함
  String chosenDate;

  /// 사용자가 선택한 날짜 표시
  /// @param inDate The date in MM/DD/YYYY form.
  void setChosenDate(String inDate) {
    print("## BaseMdoel.setChosenDate() : inDate = $inDate");

    chosenDate = inDate;
    notifyListeners();
  }

  /// 데이터베이스에서 데이터를 불러옴
  /// @param inEntityType 불러올 객체의 타입 {"appointments", "contacts", "notes", or "tasks }.
  /// @param inDatabase DBProvider.db instance for the entity.
  void loadData(String inEntityType, dynamic inDatabase) async {
    print("## ${inEntityType}Model.loadData()");

    // 데이터베이스로부터 엔티티들을 불러옴.
    entityList = await inDatabase.getAll();

    notifyListeners();
  }

  /// For navigating between entry and list views.
  /// @param inStackIndex The stack index to make current.
  void setStackIndex(int inStackIndex) {
    print("## BaseModel.setStackIndex(): inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();
  }
}
