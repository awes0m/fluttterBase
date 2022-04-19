import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../net/api_methods.dart';
import '../net/flutterfire.dart';
import '../util_constants.dart';
import 'add_coin_screen.dart';

class HomeScreen extends StatefulWidget {
  static var routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('ethereum');
    tether = await getPrice('tether');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else {
        return 0.0;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Your Wallet'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        leading: const Icon(Icons.account_balance_wallet),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddCoinScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: ScrnSizer.screenWidth(context),
        height: ScrnSizer.screenHeight(context),
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //In case its trying to read data or if there is no data or error in reading data it displays a CircularProgressIndicator
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<dynamic> document) {
                    return Container(
                      width: ScrnSizer.screenWidth(context) / 1.2,
                      height: ScrnSizer.screenHeight(context) / 11,
                      margin: EdgeInsets.symmetric(
                          horizontal: ScrnSizer.screenWidth(context) * 0.05,
                          vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text(
                          'Coin Name: ${document.id}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '\$${(getValue(document.id, document.data()['Amount']).toStringAsFixed(2))}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await removeCoin(document.id);
                            }),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddCoinScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
