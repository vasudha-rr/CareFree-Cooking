import 'package:careless_cooking/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  final CollectionReference menu =
      FirebaseFirestore.instance.collection('menu');

  final CollectionReference addRecipe =
      FirebaseFirestore.instance.collection('menu');
  final TextEditingController _recipeController = TextEditingController();

  final TextEditingController _nameController1 = TextEditingController();
  final TextEditingController _quantityController1 = TextEditingController();

  final TextEditingController _nameController2 = TextEditingController();
  final TextEditingController _quantityController2 = TextEditingController();

  final TextEditingController _nameController3 = TextEditingController();
  final TextEditingController _quantityController3 = TextEditingController();

  Future<void> _display([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _recipeController.text = documentSnapshot.id;
      _nameController1.text = documentSnapshot['Ingredient 1'];
      _quantityController1.text = documentSnapshot['Quantity 1'];
      _nameController2.text = documentSnapshot['Ingredient 2'];
      _quantityController2.text = documentSnapshot['Quantity 2'];
      _nameController3.text = documentSnapshot['Ingredient 3'];
      _quantityController3.text = documentSnapshot['Quantity 3'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _recipeController,
                        decoration:
                            const InputDecoration(labelText: 'Recipe Name'),
                      ),
                      TextField(
                        controller: _nameController1,
                        decoration:
                            const InputDecoration(labelText: 'Ingredient 1'),
                      ),
                      TextField(
                        controller: _quantityController1,
                        decoration:
                            const InputDecoration(labelText: 'Quantity 1'),
                      ),
                      TextField(
                        controller: _nameController2,
                        decoration:
                            const InputDecoration(labelText: 'Ingredient 2'),
                      ),
                      TextField(
                        controller: _quantityController2,
                        decoration:
                            const InputDecoration(labelText: 'Quantity 2'),
                      ),
                      TextField(
                        controller: _nameController3,
                        decoration:
                            const InputDecoration(labelText: 'Ingredient 3'),
                      ),
                      TextField(
                        controller: _quantityController3,
                        decoration:
                            const InputDecoration(labelText: 'Quantity 3'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: const Text('Update'),
                        onPressed: () async {
                          final String recipeName = _recipeController.text;
                          final String name1 = _nameController1.text;
                          final String name2 = _nameController2.text;
                          final String name3 = _nameController3.text;
                          final String quantity1 = _quantityController1.text;
                          final String quantity2 = _quantityController2.text;
                          final String quantity3 = _quantityController3.text;
                          if (name1.isNotEmpty && quantity1.isNotEmpty) {
                            await menu.doc(recipeName).update({
                              "Ingredient 1": name1,
                              "Quantity 1": quantity1
                            });
                          }

                          if (name2.isNotEmpty && quantity2.isNotEmpty) {
                            await menu.doc(recipeName).update({
                              "Ingredient 2": name2,
                              "Quantity 2": quantity2,
                            });
                          }
                          if (name3.isNotEmpty && quantity3.isNotEmpty) {
                            await menu.doc(recipeName).update({
                              "Ingredient 3": name3,
                              "Quantity 3": quantity3
                            });
                          }

                          _nameController1.text = '';
                          _quantityController1.text = '';
                          _nameController2.text = '';
                          _quantityController2.text = '';
                          _nameController3.text = '';
                          _quantityController3.text = '';
                          Navigator.of(context).pop();
                        },
                      ),
                      addHorizontalSpace(230),
                      IconButton(
                          iconSize: 40,
                          icon: const Icon(Icons.check_circle_outline_outlined),
                          color: Colors.grey,
                          onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
        backgroundColor: green,
      ),
      body: StreamBuilder(
        stream: menu.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: lightPink,
                        ),
                        child: ListTile(
                          title: Text(documentSnapshot.id),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(children: [
                              IconButton(
                                  icon: const Icon(Icons.menu_open),
                                  onPressed: () => _display(documentSnapshot)),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
