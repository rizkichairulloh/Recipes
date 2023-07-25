import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:recipes_global_solutions/controllers/recipes_controller.dart';
import 'package:recipes_global_solutions/utilities/responsive.dart';
import 'package:recipes_global_solutions/utilities/routes.dart';

class RecipesDetailScreen extends StatefulWidget {
  const RecipesDetailScreen({super.key});

  @override
  State<RecipesDetailScreen> createState() => _RecipesDetailScreenState();
}

class _RecipesDetailScreenState extends State<RecipesDetailScreen> {
  final _recipesC = Get.put(RecipesController());
  String formattedDuration = '';

  _field({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        )),
        Expanded(
            child: Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        )),
        const Expanded(child: SizedBox()),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _recipesC.txtSearch.value = Get.rootDelegate.parameters['name']!;
      _recipesC.fetchDetailRecipes(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes Detail'),
        leading: InkWell(
          onTap: () {
            Get.rootDelegate.toNamed(RoutesApp.home);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
        automaticallyImplyLeading: true,
        elevation: 0.0,
      ),
      body: Center(
          child: Obx(() => !_recipesC.isLoading.value &&
                  _recipesC.detailRecipesList.isNotEmpty
              ? Container(
                  width:
                      Responsive.isDesktop(context) ? Get.width / 3 : Get.width,
                  height: Get.height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                              width: Get.width,
                              height: Get.height / 3,
                              child: Image.network(
                                _recipesC.detailRecipesList[0].image!,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    // Image finished loading successfully.
                                    return child;
                                  } else {
                                    // Image is still loading.
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  // Error occurred while loading the image.
                                  return const Center(
                                    child: Text(
                                      'Image not found',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          _recipesC.detailRecipesList[0].name!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _recipesC.detailRecipesList[0].headline!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          _recipesC.detailRecipesList[0].description!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        _field(
                            title: 'calories',
                            value: _recipesC.detailRecipesList[0].calories!),
                        const SizedBox(
                          height: 4,
                        ),
                        _field(
                            title: 'carbos',
                            value: _recipesC.detailRecipesList[0].carbos!),
                        const SizedBox(
                          height: 4,
                        ),
                        _field(
                            title: 'difficulty',
                            value: _recipesC.detailRecipesList[0].difficulty!),
                        const SizedBox(
                          height: 4,
                        ),
                        _field(
                            title: 'fats',
                            value: _recipesC.detailRecipesList[0].fats!),
                        const SizedBox(
                          height: 4,
                        ),
                        _field(
                            title: 'time',
                            value: _recipesC.time.value),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(),
                ))),
    );
  }
}
