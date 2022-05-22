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

const double longitudeRange = 0.00085;
const double latitudeRange = 0.00088;
const double horizAvatarPad = .00015;
const double vertAvatarPad = .00032;
