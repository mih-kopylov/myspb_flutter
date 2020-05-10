import 'package:mobx/mobx.dart';
import 'package:myspb/model/reason.dart';

part 'reasons_repository.g.dart';

class ReasonsRepository = _ReasonsRepository with _$ReasonsRepository;

abstract class _ReasonsRepository with Store {
  @observable
  ObservableList<Reason> allReasons = ObservableList<Reason>();

  @observable
  Reason root;

  @action
  Reason create(Reason reason) {
    allReasons.add(reason);
  }

  _ReasonsRepository() {
    this.allReasons = ObservableList.of([
      Reason(1, null, "Бумажные объявления", null, null),
      Reason(2, null, "Надписи", null, null),
      Reason(3, 1, "На ТСОДД", 5, "Бумажные объявления на ТСОДД"),
      Reason(4, 2, "На ТСОДД", 5, "Надписи на ТСОДД"),
      Reason(5, 1, "На опоре", 5, "Бумажные объявления на опоре освещения"),
    ]);
  }

  @action
  Reason update(Reason reason) {
    var index = allReasons.indexWhere((r) => r.id == reason.id);
    if (index < 0) {
      throw Exception("Reason with id ${reason.id} not found");
    }
    allReasons.replaceRange(index, index + 1, [reason]);
  }

  @action
  void delete(Reason reason) {
    allReasons.removeWhere((r) => r.id == reason.id);
  }

  @action
  void setRoot(Reason reason) {
    root = reason;
  }

  @computed
  Reason get parent => allReasons.singleWhere(
        (element) => element.id == root?.parentId,
        orElse: () => null,
      );

  @computed
  ObservableList<Reason> get reasonsForRoot =>
      ObservableList.of(allReasons.where((r) => r.parentId == root?.id));
}
