import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class TestimonySection extends StatefulWidget {
  TestimonySection({Key? key}) : super(key: key);

  @override
  _TestimonySectionState createState() => _TestimonySectionState();
}

class _TestimonySectionState extends State<TestimonySection> {
  String? fullName;
  String? phoneNumber;
  String? testimony;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future showTestimonyDialog() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                constraints: BoxConstraints(minHeight: 350, minWidth: 400),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Share Your \nTestimony!',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Color(0xff001242)),
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        TextFormField(
                          initialValue: fullName,
                          decoration: InputDecoration(
                            labelText: 'Full name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                          ),
                          onSaved: (newValue) => fullName = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        TextFormField(
                          initialValue: phoneNumber,
                          decoration: InputDecoration(
                            labelText: 'Your phone number',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                          ),
                          onSaved: (newValue) => phoneNumber = newValue,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        TextFormField(
                          initialValue: testimony,
                          decoration: InputDecoration(
                            labelText: 'Enter your testimony here',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff001242),
                              ),
                            ),
                          ),
                          onSaved: (newValue) => testimony = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Color(0xff001242),
                          child: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Text(
                              'Share Your Testimony',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1000),
      margin: EdgeInsets.symmetric(vertical: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Text('Testimonies',
              textAlign: TextAlign.center,
              style: Responsive.isDesktop(context)
                  ? Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.black)
                  : Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.black)),
          SizedBox(
            height: defaultPadding * 3,
          ),
          if (Responsive.isDesktop(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [TestimonyCard(), TestimonyCard()],
            ),
          if (Responsive.isDesktop(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [TestimonyCard(), TestimonyCard()],
            ),
          if (!Responsive.isDesktop(context))
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TestimonyCard(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                TestimonyCard(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                TestimonyCard(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                TestimonyCard()
              ],
            ),
          MaterialButton(
            onPressed: () => showTestimonyDialog(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: Color(0xff001242),
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                'Share Your Testimony',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TestimonyCard extends StatelessWidget {
  const TestimonyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      margin: EdgeInsets.all(defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [kDefaultShadow]),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(Responsive.isDesktop(context) ? -130 : -110, -80),
            child: Container(
              height: Responsive.isDesktop(context) ? 120 : 120,
              width: Responsive.isDesktop(context) ? 120 : 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage('assets/images/event1.jpg'))),
            ),
          ),
          Text(
            'this is a test',
            style: TextStyle(
                color: kTextColor, fontSize: defaultPadding + 2, height: 1.5),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Text(
            'Randall Hyde',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
