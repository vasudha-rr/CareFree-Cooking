import 'package:careless_cooking/menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const lighterPink = Color.fromARGB(255, 229, 194, 233);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Inventory());
}

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Inventory',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Inventory'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String name ='';
  String amount = '';

  final CollectionReference inventory = FirebaseFirestore.instance.collection('inventory');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(); 

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot !=null)
    {
        _nameController.text = documentSnapshot['name'];
    _amountController.text = documentSnapshot['amount'];
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
          bottom: MediaQuery.of(ctx).viewInsets.bottom+20),
        child: Column(
          mainAxisSize:MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'amount'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () async {
                final String name = _nameController.text;
                final String amount = _amountController.text;
                if (amount !=null) {
                  await inventory
                  .doc(documentSnapshot!.id)
                  .update({"name": name, "amount": amount});
                  _nameController.text='';
                  _amountController.text='';
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),

        );
        
    });
  }

  
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {

    if (documentSnapshot !=null)
    {
        _nameController.text = documentSnapshot['name'];
    _amountController.text = documentSnapshot['amount'];
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
          bottom: MediaQuery.of(ctx).viewInsets.bottom+20),
        child: Column(
          mainAxisSize:MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                final String name = _nameController.text;
                final String amount = _amountController.text;
                if (amount !=null) {
                  await inventory
                  .add({"name": name, "amount": amount});
                  _nameController.text='';
                  _amountController.text='';
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),

        );
        
    });
  }

  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: inventory.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = 
                snapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  color: lighterPink,
                  child: ListTile(

                    title: Text(documentSnapshot['name']),
                    subtitle : Text(documentSnapshot['amount']),
                    trailing: SizedBox(
                      width: 100,
                    
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:() =>
                              _update(documentSnapshot)
                              ),
                        ]),
                    ),

                  ), 
                ); 
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        )
      ,
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
