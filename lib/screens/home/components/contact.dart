import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)
                ? defaultPadding * 8
                : defaultPadding,
            vertical: defaultPadding),
        color: Color(0xff001242),
        width: double.infinity,
        child: Responsive.isDesktop(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        'We will love to hear from your. Fill the form and get a response in 24 hours',
                        style: TextStyle(
                            color: Colors.white, fontSize: defaultPadding),
                      ),
                      SizedBox(
                        height: defaultPadding * 2,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.call_end_rounded),
                        label: Text('+234 808 8929 3824',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.mail_rounded),
                        label: Text('stpaul@gmail.com',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.location_on),
                        label: Text('Odo-Ona Ibadan NIgeria',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Card(
                    margin: EdgeInsets.all(defaultPadding),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: ContactForm(),
                    ),
                  ))
                ],
              )
            : Column(
                children: [
                  Text(
                    'Contact Us',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'We will love to hear from your. Fill the form and get a response in 24 hours',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: defaultPadding),
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call_end_rounded),
                    label: Text('+234 808 8929 3824',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.mail_rounded),
                    label: Text('stpaul@gmail.com',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.location_on),
                    label: Text('Odo-Ona Ibadan NIgeria',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Card(
                    margin: EdgeInsets.all(defaultPadding),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: ContactForm(),
                    ),
                  ),
                ],
              ));
  }
}

class ContactForm extends StatefulWidget {
  ContactForm({
    Key? key,
  }) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? message;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.save();
    Provider.of<DataProvider>(context, listen: false)
        .addContact(fullName, phoneNumber, email, message)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          backgroundColor: Color(0xff001242),
          message: "Your message has being recieved. We'll get back to you.",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.montserrat(
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
              ))
            ],
          ),
          SizedBox(height: defaultPadding + 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: GoogleFonts.montserrat(
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
                  if (value.length < 11 || value.length > 12) {
                    return 'This number is not valid';
                  }
                  if (isInt) {
                    return 'Enter a valid phone number';
                  }
                },
              ))
            ],
          ),
          SizedBox(height: defaultPadding + 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: TextFormField(
                style: TextStyle(fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: GoogleFonts.montserrat(
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
                onSaved: (newValue) => email = newValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  } else if (!emailValidatorRegExp.hasMatch(value)) {
                    return 'Enter a valid email address.';
                  }
                  return null;
                },
              ))
            ],
          ),
          SizedBox(height: defaultPadding + 4),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                maxLines: 3,
                style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  labelText: 'MESSAGE',
                  labelStyle: GoogleFonts.montserrat(
                      color: Colors.black.withOpacity(0.6),
                      letterSpacing: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff001242),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff001242), width: 0.7),
                  ),
                ),
                onSaved: (newValue) => message = newValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                },
              ))
            ],
          ),
          SizedBox(height: 30),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff001242),
                  ),
                )
              : Responsive.isDesktop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () => _submitForm(),
                          color: Color(0xff001242),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70, vertical: 16),
                            child: Text('SUBMIT',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: defaultPadding,
                        ),
                        FittedBox(
                          child: MaterialButton(
                            onPressed: () => _submitForm(),
                            color: Color(0xff001242),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 16),
                              child: Text('SUBMIT',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
