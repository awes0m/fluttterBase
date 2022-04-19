import 'package:flutter/material.dart';
import 'package:flutter_base/util_constants.dart';

import '../net/flutterfire.dart';

class AddCoinScreen extends StatefulWidget {
  static var routeName = '/add_coin';

  const AddCoinScreen({Key? key}) : super(key: key);

  @override
  State<AddCoinScreen> createState() => _AddCoinScreenState();
}

class _AddCoinScreenState extends State<AddCoinScreen> {
  List<String> coins = [
    'bitcoin',
    'tether',
    'ethereum',
  ];
  String dropdownValue = 'bitcoin';
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //dropdown for selecting coin
        DropdownButton(
          items: coins.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: dropdownValue,
          onChanged: (value) {
            setState(() {
              dropdownValue = value.toString();
            });
          },
        ),
        //Add amount
        Container(
          width: ScrnSizer.screenWidth(context) / 1.3,
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Coin Amount',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          width: ScrnSizer.screenWidth(context) / 1.4,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: MaterialButton(
            child: const Text('Add'),
            onPressed: () async {
              await addCoin(
                dropdownValue,
                _amountController.text,
              );
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          width: ScrnSizer.screenWidth(context) / 1.4,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: MaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    ));
  }
}
