import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/core/constants/color_constants.dart';

import '../../../model/todo_model.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({
    super.key,
    required this.onComplete,
    this.isEdit = false,
    this.item,
    this.noteKey,
  });
  final void Function()? onComplete;
  final bool isEdit;
  final TodoModel? item;
  final dynamic noteKey;

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final TextEditingController titleController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedCategory;
  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(15).copyWith(top: 25),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Select Category'),
                items: TodoController.categoryList
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value;
                },
                validator: (value) {
                  if (selectedCategory == null) {
                    return 'Please select category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      if (widget.isEdit) {
                        // await NotesScreenController.editNote(
                        //   key: widget.noteKey!,
                        //   item: NoteModel(
                        //     title: titleController.text,
                        //     description: descriptionController.text,
                        //     date: dateController.text,
                        //     colorIndex: selectedColorIndex,
                        //   ),
                        // );
                      } else {
                        await TodoController.addData(
                          TodoModel(
                              title: titleController.text,
                              completed: false,
                              catagory: selectedCategory!),
                        );
                      }

                      Navigator.pop(context);
                      widget.onComplete!();
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Ink(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.inputFillColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          widget.isEdit ? 'Save' : 'Add',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Ink(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color:ColorConstants.inputFillColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
