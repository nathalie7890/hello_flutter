import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/colors.dart';
import 'package:go_router/go_router.dart';
import '../data/model/product.dart';
import '../data/repository/product_repo_impl.dart';

class UpdateProduct extends StatefulWidget {
  final String id;
  const UpdateProduct({super.key, required this.id});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final repo = ProductRepoImpl();
  late Product product;

  @override
  void initState() {
    super.initState();
    _getProductById(widget.id);
  }

  Future _getProductById(String id) async {
    final res = await repo.getItemById(id);

    _title.text = res.title;
    _brand.text = res.brand;
    _category.text = res.category;
    _description.text = res.description;
    _price.text = res.price.toString();
    _discountPercentage.text = res.discountPercentage.toString();
    _rating.text = res.rating.toString();
    _stock.text = res.stock.toString();
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _brand = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _discountPercentage = TextEditingController();
  TextEditingController _rating = TextEditingController();
  TextEditingController _stock = TextEditingController();

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

  Future _updateProduct(String id, Product product) async {
    await repo.updateItem(id, product);
  }

  void _onSaveProduct() {
    double priceDouble = _convertToDouble(_price.text);
    double discountDouble = _convertToDouble(_discountPercentage.text);
    double ratingDouble = _convertToDouble(_rating.text);
    int stockInt = int.tryParse(_stock.text) ?? 0;

    Product product = Product(
        id: null,
        title: _title.text,
        brand: _brand.text,
        category: _category.text,
        description: _description.text,
        price: priceDouble,
        discountPercentage: discountDouble,
        rating: ratingDouble,
        stock: stockInt,
        thumbnail: null);
    _updateProduct(widget.id, product);

    context.pop("true");
  }

  double _convertToDouble(String field) {
    return double.tryParse(field) ?? 0.0;
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

  TextEditingController _getControllers(String field) {
    switch (field) {
      case "title":
        return _title;
      case "brand":
        return _brand;
      case "category":
        return _category;
      case "description":
        return _description;
      case "price":
        return _price;
      case "discountPercentage":
        return _discountPercentage;
      case "rating":
        return _rating;
      case "stock":
        return _stock;
      default:
        return TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Product"),
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
                      return inputOptions(
                        fields[index],
                      );
                    })),
            ElevatedButton(
                onPressed: () {
                  _onSaveProduct();
                },
                style: ElevatedButton.styleFrom(backgroundColor: pink),
                child: const Text("Save"))
          ],
        ));
  }

  TextField inputOptions(String field) {
    return TextField(
      controller: _getControllers(field),
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
