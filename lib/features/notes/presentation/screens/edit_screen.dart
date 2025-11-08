import 'package:afrifounders_notes_app/core/colors/colors.dart';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/button_icon.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/color_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditScreen extends StatefulWidget {
  final NoteModel note;

  const EditScreen({super.key, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController headerController;
  late TextEditingController textController;
  late Color selectedColor;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    headerController = TextEditingController(text: widget.note.noteHeader);
    textController = TextEditingController(text: widget.note.noteText);
    selectedColor = widget.note.color;
  }

  @override
  void dispose() {
    headerController.dispose();
    textController.dispose();
    super.dispose();
  }

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveNote() {
    if (headerController.text.trim().isEmpty &&
        textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot save an empty note")),
      );
      return;
    }

    final updatedNote = NoteModel(
      noteHeader: headerController.text.trim(),
      noteText: textController.text.trim(),
      color: selectedColor,
    );

    Navigator.pop(context, updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 70.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonIcon(
                  iconPath: "assets/back.svg",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                !isEditing
                    ? ButtonIcon(
                      iconPath: "assets/edit.svg",
                      onTap: toggleEditMode,
                    )
                    : ButtonIcon(iconPath: "assets/save.svg", onTap: saveNote),
              ],
            ),
            SizedBox(height: 24.h),

            // Color containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap:
                      isEditing
                          ? () {
                            setState(() {
                              selectedColor = noteCardColors[index];
                            });
                          }
                          : null,
                  child: ColorContainer(
                    containerColor: noteCardColors[index],
                    isSelected: selectedColor == noteCardColors[index],
                  ),
                );
              }),
            ),

            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    isEditing
                        ? TextField(
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          controller: headerController,
                          style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            hintText: 'Enter note header',
                          ),
                          maxLines: null,
                        )
                        : Text(
                          headerController.text,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                    SizedBox(height: 16.h),

                    // Text
                    isEditing
                        ? TextField(
                          cursorColor: Theme.of(context).colorScheme.secondary,

                          controller: textController,
                          style: Theme.of(context).textTheme.displaySmall,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            hintText: 'Enter note content',
                          ),
                          maxLines: null,
                          minLines: 5,
                        )
                        : Text(
                          textController.text,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
