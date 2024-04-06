import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoController {
  static List<dynamic> todoKeyList = [];
  static List<String> categoryList = ['Home', 'Work', 'Personal'];
  static var box = Hive.box<TodoModel>('todo');

  static void initData() {
    todoKeyList = box.keys.toList();
  }

  static Future<void> addData(TodoModel item) async {
    await box.add(item);
    initData();
  }

  static TodoModel? getData(var key) {
    return box.get(key);
  }

  static Future<void> deleteData(var key) async {
    await box.delete(key);
    initData();
  }

  static Future<void> updateDate(var key, TodoModel item) async {
    await box.put(key, item);
    initData();
  }
}
