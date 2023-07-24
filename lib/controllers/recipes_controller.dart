import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/recipes_model.dart';

class RecipesController extends GetxController {
  var isLoading = false.obs;
  var recipesList = <Recipes>[].obs;
  var detailRecipesList = <Recipes>[].obs;
  var txtSearch = ''.obs;
  var ctrlSearch = TextEditingController().obs;

  @override
  void onInit() {
    ever(txtSearch, (_){
      fetchRecipes();
    });

    fetchRecipes();
    super.onInit();
  }

  Future fetchRecipes() async {
    isLoading.value = true;

    try {
      var apiSheet =
          'https://script.google.com/macros/s/AKfycbxCVzX7xh5_7w2qtSYNYl6UC3j4u35msDIiAFSNIYxwks0S0wMvk1IUMCzyKehQi8HX9A/exec';

      var url = Uri.parse(
          apiSheet);
      var response = await http.post(url);
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

  Future fetchDetailRecipes() async {
    isLoading.value = true;

    try {
      var apiSheet =
          'https://script.google.com/macros/s/AKfycbxCVzX7xh5_7w2qtSYNYl6UC3j4u35msDIiAFSNIYxwks0S0wMvk1IUMCzyKehQi8HX9A/exec';

      var url = Uri.parse(
          apiSheet);
      var response = await http.post(url);
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
        isLoading.value = false;
      }
    } catch (e) {
      (e.toString());
      debugPrint("Catch : $e");
      isLoading.value = false;
    }
  }
}