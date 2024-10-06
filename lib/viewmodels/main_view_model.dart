import 'package:flutter/material.dart';
import 'package:learn_wise/data/models/item_model.dart';

class MainViewModel extends ChangeNotifier {
  List<ItemModel> _items = [
    ItemModel(title: 'Item 1', category: 'Category 1', imageUrl: ''),
    ItemModel(title: 'Item 2', category: 'Category 2', imageUrl: ''),
    // Diğer öğeler
  ];

  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;

  List<ItemModel> get filteredItems {
    if (_selectedFilter == 'All') {
      return _items;
    }
    return _items.where((item) => item.category == _selectedFilter).toList();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      notifyListeners();
      return;
    }
    _items = _items
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
