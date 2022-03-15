import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/providers/auth_provider.dart';
import 'package:stpaulanglicanchurh/responsive.dart';
import 'package:stpaulanglicanchurh/screens/authentication/login.dart';
import 'package:stpaulanglicanchurh/screens/dashboard/links.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthProvider>(context).auth.currentUser == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      });
    } else {}

    return Scaffold(
      backgroundColor: Color(0xff001242),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Center(
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
                Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 1.4,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 600,
                  margin: EdgeInsets.all(defaultPadding),
                  constraints: BoxConstraints(maxWidth: 900),
                  child: GridView.count(
                    crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                    shrinkWrap: true,
                    children: List.generate(
                        links.length,
                        (index) => MenuBox(
                            text: links[index].text,
                            icon: links[index].icon,
                            color: links[index].color,
                            routes: links[index].routes)),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class MenuBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final String routes;
  MenuBox(
      {Key? key,
      required this.text,
      required this.icon,
      required this.color,
      required this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routes),
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.shade900.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(defaultPadding - 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: defaultPadding * 1.3,
                    fontWeight: FontWeight.w600)),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: CircularProgressIndicator(
                value: 0.6,
                color: color,
                backgroundColor: Colors.blue.shade900.withOpacity(0.2),
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
