import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stpaulanglicanchurh/constant.dart';

class Footer extends StatelessWidget {
  Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff001242),
      width: double.infinity,
      padding: EdgeInsets.all(defaultPadding),
      child: Text(
        'St Paul Anglican Church 2022',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
