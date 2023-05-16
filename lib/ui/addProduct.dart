import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import "package:hello_flutter/colors.dart";
import 'package:hello_flutter/data/model/product.dart';
import 'package:hello_flutter/data/repository/product_repo_impl.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final repo = ProductRepoImpl();

  String _title = "";
  String _brand = "";
  String _category = "";
  String _description = "";
  double _price = 0.0;
  double _discountPercentage = 0.0;
  double _rating = 0.0;
  int _stock = 0;

  void onChange(String fieldName, dynamic value) {
    setState(() {
      switch (fieldName) {
        case 'title':
          _title = value;
          break;
        case 'brand':
          _brand = value;
          break;
        case 'category':
          _category = value;
          break;
        case 'description':
          _description = value;
          break;
        case 'price':
          _price = value;
          break;
        case 'discountPercentage':
          _discountPercentage = value;
          break;
        case 'rating':
          _rating = value;
          break;
        case 'stock':
          _stock = value;
          break;
        default:
          throw Exception('Invalid field name: $fieldName');
      }
    });
  }

  List fields = [
    "title",
    "brand",
    "category",
    "description",
    "price",
    "discountPercentage",
    "rating",
    "stock"
  ];

  Future _addProduct(product) async {
    return await repo.insertItem(product);
  }

  void _addBtnOnClick(BuildContext context) {
    Product product = Product(
        id: null,
        title: _title,
        brand: _brand,
        category: _category,
        description: _description,
        price: _price,
        discountPercentage: _discountPercentage,
        rating: _rating,
        stock: _stock,
        thumbnail: null);
    _addProduct(product);

    context.pop("true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
          backgroundColor: pink,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: fields.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10.0),
                    itemBuilder: (context, index) {
                      return inputOptions(fields[index]);
                    })),
            ElevatedButton(
                onPressed: () {
                  _addBtnOnClick(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: pink),
                child: const Text("Add"))
          ],
        ));
  }

  TextField inputOptions(String field) {
    return TextField(
      keyboardType: field == "category" ||
              field == "price" ||
              field == "discountPercentage" ||
              field == "rating" ||
              field == "stock"
          ? TextInputType.number
          : TextInputType.text,
      onChanged: (value) => onChange(field, value),
      decoration: InputDecoration(
        hintText: field,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: pink),
            borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
