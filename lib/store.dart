import 'package:flutter/material.dart';

class Store {
  final String _name;
  final double _price;
  bool _selected = false;
  final String _image;
  final String category;

  Store(this._name, this._price, this._image, this.category);


  String get name => _name;
  double get price => _price;
  bool get selected => _selected;
  String get image => _image;
  set selected(bool e) => _selected = e;


  @override
  String toString() {
    String space = '';
    for (int i = 0; i < 3 - _price.toString().length; i++) {
      space += ' ';
    }
    return 'Price: \$$_price $space$_name';
  }
}


List<Store> items = [

  Store('iPhone 14', 300,
      'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      , 'Phone'),
  Store('Samsung Galaxy S23', 700,
      'https://images.unsplash.com/photo-1709744722656-9b850470293f?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ,'Phone'),
  Store('Google Pixel 8', 600,
      'https://images.unsplash.com/photo-1697355360151-2866de32ad4d?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      , 'Phone'),


  Store('MacBook Pro', 1999,
      'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1026&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ,'Laptop'),
  Store('Dell XPS 13', 1299,
      'https://images.unsplash.com/photo-1720556405438-d67f0f9ecd44?q=80&w=830&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ,'Laptop'),
  Store('HP Spectre x360', 1399,
      'https://images.unsplash.com/photo-1589561084283-930aa7b1ce50?q=80&w=1031&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
      ,'Laptop'),
];
class ShowSelectedItems extends StatelessWidget {
  const ShowSelectedItems({required this.width, required this.category, Key? key}) : super(key: key);

  final double width;
  final String category;

  @override
  Widget build(BuildContext context) {

    List<Store> selectedItems = items.where((e) {
      if (!e.selected) return false;
      if (category == 'All') return true;
      return e.category == category;
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: selectedItems.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(width: width * 0.28),
            Text(selectedItems[index].toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Image.network(selectedItems[index].image, height: width * 0.3),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
