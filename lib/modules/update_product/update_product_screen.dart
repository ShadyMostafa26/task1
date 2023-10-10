import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/shared/cubit/cubit.dart';
import 'package:store_app/shared/cubit/states.dart';

class UpdateProductScreen extends StatelessWidget {
  final int? id;
  final String? image;
  final String? category;

  UpdateProductScreen({Key? key, required this.id, this.image,required this.category}) : super(key: key);

  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final productPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Update Product '),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: productName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Product Name',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: productDescription,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Product description',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: productPrice,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Product price',
                    ),
                  ),
                  const SizedBox(height: 30),
                  (state is UpdateProductLoadingState)? LinearProgressIndicator() :  ElevatedButton(
                    onPressed: () {
                      AppCubit.get(context).updateProduct(
                        id: id!,
                        price: num.parse(productPrice.text),
                        description: productDescription.text,
                        image: image!,
                        title: productName.text,
                        category: category!,
                      );
                    },
                    child: const Text('Update Product'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
