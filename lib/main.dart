// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utilities/colors.dart';
import 'utilities/http_overides.dart';
import 'utilities/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(GetMaterialApp.router(
    title: 'Celerates',
    theme: ThemeData(
      primaryColor: ColorApp.main,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: 'Poppins',
    ),
    // initialBinding: AppBinding(),
    getPages: AppPages.pages,
    defaultTransition: Transition.fadeIn,
    debugShowCheckedModeBanner: false,
    routerDelegate: AppRouterDelegate(),
  ));
}

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(RoutesApp.home)!.currentPage!],
    );
  }
}
