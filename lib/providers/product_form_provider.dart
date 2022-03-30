import 'package:app_plantilla/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;
  ProductFormProvider(this.product);

  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }

  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }
}
