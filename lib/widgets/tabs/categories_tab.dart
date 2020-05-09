import 'package:flutter/material.dart';
import 'package:myspb/const.dart';
import 'package:myspb/model/reason.dart';
import 'package:myspb/model/reasons_model.dart';
import 'package:provider/provider.dart';

class CategoriesTab extends StatefulWidget {
  @override
  CategoriesTabState createState() => CategoriesTabState();
}

class CategoriesTabState extends State<CategoriesTab> {
  int _parentId;
  int _rootId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReasonsModel(),
      child: Consumer<ReasonsModel>(
        builder: (context, reasonsModel, child) {
          final List<Reason> reasons = reasonsModel.ofRoot(_rootId);
          return Scaffold(
            appBar: AppBar(
              title: Text(TITLE),
              leading: _rootId == null
                  ? null
                  : IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () {
                        setState(() {
                          _rootId = _parentId;
                          _parentId = reasonsModel.ofId(_rootId)?.parentId;
                        });
                      },
                    ),
            ),
            body: ListView.separated(
              itemCount: reasons.length,
              itemBuilder: (context, index) {
                final indexReason = reasons[index];
                return ListTile(
                  title: Text(indexReason.name),
                  subtitle: indexReason.description == null
                      ? null
                      : Text(indexReason.description),
                  trailing: indexReason.externalReasonId != null
                      ? null
                      : Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    setState(() {
                      _parentId = _rootId;
                      _rootId = indexReason.id;
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          );
        },
      ),
    );
  }
}
