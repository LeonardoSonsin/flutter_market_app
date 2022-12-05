import 'package:flutter/material.dart';
import 'package:flutter_market_app/data/product_service.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key? key, required this.category}) : super(key: key);

  final String category;

  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New $category'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(hintText: 'Image url'),
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: _priceController,
                  decoration:
                      const InputDecoration(hintText: 'Price (Ex: 10.90)'),
                  validator: (String? value) {
                    if (valueValidator(value)) {
                      return 'Campo obrigatório!';
                    }
                    return null;
                  }),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ProductService()
                          .createProduct(
                        category: category,
                              image: _imageController.text,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              price: _priceController.text)
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  child: const Text('Confirm'))
            ],
          ),
        ),
      ),
    );
  }
}
