import 'package:get/get.dart';
import 'package:recipes_global_solutions/screens/recipes_detail_screen.dart';

import '../screens/home_screen.dart';

class RoutesApp {
  static const home = '/home';
  static const detailRecipes = '/home/detail-recipes';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: RoutesApp.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RoutesApp.detailRecipes,
      page: () => const RecipesDetailScreen(
      ),
      parameters: Get.rootDelegate.parameters,
    ),
  ];
}