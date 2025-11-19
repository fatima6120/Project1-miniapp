import 'package:flutter/material.dart';

class Store {
  final String _name;
  final double _price;
  bool _selected = false;
  final String _image;

  Store(this._name, this._price, this._image);


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

  Store('iPhone 14', 300, 'https://example.com/iphone.png'),
  Store('Samsung Galaxy S23', 700, 'https://example.com/galaxy.png'),
  Store('Google Pixel 8', 600, 'https://example.com/pixel.png'),


  Store('MacBook Pro', 1999, 'https://example.com/macbook.png'),
  Store('Dell XPS 13', 1299, 'https://example.com/dell.png'),
  Store('HP Spectre x360', 1399, 'https://example.com/hp.png'),
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
