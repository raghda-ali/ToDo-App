import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/custom_elevated_button.dart';
import 'package:todo_app/features/crud/domain/entities/todo_entity.dart';
import 'package:todo_app/features/crud/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/crud/presentation/widgets/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final TodoEntity todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  EditTodoPageState createState() => EditTodoPageState();
}

class EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final toDoProvider = Provider.of<TodosProvider>(context, listen: false);

      toDoProvider.editTitleController.text = widget.todo.title;
      toDoProvider.editDescriptionController.text = widget.todo.description;

      _isInitialized = true;
    }
  }

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
        title: Text('Edit Task'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TodoFormWidget(
                titleController: toDoProvider.editTitleController,
                descriptionController: toDoProvider.editDescriptionController,
              ),
            ),
            SizedBox(height: 30),

            CustomElevatedButton(
              onPressed:
                  toDoProvider.isEditLoading
                      ? null
                      : () async {
                        if (!_formKey.currentState!.validate()) return;

                        final updatedTodo = TodoEntity(
                          id: widget.todo.id,
                          title: toDoProvider.editTitleController.text,
                          description:
                              toDoProvider.editDescriptionController.text,
                          createdTime: widget.todo.createdTime,
                        );

                        await toDoProvider.updateTodo(updatedTodo);

                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      },
              child:
                  toDoProvider.isEditLoading
                      ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        'Update',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
