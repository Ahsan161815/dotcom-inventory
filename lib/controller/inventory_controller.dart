import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/item_model.dart';

class Inventory with ChangeNotifier {
  List<Item> _items = [];
  List<Item> get items => _items;
  int qty = 0;
  late Box box;

  Inventory() {
    loadItems();
  }

  Future<void> loadItems() async {
    box = await Hive.openBox('items');
    await getItems();
    notifyListeners();
  }

  addItem(
    String name,
    int qty,
  ) async {
    if (!box.containsKey(name)) {
      Item item = Item(name: name, qty: qty);
      await box.put(name, item);
      _items.add(item);
      calculateQty();
      notifyListeners();
    } else {
      log('Item Already Exists');
    }
  }

  Future<List<Item>> getItems() async {
    List<Item> items = List<Item>.from(box.values);
    _items = items;
    calculateQty();
    notifyListeners();
    return items;
  }

  deleteItem(int index, String key) async {
    await box.delete(key);
    _items.removeAt(index);
    calculateQty();
    notifyListeners();
  }

  editItem({required index, required String key, required int num}) async {
    if (num != null) {
      Item bg = await box.get(key);
      await box.put(key, Item(name: bg.name, qty: num));
      _items[index] = Item(name: bg.name, qty: num);
      calculateQty();
      notifyListeners();
    }
  }

  cleardata() async {
    await box.clear();
    _items = [];
    calculateQty();
    notifyListeners();
  }

  calculateQty() {
    qty = 0;
    _items.forEach((item) {
      qty += item.qty;
    });
    notifyListeners();
  }
}
