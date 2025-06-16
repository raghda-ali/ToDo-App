import 'package:flutter/material.dart';
import 'package:todo_app/core/widgets/custom_text_field.dart';

class TodoFormWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const TodoFormWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        CustomTextField(
          hintText: 'Title',
          maxLines: 1,
          controller: widget.titleController,
          onChanged: (String title) {
            setState(() {
              widget.titleController.text = title;
            });
          },
          validator: (title) {
            if (title!.isEmpty) {
              return 'The title cannot be empty';
            }
            return null;
          },
        ),
        CustomTextField(
          hintText: 'Description',
          maxLines: 3,
          controller: widget.descriptionController,
          onChanged: (String description) {
            setState(() {
              widget.descriptionController.text = description;
            });
          },
        ),
      ],
    ),
  );
}
