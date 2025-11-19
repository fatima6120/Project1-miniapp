import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _sum = 0;
  bool _showSelected = false;

  @override
  Widget build(BuildContext context) {
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
