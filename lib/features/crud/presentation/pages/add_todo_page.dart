import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/custom_elevated_button.dart';
import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/presentation/widgets/todo_form_widget.dart';
import '../provider/todos_provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  AddTodoPageState createState() => AddTodoPageState();
}

class AddTodoPageState extends State<AddTodoPage> {
  final _addFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<TodosProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Add Task'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Form(
              key: _addFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodoFormWidget(
                    titleController: toDoProvider.addTitleController,
                    descriptionController:
                        toDoProvider.addDescriptionController,
                  ),
                  SizedBox(height: 30),

                  CustomElevatedButton(
                    onPressed:
                        toDoProvider.isAddLoading
                            ? null
                            : () async {
                              if (!_addFormKey.currentState!.validate()) return;

                              final todo = TodoEntity(
                                id: DateTime.now().toString(),
                                title: toDoProvider.addTitleController.text,
                                description:
                                    toDoProvider.addDescriptionController.text,
                                createdTime: DateTime.now(),
                              );

                              await toDoProvider.addTodo(todo);

                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            },
                    child:
                        toDoProvider.isAddLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
