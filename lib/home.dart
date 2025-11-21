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
                  for (var e in items) {
                    e.selected = false;
                  }
                  _showSelected = false;
                });
              },
              icon: const Icon(
                Icons.restore,
              ),
            )),
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
      body: _showSelected
          ? ShowSelectedItems(width: screenWidth, category: _selectedCategory):
      Column(
          children: [
          const SizedBox(height: 20),


      DropdownButton<String>(
        value: _selectedCategory,
        items: ['All', 'Phone', 'Laptop']
            .map((cat) => DropdownMenuItem(
          value: cat,
          child: Text(cat),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) updateCategory(value);
        },
      ),

      const SizedBox(height: 20),
      Expanded(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            if (_selectedCategory != 'All' &&
                item.category != _selectedCategory) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.24),
                    Checkbox(
                      value: item.selected,
                      onChanged: (e) {
                        setState(() {
                          item.selected = e ?? false;

                          if (item.selected) {
                            _sum += item.price;
                          } else {
                            _sum -= item.price;
                          }
                        });
                      },
                    ),
                    Text(item.toString()),
                  ],
                ),
                Image.network(item.image, height: screenWidth * 0.3),
              ],
            );
          },
        ),
      ),

            const SizedBox(height: 10),

            Text(
              'Total Price: \$$_sum',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
      ),

    );



  }
}
