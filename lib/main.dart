import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'modules/design_system/design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primary
    ..backgroundColor = Colors.black
    ..indicatorColor = AppColors.onPrimary
    ..textColor = AppColors.onPrimary
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
