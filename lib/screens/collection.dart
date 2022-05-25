import 'package:flutter/material.dart';
import 'package:math_go/database/beastie_collection.dart';
import 'package:math_go/database/beasties.dart';

import '../constants.dart';
import '../models/beastie_collection_model.dart';
import '../models/beastie_model.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen(
      {Key? key, required this.title, required this.collectionId})
      : super(key: key);
  final String title;
  static const routeName = 'collection';
  final String collectionId;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

// Collection list will be populated with info from database - temporarily hardcoded
// Someone please help come up with beastie and type names, I am terrible at it lol
class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Image.asset(logoImage, height: 40)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 140,
              child: Image.asset('assets/images/user.png'),
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
              child: FutureBuilder(
                  future: BeastieCollectionsData().getCollections(),
                  builder: (context, AsyncSnapshot collectionsSnapshot) {
                    if (!collectionsSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final BeastieCollection _beastieCollection =
                        (collectionsSnapshot.data as List<BeastieCollection>)
                            .where((collection) =>
                                widget.collectionId ==
                                collection.beastieCollectionID)
                            .toList()[0];
                    return FutureBuilder(
                        future: BeastiesData().getBeasties(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          List<Beastie> allBeasties = snapshot.data;
                          List<Beastie> collectedBeasties = allBeasties
                              .where((beastie) => _beastieCollection.beastiesIds
                                  .contains(beastie.beastieID))
                              .toList();
                          return ListView.builder(
                              itemCount: collectedBeasties.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: SizedBox(
                                    height: 80,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 20),
                                        Image.asset(
                                            collectedBeasties[index].imagePath),
                                        const SizedBox(width: 50),
                                        Text(
                                          collectedBeasties[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
