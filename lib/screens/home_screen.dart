import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:recipes_global_solutions/controllers/recipes_controller.dart';
import 'package:recipes_global_solutions/utilities/date_convert.dart';
import 'package:recipes_global_solutions/utilities/responsive.dart';
import 'package:recipes_global_solutions/utilities/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _recipesC = Get.put(RecipesController());

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
      _recipesC.fetchRecipes(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Center(
        child: SizedBox(
          width: Responsive.isDesktop(context) ? Get.width / 3 : Get.width,
          height: Get.height,
          child: Obx(() => !_recipesC.isLoading.value
              ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Responsive.isDesktop(context) ? 0 : 16),
                    child:  const Row(
                      children: [
                        Text('Assigment an '),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Muhammad Rizki Chairulloh',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: _recipesC.recipesList.length,
                    itemBuilder: (context, index) {
                      String timeString = _recipesC.recipesList[index].time!;
                      Duration duration = DateConvert.parseTimeStringToDuration(timeString);
                      String formattedDuration = DateConvert.formatDuration(duration);

                      return InkWell(
                        onTap: () {
                          var data = {
                            "name": _recipesC.recipesList[index].name!,
                          };
                          Get.rootDelegate.toNamed(RoutesApp.detailRecipes,
                              parameters: data);
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  Responsive.isDesktop(context) ? 5.0 : 16,
                              horizontal:
                                  Responsive.isDesktop(context) ? 0 : 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                    width: Get.width,
                                    height: 200,
                                    child: Image.network(
                                      _recipesC.recipesList[index].image!,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent?
                                              loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Image finished loading successfully.
                                          return child;
                                        } else {
                                          // Image is still loading.
                                          return Center(
                                            child:
                                                CircularProgressIndicator(
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
                                          Object error,
                                          StackTrace? stackTrace) {
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
                                height: 8,
                              ),
                              Text(
                                _recipesC.recipesList[index].name!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                _recipesC.recipesList[index].headline!,
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
                                  title: 'time',
                                  value: formattedDuration),
                              const SizedBox(
                                height: 4,
                              ),
                              _field(
                                  title: 'calories',
                                  value: _recipesC
                                      .recipesList[index].calories!),
                              const SizedBox(
                                height: 4,
                              ),
                              _field(
                                  title: 'proteins',
                                  value: _recipesC
                                      .recipesList[index].proteins!),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                ],
              )
              : const Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                )),
        ),
      ),
    );
  }
}
