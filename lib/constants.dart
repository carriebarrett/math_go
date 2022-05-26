import 'package:flutter/material.dart';

import 'models/beastie_model.dart';

const String appTitle = 'Math GO!';

const String logoImage =
    'assets/images/logos_and_icons/logoshrink-removebg.png';

const logoColor = Color.fromRGBO(255, 99, 71, 1);

final sampleBeastie = Beastie(
    beastieID: 1,
    name: 'blob1',
    imagePath: './assets/images/beasties/leaf7.png',
    type: 'Blob',
    question: '2 + 2',
    answer: 4);

enum BattleResult { captured, lost, fledBattle }
