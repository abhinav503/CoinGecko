import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BaseWebScreen extends StatefulWidget {
  const BaseWebScreen({super.key});
}

abstract class BaseWebScreenState<T extends BaseWebScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context);

  showToast(String message) {
    // closetoast if open
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - kToolbarHeight - 100.h,
          left: 20.w,
          right: 20.w,
        ),
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        showCloseIcon: true,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
