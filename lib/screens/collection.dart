import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const routeName = 'collection';

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class CapturedBeastie {
  String name;
  String filename;
  String type;

  CapturedBeastie(
      {required this.name, required this.filename, required this.type});
}

// Collection list will be populated with info from database - temporarily hardcoded
// Someone please help come up with beastie and type names, I am terrible at it lol
class _CollectionScreenState extends State<CollectionScreen> {
  List<CapturedBeastie> beasties = [
    CapturedBeastie(
        name: 'Mowgli', filename: 'images/beasties/leaf7.png', type: 'Leaf'),
    CapturedBeastie(
        name: 'Apollo',
        filename: 'images/beasties/flower6.png',
        type: 'Flower'),
    CapturedBeastie(
        name: 'Arty', filename: 'images/beasties/blob10.png', type: 'Blob'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('./lib/assets/logoshrink-removebg.png', height: 40)
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 140,
              child: Image.asset('images/user.png'),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Beastie Collection',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SizedBox(
              height: 600,
              child: ListView.builder(
                  itemCount: beasties.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Image.asset(beasties[index].filename),
                            const SizedBox(width: 50),
                            Text(
                              beasties[index].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
