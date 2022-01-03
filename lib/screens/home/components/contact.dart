import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stpaulanglicanchurh/constant.dart';

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

class IInputForm extends StatelessWidget {
  final String title;
  bool isRequired = false;
  IInputForm({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: TextField(
          style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: title,
            labelStyle: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.6),
                letterSpacing: 1.5,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            suffixIcon: isRequired
                ? Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 10,
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.6), width: 0.7),
            ),
          ),
        ))
      ],
    );
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          IInputForm(
            title: 'NAME',
            isRequired: true,
          ),
          SizedBox(height: defaultPadding + 4),
          IInputForm(
            title: 'PHONE',
            isRequired: true,
          ),
          SizedBox(height: defaultPadding + 4),
          IInputForm(
            title: 'EMAIL',
          ),
          SizedBox(height: defaultPadding + 4),
          Row(
            children: [
              Expanded(
                  child: TextField(
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
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.6), width: 0.7),
                  ),
                ),
              ))
            ],
          ),
          SizedBox(height: 30),
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Color(0xff001242),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 16),
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
                        onPressed: () {},
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
