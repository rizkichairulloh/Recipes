import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipes_global_solutions/utilities/responsive.dart';

import '../models/recipes_model.dart';
import '../utilities/date_convert.dart';

class RecipesController extends GetxController {
  var isLoading = false.obs;
  var recipesList = <Recipes>[].obs;
  var detailRecipesList = <Recipes>[].obs;
  var time = ''.obs;
  var txtSearch = ''.obs;
  var ctrlSearch = TextEditingController().obs;

  var api = 'https://script.google.com/macros/s/AKfycbzITxbM2fiRovqzfrKGe6-XMdF0ty4X3K6FCJiZlDILgXiM3E3JpGyX2yyx8xEVV9LGqg/exec';

  Future fetchRecipes(context) async {
    isLoading.value = true;

    try {
      var url = Uri.parse(
          api);

      dynamic response;
      Responsive.isDesktop(context) ?  response = await http.post(url) : response = await http.get(url);
      debugPrint("Catch : ${response.body}");
      if (response.statusCode == 200) {
        var d = jsonDecode(response.body);
        var data = d['data']['recipes'] as List;
        List<Recipes> list = data.map((e) => Recipes.fromJson(e)).toList();
        List<Recipes> tempList = [];

        for(int i = 0; i < list.length; i++){
          if(list[i].name.toString().toLowerCase().contains(txtSearch.toString().toLowerCase())){
            tempList.add(list[i]);
          }
        }
        recipesList.value = tempList;
        isLoading.value = false;
      }
    } catch (e) {
      (e.toString());
      debugPrint("Catch : $e");
      isLoading.value = false;
    }
  }

  Future fetchDetailRecipes(context) async {
    isLoading.value = true;

    try {
      var url = Uri.parse(
          api);
      dynamic response;
      Responsive.isDesktop(context) ?  response = await http.post(url) : response = await http.get(url);
      debugPrint("Catch : ${response.body}");
      if (response.statusCode == 200) {
        var d = jsonDecode(response.body);
        var data = d['data']['recipes'] as List;
        List<Recipes> list = data.map((e) => Recipes.fromJson(e)).toList();
        List<Recipes> tempList = [];

        for(int i = 0; i < list.length; i++){
          if(list[i].name.toString().toLowerCase().contains(txtSearch.toString().toLowerCase())){
            tempList.add(list[i]);
          }
        }
        detailRecipesList.value = tempList;
        String timeString = detailRecipesList[0].time!;
        Duration duration = DateConvert.parseTimeStringToDuration(timeString);
        time.value = DateConvert.formatDuration(duration);
        isLoading.value = false;
      }
    } catch (e) {
      (e.toString());
      debugPrint("Catch : $e");
      isLoading.value = false;
    }
  }
}