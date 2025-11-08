import 'package:afrifounders_notes_app/core/colors/colors.dart';
import 'package:afrifounders_notes_app/features/notes/data/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final void Function(BuildContext)? onDelete;

  final VoidCallback goToEditScreen;
  const NoteCard({
    super.key,
    required this.note,
    required this.goToEditScreen,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.45,
        children: [
          CustomSlidableAction(
            onPressed: onDelete,
            autoClose: true,
            flex: 2,
            backgroundColor: AppColors.error,
            borderRadius: BorderRadius.circular(10.r),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),

            child: Center(
              child: SvgPicture.asset(
                'assets/delete.svg',
                width: 32.w,
                height: 32.h,
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: goToEditScreen,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 157.h),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: note.color,
          ),
          child: Text(
            note.noteHeader,
            maxLines: 4,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
