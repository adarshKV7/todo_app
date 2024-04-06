import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late bool completed;
  @HiveField(2)
  String catagory;

  TodoModel({
    required this.catagory,
    required this.title,
    this.completed = false,
  });
}
