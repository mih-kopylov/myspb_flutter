import 'package:mobx/mobx.dart';
import 'package:myspb/model/group.dart';

part 'group_repository.g.dart';

class GroupRepository = _GroupRepository with _$GroupRepository;

abstract class _GroupRepository with Store {
  @observable
  ObservableList<Group> allGroups = ObservableList<Group>.of([
    Group(1, null, "Бумажные объявления", "Расклеенные бумажные объявления"),
    Group(2, null, "Надписи", "Надписи, граффити и прочие разрисовки")
  ]);

  @observable
  Group group;

  @action
  void setGroup(Group value) {
    group = value;
  }

  @computed
  Group get parent => allGroups.singleWhere(
        (element) => element.id == group?.parentId,
        orElse: () => null,
      );

  @computed
  ObservableList<Group> get children =>
      ObservableList.of(allGroups.where((g) => g.parentId == group?.id));
}
