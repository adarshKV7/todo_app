// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:todo_app/controller/todo_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController addController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<String> category = ["Home", "Work"];
  String? dropDownValue;
  static bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new, size: 30),
        title: Row(
          children: [
            Text(
              "Today",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.sunny,
              size: 30,
              color: Colors.amber,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Add task",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Form(
                            key: formKey,
                            child: TextFormField(
                              controller: addController,
                              decoration: InputDecoration(
                                  hintText: "Task",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          DropdownButton(
                              hint: Text("select"),
                              value: dropDownValue,
                              // items: category
                              //     .map((e) => DropdownMenuItem(
                              //           child: Text(e),
                              //           value: e,
                              //         ))
                              //     .toList(),
                              items: [
                                DropdownMenuItem(
                                  child: Text("Home"),
                                  value: "Home",
                                ),
                                DropdownMenuItem(
                                  child: Text("Work"),
                                  value: "Work",
                                )
                              ],
                              onChanged: (value) {
                                dropDownValue = value;
                                setState(() {});
                              }),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }),
                      Text("Task name"),
                      SizedBox(
                        width: 20,
                      ),
                      isChecked == false
                          ? Text(
                              "InComplted",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "Complted",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                    ],
                  ),
                ],
              )),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: TodoController.todoKeyList.length),
    );
  }
}
