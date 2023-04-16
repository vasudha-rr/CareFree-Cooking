import 'package:careless_cooking/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme defaultText = TextTheme(
  // ignore: deprecated_member_use
  headline3: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 5),
);


Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const addRecipe());
}

class addRecipe extends StatefulWidget {
  const addRecipe({Key? key}) : super(key: key);

  @override
  _addRecipeState createState() => _addRecipeState();
}

class _addRecipeState extends State<addRecipe> {
  final CollectionReference addRecipe =
      FirebaseFirestore.instance.collection('menu');
  final TextEditingController _recipeController = TextEditingController();

  final TextEditingController _nameController1 = TextEditingController();
  final TextEditingController _quantityController1 = TextEditingController();

  final TextEditingController _nameController2 = TextEditingController();
  final TextEditingController _quantityController2 = TextEditingController();

  final TextEditingController _nameController3 = TextEditingController();
  final TextEditingController _quantityController3 = TextEditingController();

  // final FocusNode _focusNode = FocusNode();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _focusNode.unfocus();
  // }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _recipeController.text = documentSnapshot.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
              child: Column(children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: lightPink,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            addHorizontalSpace(30),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  "Add Recipe",
                                  // ignore: deprecated_member_use
                                  style: GoogleFonts.dancingScript(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 55,
                                      color: white),
                                  // style: textTheme.headline3!.apply(
                                  //   color: white
                                  //   ),
                                )),
                          ],
                        ),
                        TextField(
                          controller: _recipeController,
                          decoration: InputDecoration(
                              hintText: "Enter Recipe Name:",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: white),
                        ),
                        // addVerticalSpace(500),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: constraints.maxHeight,
                color: white,
                height: 500,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                    ),
                    child: Stack(children: [
                      Column(children: [
                        addVerticalSpace(30),
                        TextField(
                            controller: _nameController1,
                            decoration: InputDecoration(
                                hintText: "Ingredient 1:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        addVerticalSpace(10),

                        TextField(
                            controller: _quantityController1,
                            decoration: InputDecoration(
                                hintText: "Quantity 1:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        addVerticalSpace(30),

                        TextField(
                            controller: _nameController2,
                            decoration: InputDecoration(
                                hintText: "Ingredient 2:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        addVerticalSpace(10),

                        TextField(
                            controller: _quantityController2,
                            decoration: InputDecoration(
                                hintText: "Quantity 2:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        addVerticalSpace(30),

                        TextField(
                            controller: _nameController3,
                            decoration: InputDecoration(
                                hintText: "Ingredient 3:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        addVerticalSpace(10),

                        TextField(
                            controller: _quantityController3,
                            decoration: InputDecoration(
                                hintText: "Quantity 3:",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: green)),
                        // addVerticalSpace(30),
                      ])
                    ]))),
            Container(
                width: constraints.maxHeight,
                color: white,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                    ),
                    child: Stack(children: [
                      Row(children: [
                        IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.add_circle_outline_outlined),
                            color: Colors.grey,
                            onPressed: () => ingredients()),
                        IconButton(
                            iconSize: 50,
                            icon:
                                const Icon(Icons.check_circle_outline_outlined),
                            color: Colors.grey,
                            onPressed: () async {
                              final String recipeName = _recipeController.text;
                              final String name1 = _nameController1.text;
                              final String name2 = _nameController2.text;
                              final String name3 = _nameController3.text;
                              final String quantity1 =
                                  _quantityController1.text;
                              final String quantity2 =
                                  _quantityController2.text;
                              final String quantity3 =
                                  _quantityController3.text;

                              await addRecipe.doc(recipeName).set({
                                "Ingredient 1": name1,
                                "Quantity 1": quantity1,
                                "Ingredient 2": name2,
                                "Quantity 2": quantity2,
                                "Ingredient 3": name3,
                                "Quantity 3": quantity3,
                              }, SetOptions(merge: true));

                              _nameController1.text = '';
                              _nameController2.text = '';
                              _nameController3.text = '';
                              _quantityController1.text = '';
                              _quantityController2.text = '';
                              _quantityController3.text = '';
                              Navigator.of(context).pop();
                            }),
                      ])
                    ])))
          ]));
        }),
      ),
    );
    // }
  }
}

Widget ingredients() {
  return TextField(
      decoration: InputDecoration(
          hintText: "Enter Ingredient Name:",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: green));
}
