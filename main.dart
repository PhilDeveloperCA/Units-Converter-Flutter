import 'package:flutter/material.dart';
import './util/Unit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String searchTerm = '';
  List<Map<String, dynamic>> searchResults = [];
  List<Unit> toCalculate;

  Function submit() {
    if (searchTerm != null && searchTerm != '') {
      setState(() {
        searchResults = Unit.UnitSearch(searchTerm);
      });
    }
  }

  Function select() {}

  Function LeftSide() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit App Demo'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                Text('Search Term'),
                TextFormField(
                  onChanged: (value) => setState(() => searchTerm = value),
                ),
                FloatingActionButton(
                  onPressed: submit,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Column(
            children: searchResults
                .map<Widget>(
                  (unit) => Row(
                    children: [
                      Text(unit['name']),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
