import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoController {
  static List<dynamic> todoKeyList = [];

  static var myBox = Hive.box<TodoModel>("todo");

  static initKeys() {
    todoKeyList = myBox.keys.toList();
  }

  static Future<void> addData(TodoModel item) async {
    await myBox.add(item);
    initKeys();
  }

  static Future<void> deletedData(var key) async {
    await myBox.delete(key);
    initKeys();
  }

  static TodoModel? getdata(var key) {
    return myBox.get(key);
  }
}
