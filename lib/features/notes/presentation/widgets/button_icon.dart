import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ButtonIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  const ButtonIcon({super.key, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.secondary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
