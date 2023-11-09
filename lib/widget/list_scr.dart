import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data.dart';
import 'list_ctl.dart';
import 'list_widget.dart';

class listScr extends StatelessWidget {
  const listScr({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tc = TextEditingController();
    GlobalKey<FormState> gkf = GlobalKey<FormState>();
    Get.put(listCtl());
    var c = Get.find<listCtl>();
    Icon? icon;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
                onConfirm: () {
                  c.addTodo(tc.text, icon);
                  tc.text = '';
                  Get.back();
                },
                onCancel: () {
                  Get.back();
                },
                content: Form(
                    key: gkf,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: tc,
                          decoration: const InputDecoration(hintText: 'add here: .....'),
                        )
                      ],
                    )));
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    color: Color.fromARGB(255, 42, 47, 51),
                    // child: Text(
                    //   'List to do...',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: Color.fromARGB(255, 130, 236, 25),
                    //     fontSize: 30,
                    //   ),
                    // ),
                  )
                ],
              ),
              Obx(() {
                return Column(
                  children: <Widget>[
                    for (Data todo in c.todos.value)
                      listWidget(
                          todo: todo,
                          onDelete: () {
                            Get.defaultDialog(
                                title: 'Delete?',
                                content: Column(
                                  children: const <Widget>[
                                    Text('sure??'),
                                  ],
                                ),
                                onConfirm: () {
                                  c.removeTodo(todo.id);
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                });
                          },
                          onEdit: () {
                            GlobalKey<FormState> gkf = GlobalKey<FormState>();
                            TextEditingController tc = TextEditingController();
                            tc.text = todo.title;
                            Get.defaultDialog(
                                onConfirm: () {
                                  c.changTodoText(todo.id, icon, tc.text);
                                  // c.todos.add(todo);
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                                content: Form(
                                    key: gkf,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: tc,
                                          decoration: const InputDecoration(hintText: 'editing'),
                                        )
                                      ],
                                    )));
                          }),
                  ],
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        c.clear();
                      },
                      child: Text('clear'))
                ],
              ),
            ],
          ),
        ));
  }
}
