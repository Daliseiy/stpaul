import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';

import '../../responsive.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _scaffoldKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff001242),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          onPressed: () {
                            if (_scaffoldKey.currentState!.isDrawerOpen) {
                              _scaffoldKey.currentState!.openEndDrawer();
                            } else {
                              _scaffoldKey.currentState!.openDrawer();
                            }
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          iconSize: 32,
                        ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: NavBar(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Text(
                    'Projects',
                    textAlign: TextAlign.center,
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white)
                        : Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                ],
              ),
            ),
            if (!Responsive.isDesktop(context))
              Column(children: [
                MobileProjectBodyCard(
                  title: 'this is the heading text',
                  imgPath: 'assets/images/event2.jpg',
                  bodyText:
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam iste ducimus assumenda facere, dolor beatae unde qui! Temporibus, esse sit voluptas labore doloribus error, aut explicabo iusto alias, fuga cumque.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta, praesentium numquam. Fugit, magnam harum quod quaerat soluta deleniti non ab optio sunt temporibus recusandae illum ea quasi repellat eligendi cupiditate.',
                ),
                MobileProjectBodyCard(
                  title: 'this is the heading text',
                  imgPath: 'assets/images/event3.jpg',
                  bodyText:
                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam iste ducimus assumenda facere, dolor beatae unde qui! Temporibus, esse sit voluptas labore doloribus error, aut explicabo iusto alias, fuga cumque.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta, praesentium numquam. Fugit, magnam harum quod quaerat soluta deleniti non ab optio sunt temporibus recusandae illum ea quasi repellat eligendi cupiditate.',
                )
              ]),
            Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ProjectBodyCard(
                            title: 'this is the heading text',
                            imgPath: 'assets/images/event2.jpg',
                            bodyText:
                                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam iste ducimus assumenda facere, dolor beatae unde qui! Temporibus, esse sit voluptas labore doloribus error, aut explicabo iusto alias, fuga cumque.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta, praesentium numquam. Fugit, magnam harum quod quaerat soluta deleniti non ab optio sunt temporibus recusandae illum ea quasi repellat eligendi cupiditate.',
                          ),
                          ProjectBodyCard(
                            title: 'this is the heading text',
                            imgPath: 'assets/images/event3.jpg',
                            bodyText:
                                'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam iste ducimus assumenda facere, dolor beatae unde qui! Temporibus, esse sit voluptas labore doloribus error, aut explicabo iusto alias, fuga cumque.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dicta, praesentium numquam. Fugit, magnam harum quod quaerat soluta deleniti non ab optio sunt temporibus recusandae illum ea quasi repellat eligendi cupiditate.',
                          )
                        ],
                      ),
                    ),
                  Expanded(
                    flex: 1,
                    child: GiveForm(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GiveForm extends StatefulWidget {
  GiveForm({
    Key? key,
  }) : super(key: key);

  @override
  State<GiveForm> createState() => _GiveFormState();
}

class _GiveFormState extends State<GiveForm> {
  String? fullName = '';
  String? phoneNumber;
  String? addresss = '';
  String message = '';
  int amount = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    final charge = Charge()
      ..email = 'test@mail.com'
      ..amount = amount * 100
      ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';
    final res = await PaystackClient.checkout(context, charge: charge);
  }

  @override
  void initState() {
    // TODO: implement initState
    PaystackClient.initialize(
        'pk_test_f7b51ce3e2f0bf654174f18266e2ee65222f466e');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Color(0xff001242),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.all(defaultPadding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                'Give to the Lord and experience abundance!!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Color(0xff001242)),
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      letterSpacing: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xff001242),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Color(0xff001242), width: 0.7),
                  ),
                ),
                onSaved: (newValue) => fullName = newValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      letterSpacing: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xff001242),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Color(0xff001242), width: 0.7),
                  ),
                ),
                onSaved: (newValue) => phoneNumber = newValue,
                validator: (value) {
                  bool isInt = int.tryParse(value as String) == null;
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  if (isInt) {
                    return 'Enter a number';
                  }
                  if (value.length < 11 || value.length > 12) {
                    return 'This number is not valid';
                  }
                },
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: 'Enter amount',
                  labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      letterSpacing: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xff001242),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Color(0xff001242), width: 0.7),
                  ),
                ),
                onSaved: (newValue) {
                  setState(() {
                    amount = int.parse(newValue!);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                },
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            MaterialButton(
              onPressed: () => _submitForm(),
              color: Color(0xff001242),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                child: Text('GIVE',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1)),
              ),
            ),
            SizedBox(
              height: defaultPadding,
            )
          ],
        ),
      ),
    );
  }
}

class ProjectBodyCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String bodyText;
  ProjectBodyCard({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(defaultPadding),
      height: 400,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        )),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          imgPath,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: defaultPadding,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    bodyText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileProjectBodyCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String bodyText;
  MobileProjectBodyCard(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.bodyText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        margin: EdgeInsets.all(defaultPadding),
        child: Column(children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgPath), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              bodyText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
            ),
          )
        ]));
  }
}
