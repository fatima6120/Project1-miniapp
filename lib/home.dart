import 'package:flutter/material.dart';
import 'store.dart';



class MyDropdownMenuWidget extends StatelessWidget {
  final Function(Store) updateItem;
  final Store selectedItem;

  const MyDropdownMenuWidget({
    required this.updateItem,
    required this.selectedItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Store>(
      value: selectedItem,
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item.name),
      ))
          .toList(),
      onChanged: (value) {
        if (value != null) updateItem(value);
      },

    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _sum = 0;
  bool _showSelected = false;
  String _selectedCategory = 'All';
  Store selectedItem = items.first;
  double totalPrice = 0;


  double calculateTotalPrice() {
    double sum = 0;
    for (var item in items) {
      if (item.selected) sum += item.price;
    }
    return sum;
  }

  void updateItem(Store item) {
    setState(() {
      selectedItem = item;
      totalPrice = calculateTotalPrice();
    });
  }

  void updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }
    List<Store> filteredItems = _selectedCategory == 'All'
        ? items
        : items.where((item) => item.category == _selectedCategory).toList();
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Minimal Store'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          Tooltip(
            message: 'Reset selection',
            child: IconButton(
              onPressed: () {
                setState(() {
                  _sum = 0;
                  // Reset your items here
                  _showSelected = false;
                });
              },
              icon: const Icon(Icons.restore),
            ),
          ),
          Tooltip(
            message: ' show cart',
            child: IconButton(
              onPressed: () {
                if (_sum != 0) {
                  setState(() {
                    _showSelected = !_showSelected;
                  });
                }
              },
              icon: const Icon(Icons.shopping_cart_checkout),
            ),
          ),
        ],
      ),
      body: const Center(

      ),
    );
  }
}
