import 'package:flutter/material.dart';
import 'Inventory.dart';
import 'addRecipe.dart';
import 'menu.dart';
import 'package:google_fonts/google_fonts.dart';


Widget addVerticalSpace(double height){
  return SizedBox(
    height:height
  );
}

const white = Color.fromARGB(255, 255, 255, 255);
const black = const Color(0xff212121);
const green = Color.fromARGB(255, 126, 191, 123);
const lightPink = Color.fromARGB(255, 207, 147, 204);


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: lightPink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            
            Text('CareFree Cooking',
            style: GoogleFonts.dancingScript(fontWeight: FontWeight.bold, fontSize: 55)),
             addVerticalSpace(100),

            inventory(context),
            addVerticalSpace(50),
            AddRecipe(context),
            addVerticalSpace(50),
            Menu(context),
          ],
        ),
      ),
    );
  }

  TextButton inventory(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(300), 
        minimumSize: Size(100,70),
        ),
      
      child: Text('Inventory',
      style: textTheme.headlineSmall!.apply(
                      color: white
                      ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Inventory()),
        );
      },
    );
  }

    TextButton Menu(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(300), 
        minimumSize: Size(100,70)
      ),
      child: Text('Menu',
      style: textTheme.headlineSmall!.apply(
                      color: white
                      ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const menu()),
        );
      },
    );
  }

  TextButton AddRecipe(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return TextButton(
      style: TextButton.styleFrom(
        primary: black,
        backgroundColor: green,
        fixedSize: const Size.fromWidth(300), 
        minimumSize: Size(100,70)
      ),
      child: Text('Add Recipe',
      style: textTheme.headlineSmall!.apply(
                      color: white
                      ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const addRecipe()),
        );
      },
    );
    
  }
}