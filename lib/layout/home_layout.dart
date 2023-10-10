import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/modules/update_product/update_product_screen.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/shared/cubit/cubit.dart';
import 'package:store_app/shared/cubit/states.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<dynamic> searchedList = [];

  void runFilter(String enteredWord) {
    List<dynamic> results = [];
    if (enteredWord.isEmpty) {
      results = AppCubit
          .get(context)
          .productModel!;
    } else {
      results = AppCubit
          .get(context)
          .productModel!
          .where((element) =>
          element.title!.toLowerCase().contains(enteredWord.toLowerCase()))
          .toList();
    }
    setState(() {
      searchedList = results;
    });
  }

  @override
  void initState() {
    super.initState();
    searchedList = AppCubit
        .get(context)
        .productModel!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: TextField(
                    onChanged: (value) => runFilter(value),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      searchedList.isEmpty ? AppCubit
                          .get(context)
                          .productModel!
                          .length : searchedList.length,
                          (index) =>
                          buildGridItem(
                              context, searchedList.isEmpty ?  AppCubit
                              .get(context)
                              .productModel![index] : searchedList[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridItem(context, ProductModel model) =>
      GestureDetector(
        onTap: () {
          print(model.id!);
          navigateTo(
            context,
            UpdateProductScreen(
              id: model.id!,
              image: model.image!,
              category: model.category!,
            ),
          );
        },
        child: Container(
          height: 160,
          width: 220,
          color: Colors.white,
          child: Card(
            elevation: 10,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(
                    model.image!,
                    height: 70,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    model.title!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.teal),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('\$${model.price}'),
                      const Icon(Icons.favorite_border),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
