import 'package:flutter/material.dart';

import '../../../constant.dart';

class BurialDataScreen extends StatefulWidget {
  const BurialDataScreen({Key? key}) : super(key: key);

  @override
  _BurialDataScreenState createState() => _BurialDataScreenState();
}

class _BurialDataScreenState extends State<BurialDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'St Paul\'s Anglican Church Admin',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: defaultPadding * 2,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: defaultPadding * 3,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Go Back to Dashboard',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: defaultPadding * 1.4,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
