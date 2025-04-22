import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todopractise/src/core/theme/theme.dart';

import 'src/core/config/config.dart';
import 'src/core/routes/routes.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder:
          (context, ch) => DismissKeyboard(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.initial,
              onGenerateRoute: AppRoute.generate,
              theme: AppTheme.lightTheme,
            ),
          ),
    );
  }
}
