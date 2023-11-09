import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'data.dart';

class listCtl extends GetMaterialApp {
  listCtl({super.key});

  static listCtl get to => Get.find();
  RxList<Data> todos = <Data>[
    Data(id: -2, title: 'add your todo here...'),
    Data(id: -1, title: 'add your todo here...'),
  ].obs;
  var dataId = 0;

  addTodo(String title, Icon? icon) {
    todos.add(Data(id: dataId, title: title, icon: icon));
    dataId++;
  }

  removeTodo(int todosId) {
    todos.removeWhere((todos) => todos.id == todosId);
  }

  changTodoText(int todosId, Icon? icon, String newText) {
    var todo = todos.firstWhere((todos) => todos.id == todosId);
    todo.title = newText;
    todo.icon = icon;
    todos.refresh();
  }

  clear() {
    todos.clear();
  }
}
