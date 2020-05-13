import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:myspb/client/model/classifier.dart';
import 'package:myspb/model/template.dart';
import 'package:myspb/store/create_template_store.dart';
import 'package:myspb/store/template_repository.dart';

class CreateTemplate extends StatefulWidget {
  @override
  _CreateTemplateState createState() => _CreateTemplateState();
}

class _CreateTemplateState extends State<CreateTemplate> {
  final CreateTemplateStore _createTemplateStore = CreateTemplateStore();
  final TemplateRepository _templateRepository = TemplateRepository();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createTemplateStore.setupValidators();
    _createTemplateStore.loadClassifiers();
  }

  @override
  void dispose() {
    _createTemplateStore.disposeValidators();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Создать шаблон"),
        ),
        body: Form(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Observer(
              builder: (_) => TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Название",
                    hintText: "Название шаблона",
                    errorText: _createTemplateStore.errorState.name),
                onChanged: (value) => _createTemplateStore.name = value,
              ),
            ),
            Observer(
              builder: (_) => TextField(
                decoration: InputDecoration(
                    labelText: "Текст",
                    hintText: "Текст обращения",
                    errorText: _createTemplateStore.errorState.body),
                onChanged: (value) => _createTemplateStore.body = value,
              ),
            ),
            Observer(
              builder: (_) => TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _reasonController,
                  decoration: InputDecoration(
                      labelText: "Категория",
                      hintText: "Категория портала Наш Санкт-Петербург",
                      errorText: _createTemplateStore.errorState.reasonId),
                ),
                suggestionsCallback: (pattern) =>
                    _createTemplateStore.getClassifiersByPattern(pattern),
                onSuggestionSelected: (value) {
                  _createTemplateStore.reasonId = value.reasonId;
                  _reasonController.text = value.reasonName;
                },
                itemBuilder: (BuildContext context, Classifier classifier) {
                  return ListTile(
                    title:
                        Text("${classifier.reasonName} (${classifier.city})"),
                  );
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Ничего не найдено"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Создать"),
                    onPressed: () {
                      _createTemplateStore.validateAll();
                      if (_createTemplateStore.errorState.hasErrors) {
                        return;
                      }
                      Template template = Template(
                          _templateRepository.nextId,
                          _templateRepository.groupId,
                          _createTemplateStore.name,
                          _createTemplateStore.reasonId,
                          _createTemplateStore.body);
                      _templateRepository.create(template);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ]),
        )),
      );
}
