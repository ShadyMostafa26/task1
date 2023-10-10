import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/categories_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/shared/cubit/states.dart';
import 'package:store_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<ProductModel>? productModel = [];

  void getAllProducts() {

    DioHelper.getData(
      url: 'products',
    ).then((value) {
      productModel = (value.data as List).map((e) => ProductModel.fromJson(e)).toList();
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllProductsErrorState());
    });
  }

  List<dynamic>? categories = [];

  void getCategories() {
    DioHelper.getData(url: 'products/categories').then((value) {
      categories = value.data;
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState());
    });
  }

  List<CategoryModel>? categoryMode = [];

  void getByCategory({required String categoryName}) {
    DioHelper.getData(url: 'products/category/$categoryName').then((value) {
      categoryMode =
          (value.data as List).map((e) => CategoryModel.fromJson(e)).toList();
      emit(GetByCategorySuccessState());
    }).catchError((error) {
      emit(GetByCategoryErrorState());
    });
  }

  void addProduct({
    required int id,
    required num price,
    required String description,
    required String image,
    required String category,
  }) {
    DioHelper.postData(
      url: 'products',
      data: {
        'id': id,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      },
    ).then((value) {
      getAllProducts();
    }).catchError((error) {
      emit(AddProductErrorState());
    });
  }

  void updateProduct({
    required int id,
    required num price,
    required String description,
    required String image,
    required String title,
    required String category,
  }) {
    emit(UpdateProductLoadingState());
    DioHelper.updateData(
      url: 'products/$id',
      data: {
        'price': price,
        'description': description,
        'image': image ,
        'title': title,
        'category' : category,
      },
    ).then((value) {
      print(value.data);
     getAllProducts();
    }).catchError((error) {
      emit(UpdateProductErrorState());
    });
  }
}
