import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myspb/const.dart';
import 'package:myspb/model/group.dart';
import 'package:myspb/model/template.dart';
import 'package:myspb/store/group_repository.dart';
import 'package:myspb/store/template_repository.dart';
import 'package:myspb/widgets/create_template.dart';

class CategoriesTab extends StatelessWidget {
  final GroupRepository _groupRepository = GroupRepository();
  final TemplateRepository _templateRepository = TemplateRepository();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(_groupRepository.group?.name ?? TITLE),
          leading: _groupRepository.group == null
              ? null
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _groupRepository.setGroup(_groupRepository.parent);
                    _templateRepository.setGroupId(_groupRepository.parent?.id);
                  },
                ),
        ),
        body: ListView.separated(
          itemCount: _groupRepository.children.length +
              _templateRepository.templatesInGroup.length,
          itemBuilder: (context, index) {
            final bool isGroup = index < _groupRepository.children.length;
            final Group group =
                isGroup ? _groupRepository.children[index] : null;
            final int templateIndex =
                isGroup ? -1 : index - _groupRepository.children.length;
            final Template template = isGroup
                ? null
                : _templateRepository.templatesInGroup[templateIndex];
            return ListTile(
              title: Text(group?.name ?? template.name),
              subtitle:
                  group?.description == null ? null : Text(group.description),
              trailing: isGroup
                  ? Icon(Icons.keyboard_arrow_right)
                  : Icon(Icons.add_a_photo),
              onTap: () {
                if (isGroup) {
                  _groupRepository.setGroup(group);
                  _templateRepository.setGroupId(group.id);
                } else {
                  print(
                      "Create a ticket using template ${template.name} :: ${template.body}");
                }
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          heroTag: "add",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) {
                return CreateTemplate();
              }),
            );
          },
        ),
      ),
    );
  }
}
