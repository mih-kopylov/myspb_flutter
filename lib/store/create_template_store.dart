import 'package:mobx/mobx.dart';
import 'package:myspb/client/classifiers_service.dart';
import 'package:myspb/client/model/classifier.dart';

part "create_template_store.g.dart";

class CreateTemplateStore = _CreateTemplateStore with _$CreateTemplateStore;

abstract class _CreateTemplateStore with Store {
  final FormErrorState errorState = FormErrorState();
  final ClassifiersService classifiersService = ClassifiersService();

  @observable
  String name;

  @observable
  int reasonId;

  @observable
  String body;

  @observable
  ObservableList<Classifier> classifiers = ObservableList.of([]);

  @action
  void validateName(String value) {
    errorState.name =
        (value == null || value.isEmpty) ? "Название обязательно" : null;
  }

  @action
  void validateReasonId(int value) {
    errorState.reasonId =
        (value == null) ? "Нужно выбрать категорию из списка" : null;
  }

  @action
  void validateBody(String value) {
    errorState.body =
        (value == null || value.isEmpty) ? "Текст обращения обязателен" : null;
  }

  List<ReactionDisposer> _disposers;

  void setupValidators() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => reasonId, validateReasonId),
      reaction((_) => body, validateBody)
    ];
  }

  void disposeValidators() {
    for (final disposer in _disposers) {
      disposer();
    }
  }

  void validateAll() {
    validateName(name);
    validateReasonId(reasonId);
    validateBody(body);
  }

  void loadClassifiers() {
    classifiersService
        .loadClassifiers()
        .then((value) => classifiers = ObservableList.of(value));
  }

  List<Classifier> getClassifiersByPattern(String pattern) {
    return classifiers
        .where(
            (e) => e.reasonName.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String name;

  @observable
  String reasonId;

  @observable
  String body;

  @computed
  bool get hasErrors => name != null || reasonId != null || body != null;
}
