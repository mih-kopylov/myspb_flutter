import 'package:flutter_test/flutter_test.dart';
import 'package:myspb/model/group.dart';
import 'package:myspb/store/group_repository.dart';

void main() {
  GroupRepository groupRepository = GroupRepository();

  test("defaultConfiguration", () {
    expect(groupRepository.parent, isNull);
    expect(groupRepository.group, isNull);
    expect(groupRepository.children.length, equals(2));
  });

  test("switch to group", () {
    final Group firstGroup = groupRepository.children[0];
    groupRepository.setGroup(firstGroup);
    expect(groupRepository.parent, isNull);
    expect(groupRepository.group, equals(firstGroup));
    expect(groupRepository.children.length, equals(0));
  });
}
