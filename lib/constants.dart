import 'package:flutter/material.dart';

import 'models/beastie_model.dart';

const String appTitle = 'Math GO!';

const String logoImage =
    'assets/images/logos_and_icons/logoshrink-removebg.png';

const logoColor = Color.fromRGBO(255, 99, 71, 1);

final sampleBeastie = Beastie(
    beastieID: 1,
    question: '1+1',
    answer: '2',
    imagePath: 'assets/images/beasties/blob1.png',
    name: 'blob1',
    type: 'math');
