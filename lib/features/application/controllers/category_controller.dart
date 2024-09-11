import 'package:final_year_project/data/repositories/categories/category_repository.dart';
import 'package:final_year_project/data/repositories/tips/trip_repository.dart';
import 'package:final_year_project/features/application/models/category_model.dart';
import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:get/get.dart';

import '../../../utils/popups/fulll_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
  Future<void> fetchCategories() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, ..)
      final categories = await _categoryRepository.getAllCategories();

      //Update the category list
      allCategories.assignAll(categories);


    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<List<TripModel>> getCategoryTrips({required String categoryId}) async {
    try{
      final trips = await TripRepository.instance.getTripForCategory(categoryId: categoryId);
      return trips;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }

  }
}