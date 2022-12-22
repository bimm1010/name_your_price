import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Products {
  final String name;
  final int price;

  Products(this.name, this.price);
}

final products = [
  Products('Meat', 5000),
  Products('Vegetable', 15000),
  Products('Food', 9000),
  Products('Salt', 50000),
  Products('Water', 25000),
  Products('Milk', 8000),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  int _getPrice = 0;
  bool? _result;
  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            Text(products[_currentIndex].name),
            const Padding(padding: EdgeInsets.only(top: 30)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  hintText: 'enter your price',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _getPrice = int.tryParse(myController.text)!;
                    if (_getPrice == products[_currentIndex].price) {
                      _result = true;
                    } else {
                      _result = false;
                    }
                  });
                },
                child: const Text('Check')),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _result == true //check _result must true
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_currentIndex <= products.length) {
                          _currentIndex++;
                          print(_currentIndex);
                          if (_currentIndex == products.length) {
                            _currentIndex = 0;
                          }
                        }
                        _result = null;
                      });
                      myController.clear();
                    },
                    child: const Text('Next'))
                : const Text(''),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _result == null //check _result before show result
                ? const Text(
                    "Kết quả",
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  )
                : Text(
                    '$_result',
                    style: const TextStyle(fontSize: 30, color: Colors.red),
                  )
          ],
        ),
      ),
    );
  }
}
