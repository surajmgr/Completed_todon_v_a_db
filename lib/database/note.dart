import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String? description;
  @HiveField(2)
  late DateTime date;
  @HiveField(3)
  late bool isCompleted = false;

  Note(
      {required this.title,
      this.description,
      required this.date,
      required this.isCompleted});
}
