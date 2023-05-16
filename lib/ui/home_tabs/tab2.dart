import 'package:flutter/material.dart';
import 'package:hello_flutter/data/repository/product_repo_impl.dart';
import "package:hello_flutter/colors.dart";
import '../../data/model/product.dart';
import 'package:go_router/go_router.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  final repo = ProductRepoImpl();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() {
    try {
      Future<List<Product>> productsFuture = repo.getProducts();

      productsFuture.then((List<Product> products2) {
        setState(() {
          _products = products2;
          debugPrint("Products: $_products.toString");
        });
      }).catchError((error) {
        throw Exception('An error occurred: $error');
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred: $error'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  _deleteProduct(String id) async {
    await repo.deleteItem(id);
    fetchProducts();
  }

  _goToAddProduct(BuildContext context) async {
    final res = await context.push("/addProduct");
    if (res == "true") {
      fetchProducts();
    }
  }

  _goToEditProduct(String id) async {
    final res = await context.push("/updateProduct/$id");
    if (res == "true") {
      fetchProducts();
    }
  }

  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text(
                  "The item will be deleted and the action cannot be undone."),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: pink),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes")),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.pinkAccent.shade100,
            width: double.infinity,
            child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Dismissible(
                      key: Key(product.id.toString()),
                      onDismissed: (dir) {
                        _deleteProduct(_products[index].id!);
                      },
                      secondaryBackground: Container(
                        color: Colors.green,
                      ),
                      confirmDismiss: (dir) async {
                        return _onConfirmDismiss(dir);
                      },
                      background: Container(
                        color: Colors.red.shade600,
                        child: const Center(
                          child: Text("Deleted"),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title: ${product.title}",
                              style: const TextStyle(color: pink, fontSize: 18),
                            ),
                            Text(
                              "Description: ${product.description}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            Text(
                              "Priority: ${product.brand}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _goToEditProduct(product.id!);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _goToAddProduct(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
