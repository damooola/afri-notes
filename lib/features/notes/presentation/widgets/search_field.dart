import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onCloseSearch;
  const SearchField({
    super.key,
    required this.searchController,
    required this.onCloseSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        cursorColor: Theme.of(context).hintColor,
        controller: searchController,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: onCloseSearch,
            child: Icon(Icons.close, color: Theme.of(context).hintColor),
          ),
          hintText: "Search notes by keyword",
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).hintColor),
          contentPadding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
