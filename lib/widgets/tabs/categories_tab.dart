import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myspb/const.dart';
import 'package:myspb/store/reasons_repository.dart';

class CategoriesTab extends StatelessWidget {
  final ReasonsRepository _reasonsRepository = ReasonsRepository();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(_reasonsRepository.root?.name ?? TITLE),
          leading: _reasonsRepository.root == null
              ? null
              : IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  onPressed: () {
                    _reasonsRepository.setRoot(_reasonsRepository.parent);
                  },
                ),
        ),
        body: ListView.separated(
          itemCount: _reasonsRepository.reasonsForRoot.length,
          itemBuilder: (context, index) {
            final indexReason = _reasonsRepository.reasonsForRoot[index];
            return ListTile(
              title: Text(indexReason.name),
              subtitle: indexReason.description == null
                  ? null
                  : Text(indexReason.description),
              trailing: indexReason.externalReasonId != null
                  ? null
                  : Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _reasonsRepository.setRoot(indexReason);
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}
