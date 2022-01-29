import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';

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
  bool _isLoading = false;

  Future showTestimonyDialog() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (ctx, setState) {
            return AlertDialog(
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
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Color(0xff001242))
                              : Theme.of(context)
                                  .textTheme
                                  .headline4!
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
                            bool isInt = int.tryParse(value as String) == null;

                            if (value.isEmpty) {
                              return 'This field is required';
                            }
                            if (value.length < 11 || value.length > 12) {
                              return 'This number is not valid';
                            }
                            if (isInt) {
                              return 'Enter a valid phone number';
                            }
                          },
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        TextFormField(
                          initialValue: testimony,
                          maxLines: 3,
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
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff001242),
                                ),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  final isValid =
                                      _formKey.currentState!.validate();
                                  if (!isValid) {
                                    return;
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                  }
                                  _formKey.currentState!.save();

                                  await Provider.of<DataProvider>(context,
                                          listen: false)
                                      .addTestimony(
                                          fullName, phoneNumber, testimony)
                                      .then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        backgroundColor: Color(0xff001242),
                                        message:
                                            "Your testimony has being recieved. Thank you.",
                                      ),
                                    );
                                  });
                                },
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
            );
          });
        });
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
            SizedBox(
              height: defaultPadding * 2,
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
      height: 400,
      width: 400,
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
            'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Et voluptatem doloribus recusandae quia ut molestiae numquam ab voluptas, nobis fugiat, in, ea aliquid! Incidunt dicta ducimus repudiandae architecto cumque dolor.',
            style: TextStyle(
              color: kTextColor,
              fontSize: defaultPadding,
            ),
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
