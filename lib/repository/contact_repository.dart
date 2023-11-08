import 'package:flutter/material.dart';

class ContactRepositoy extends ChangeNotifier {
  bool _isAdding = false;
  bool _isEditingContact = false;

  bool get isEditingContact => _isEditingContact;

  bool get isAdding => _isAdding;

  addContact({required VoidCallback isAddingFunc}) {
    _isAdding = true;
    isAddingFunc();

    _isAdding = false;

    notifyListeners();
  }

  isEditingFunc() {
    _isEditingContact = !_isEditingContact;

    notifyListeners();
  }
}
