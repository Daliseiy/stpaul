import 'package:flutter/material.dart';
import 'package:stpaulanglicanchurh/constant.dart';

class BurialForm extends StatefulWidget {
  BurialForm({Key? key}) : super(key: key);

  @override
  _BurialFormState createState() => _BurialFormState();
}

class _BurialFormState extends State<BurialForm> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001242),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 700,
                child: Card(
                  child: SingleChildScrollView(
                      child: Container(
                    height: 600,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                            child: FormData(
                          pagecontroller: _pageController,
                        )),
                        Container(child: FormDataB()),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormData extends StatefulWidget {
  final PageController pagecontroller;
  FormData({Key? key, required this.pagecontroller}) : super(key: key);

  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _formKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();

  final _lastNameTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    widget.pagecontroller
        .animateToPage(1, duration: kDefaultDuration, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'Full name of deceased'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                bool isInt = int.tryParse(value as String) == null;

                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                if (isInt) {
                  return 'Enter a number';
                }
                return null;
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(defaultPadding * 0.4),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select Date of Birth - ')),
                  Text(
                    '${dateFormat.format(selectedDate)}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'Home Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'Business Address(if any)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  value = 'None';
                  return null;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: InputDecoration(hintText: 'State of Origin'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Center(
            child: MaterialButton(
              onPressed: () => _submitForm(),
              color: Color(0xff1d3557),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormDataB extends StatefulWidget {
  FormDataB({Key? key}) : super(key: key);

  @override
  _FormDataBState createState() => _FormDataBState();
}

class _FormDataBState extends State<FormDataB> {
  DateTime baptismDate = DateTime.now();

  var baptismPlace = TextEditingController();

  DateTime confirmationDate = DateTime.now();

  var confirmationPlace = TextEditingController();

  DateTime marriageDate = DateTime.now();

  var partnerName = TextEditingController();

  DateTime dateOfDeath = DateTime.now();

  DateTime burialDate = DateTime.now();

  DateTime wakeWeepDate = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      return picked;
    }
    throw () {};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () => _selectDate(
                                context,
                              ),
                          child: Text('Select Date of Baptism - ')),
                      Text(
                        '${dateFormat.format(baptismDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Container(
                    child: TextFormField(
                      controller: baptismPlace,
                      decoration: InputDecoration(hintText: 'Place of Baptism'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          /*Confirmation */
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              confirmationDate = pickedD;
                            });
                            ;
                          },
                          child: Text('Select Date of Confirmation - ')),
                      Text(
                        '${dateFormat.format(confirmationDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Container(
                    child: TextFormField(
                      controller: confirmationPlace,
                      decoration:
                          InputDecoration(hintText: 'Place of Confirmation'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          /* Spouse informations*/
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              marriageDate = pickedD;
                            });
                            ;
                          },
                          child: Text('Select Date of Marriage - ')),
                      Text(
                        '${dateFormat.format(marriageDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Container(
                    child: TextFormField(
                      controller: partnerName,
                      decoration:
                          InputDecoration(hintText: 'Name of Spouse (if any)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          value = '';
                          return null;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          /* Date of Death*/
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              dateOfDeath = pickedD;
                            });
                            ;
                          },
                          child: Text('Select Date of Death - ')),
                      Text(
                        '${dateFormat.format(dateOfDeath)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              wakeWeepDate = pickedD;
                            });
                            ;
                          },
                          child: Text('Date of Wake Weeping (if any) - ')),
                      Text(
                        '${dateFormat.format(wakeWeepDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
            ],
          ),

          /* burial inf0 */
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding * 0.4),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              burialDate = pickedD;
                            });
                            ;
                          },
                          child: Text('Select Date of Burial - ')),
                      Text(
                        '${dateFormat.format(burialDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Container(
                    child: TextFormField(
                      controller: partnerName,
                      decoration: InputDecoration(
                          hintText:
                              'Do you require the service of choir or organ (yes/no)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          value = '';
                          return null;
                        }
                        return null;
                      },
                    ),
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

class FinalForm extends StatefulWidget {
  FinalForm({Key? key}) : super(key: key);

  @override
  _FinalFormState createState() => _FinalFormState();
}

class _FinalFormState extends State<FinalForm> {
  final churchSociety = TextEditingController();
  final churchActivity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: churchSociety,
              decoration: InputDecoration(hintText: 'Society in church'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              controller: churchActivity,
              decoration: InputDecoration(hintText: 'Church Activities'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
