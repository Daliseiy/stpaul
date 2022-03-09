import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';

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

  final ImagePicker _picker = ImagePicker();
  // Pick an image
  XFile? pickedImage;

  Future showTestimonyDialog() async {
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
                          height: defaultPadding * 1.5,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                          child: pickedImage == null
                              ? IconButton(
                                  onPressed: () async {
                                    final XFile? image = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      pickedImage = image;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.grey,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    pickedImage!.path,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        if (pickedImage != null)
                          TextButton(
                              onPressed: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  pickedImage = image;
                                });
                              },
                              child: Text('Change Image',
                                  style: TextStyle(color: Color(0xff001242)))),
                        SizedBox(
                          height: defaultPadding * 1.5,
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

                                  if (pickedImage == null) {
                                    await Provider.of<DataProvider>(context,
                                            listen: false)
                                        .addTestimony(
                                            fullName,
                                            phoneNumber,
                                            testimony,
                                            'https://res.cloudinary.com/daliseiy/image/upload/v1646820175/stpaul/Replace_Default_User_Account_Avatar_in_Windows_10_ckglyv.png')
                                        .then((_) {
                                      setState(() {
                                        _isLoading = false;
                                        fullName = '';
                                        phoneNumber = '';
                                        testimony = '';
                                        pickedImage = null;
                                      });
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          backgroundColor: Color(0xff001242),
                                          message:
                                              "Your testimony has being recieved. Thank you.",
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      CustomSnackBar.error(
                                        message:
                                            "Something went wrong. Please try again",
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    });
                                  } else {
                                    Reference firebaseStorageRef =
                                        FirebaseStorage.instance.ref().child(
                                            "image" +
                                                DateTime.now().toString());
                                    UploadTask uploadTask =
                                        firebaseStorageRef.putData(
                                            await pickedImage!.readAsBytes());
                                    TaskSnapshot taskSnapshot =
                                        await uploadTask;
                                    taskSnapshot.ref
                                        .getDownloadURL()
                                        .then((value) async {
                                      await Provider.of<DataProvider>(context,
                                              listen: false)
                                          .addTestimony(fullName, phoneNumber,
                                              testimony, value)
                                          .then((value) {
                                        setState(() {
                                          _isLoading = false;
                                          fullName = '';
                                          phoneNumber = '';
                                          testimony = '';
                                          pickedImage = null;
                                        });
                                        showTopSnackBar(
                                          context,
                                          CustomSnackBar.success(
                                            backgroundColor: Color(0xff001242),
                                            message:
                                                "Your testimony has being recieved. Thank you.",
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }).catchError((error) {
                                        CustomSnackBar.error(
                                          message:
                                              "Something went wrong. Please try again",
                                        );
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }).catchError((error) {
                                      CustomSnackBar.error(
                                        message:
                                            "Something went wrong. Please try again",
                                      );
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    });
                                  }
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
          FutureBuilder<List<Testimony>>(
            future: DataProvider()
                .fetchTestimonies(), // a previously-obtained Future<String> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<Testimony>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                List<Testimony>? data = snapshot.data;
                children = <Widget>[
                  Container(
                    height: 1050,
                    width: double.infinity,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: defaultPadding,
                            mainAxisSpacing: defaultPadding,
                            crossAxisCount:
                                Responsive.isDesktop(context) ? 2 : 1),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            TestimonyCard(testimony: data![index])),
                  ),
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
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
  final Testimony testimony;
  TestimonyCard({Key? key, required this.testimony}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transform.translate(
          //   offset: Offset(Responsive.isDesktop(context) ? -130 : -110, -80),
          //   child: Container(
          //     height: Responsive.isDesktop(context) ? 120 : 120,
          //     width: Responsive.isDesktop(context) ? 120 : 100,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(120),
          //         image: DecorationImage(
          //             image: AssetImage('assets/images/Testimony1.jpg'))),
          //   ),
          // ),
          Text(
            testimony.testimony,
            style: TextStyle(
              color: kTextColor,
              fontSize: defaultPadding,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          Text(
            testimony.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}


           // 'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Et voluptatem doloribus recusandae quia ut molestiae numquam ab voluptas, nobis fugiat, in, ea aliquid! Incidunt dicta ducimus repudiandae architecto cumque dolor.',
