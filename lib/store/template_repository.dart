import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:myspb/model/template.dart';

part 'template_repository.g.dart';

class TemplateRepository = _TemplateRepository with _$TemplateRepository;

abstract class _TemplateRepository with Store {
  @observable
  int groupId;

  @observable
  ObservableList<Template> allTemplates = ObservableList<Template>.of([
    Template(1, 1, "На ТСОДД", 111, "Бумажные объявления на ТСОДД"),
    Template(2, 2, "На ТСОДД", 222, "Надписи на ТСОДД"),
    Template(3, 1, "На опоре", 333, "Бумажные объявления на опоре освещения"),
    Template(4, 2, "На опоре", 444, "Надписи на опоре освещения"),
    Template(5, null, "Торговля", 555, "Незаконная торговля")
  ]);

  @action
  Template create(Template template) {
    allTemplates.add(template);
    return template;
  }

  @action
  Template update(Template template) {
    var index = allTemplates.indexWhere((r) => r.id == template.id);
    if (index < 0) {
      throw Exception("Template with id ${template.id} not found");
    }
    allTemplates.replaceRange(index, index + 1, [template]);
  }

  @action
  void delete(Template template) {
    allTemplates.removeWhere((r) => r.id == template.id);
  }

  @action
  void setGroupId(int value) {
    groupId = value;
  }

  @computed
  ObservableList<Template> get templatesInGroup =>
      ObservableList.of(allTemplates.where((r) => r.groupId == groupId));

  @computed
  int get nextId => allTemplates.map((element) => element.id).fold(0, max) + 1;
}
