import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorContainer extends StatelessWidget {
  final Color containerColor;
  final bool isSelected;
  const ColorContainer({
    super.key,
    required this.containerColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: containerColor,
        border: Border.all(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
          width: 3.w,
        ),
      ),
    );
  }
}
