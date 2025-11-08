import 'package:afrifounders_notes_app/core/colors/colors.dart';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/button_icon.dart';
import 'package:afrifounders_notes_app/features/notes/presentation/widgets/color_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late TextEditingController headerController;
  late TextEditingController textController;
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    headerController = TextEditingController();
    textController = TextEditingController();
    selectedColor = noteCardColors.first;
  }

  @override
  void dispose() {
    headerController.dispose();
    textController.dispose();
    super.dispose();
  }

  void saveNote() {
    if (headerController.text.trim().isEmpty &&
        textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot save an empty note")),
      );
      return;
    }

    final newNote = NoteModel(
      noteHeader: headerController.text.trim(),
      noteText: textController.text.trim(),
      color: selectedColor,
    );

    Navigator.pop(context, newNote);
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
                ButtonIcon(iconPath: "assets/save.svg", onTap: saveNote),
              ],
            ),

            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(noteCardColors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = noteCardColors[index];
                    });
                  },
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
                    TextField(
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
                    ),
                    SizedBox(height: 16.h),

                    TextField(
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
