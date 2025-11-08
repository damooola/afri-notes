import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum NoResultEmpty { empty, noResult }

class EmptyNoResult extends StatelessWidget {
  final NoResultEmpty state;
  const EmptyNoResult({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.h,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          state == NoResultEmpty.empty
              ? 'assets/create_note.png'
              : 'assets/no_search_result.png',
          width: 350.w,
          height: 287.h,
        ),
        Text(
          state == NoResultEmpty.empty
              ? "Create your first note !"
              : "No notes. Try searching again !",
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
