import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/providers/burial_provider.dart';

class BurialForm extends StatefulWidget {
  BurialForm({Key? key}) : super(key: key);

  @override
  _BurialFormState createState() => _BurialFormState();
}

class _BurialFormState extends State<BurialForm> {
  final PageController _pageController = PageController();
  MenuController _controller = Get.put(
    MenuController(),
  );
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigationBar(color: Colors.white, controller: _controller),
              SizedBox(
                height: defaultPadding * 2,
              ),
              Center(
                child: SizedBox(
                  width: 700,
                  child: Card(
                    margin: EdgeInsets.all(defaultPadding),
                    child: SingleChildScrollView(
                        child: Container(
                      height: 600,
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                              child: SingleChildScrollView(
                            child: FormData(
                              pageController: _pageController,
                            ),
                          )),
                          Container(
                            child: SingleChildScrollView(
                              child: FormDataB(
                                pageController: _pageController,
                              ),
                            ),
                          ),
                          Container(
                              child: SingleChildScrollView(
                            child: FinalForm(
                              pageController: _pageController,
                            ),
                          )),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormData extends StatefulWidget {
  final PageController pageController;
  FormData({Key? key, required this.pageController}) : super(key: key);

  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _formKey = GlobalKey<FormState>();

  var _nameOfDeceased = '';

  var _age = '';
  var _homeAddress = '';
  var _businessAddress = '';
  var _stateOfOrigin = '';
  DateTime baptismDate = DateTime.now();

  var _baptismPlace = '';
  DateTime selectedDate = DateTime.now();

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

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<BurialProvider>(context, listen: false)
        .setFormDataA(_nameOfDeceased, _age, _homeAddress, _businessAddress,
            _stateOfOrigin, _baptismPlace, baptismDate, selectedDate)
        .then((value) => widget.pageController.animateToPage(1,
            duration: kDefaultDuration, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    print('This is has ben called ...................................');
    // TODO: implement didChangeDependencies
    Map initData = Provider.of<BurialProvider>(context).getFormData();
    setState(() {
      _nameOfDeceased =
          initData['nameOfDeceased'] == null ? '' : initData['age'];
      _age = initData['age'] == null ? '' : initData['age'];
      _nameOfDeceased = initData['homeAddress'] == null ? '' : initData['age'];
      _businessAddress =
          initData['businessAddress'] == null ? '' : initData['age'];
      _stateOfOrigin = initData['stateOfOrigin'] == null ? '' : initData['age'];
      _baptismPlace = initData['baptismPlace'] == null ? '' : initData['age'];
      baptismDate = initData['baptismDate'] = DateTime.now();
      selectedDate = initData['dateOfBirth'] = DateTime.now();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: defaultPadding),
              child: Text(
                '1 of 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1d3557),
                    fontSize: defaultPadding * 2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              initialValue: _nameOfDeceased,
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
              initialValue: _age,
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
              padding: EdgeInsets.all(defaultPadding),
              child: Wrap(
                children: [
                  TextButton(
                      onPressed: () async {
                        DateTime pickedD = await _selectDate(context);
                        setState(() {
                          selectedDate = pickedD;
                        });
                        ;
                      },
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
              initialValue: _homeAddress,
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
              initialValue: _businessAddress,
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
              initialValue: _stateOfOrigin,
              decoration: InputDecoration(hintText: 'State of Origin'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime pickedD = await _selectDate(context);
                            setState(() {
                              baptismDate = pickedD;
                            });
                            ;
                          },
                          child: Text('Select Date of Baptism - ')),
                      Text(
                        '${dateFormat.format(baptismDate)}',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  child: TextFormField(
                    initialValue: _baptismPlace,
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
            ],
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
          ),
          SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}

class FormDataB extends StatefulWidget {
  final PageController pageController;
  FormDataB({Key? key, required this.pageController}) : super(key: key);

  @override
  _FormDataBState createState() => _FormDataBState();
}

class _FormDataBState extends State<FormDataB> {
  DateTime confirmationDate = DateTime.now();

  var confirmationPlace = '';

  DateTime marriageDate = DateTime.now();

  var partnerName = '';

  DateTime dateOfDeath = DateTime.now();

  DateTime burialDate = DateTime.now();

  DateTime wakeWeepDate = DateTime.now();

  var society = '';

  var activity = '';

  var cultStatus = '';

  final _formKey = GlobalKey<FormState>();

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

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<BurialProvider>(context, listen: false)
        .setFormDataB(
            confirmationDate,
            confirmationPlace,
            marriageDate,
            partnerName,
            dateOfDeath,
            burialDate,
            wakeWeepDate,
            society,
            activity,
            cultStatus)
        .then((value) => widget.pageController.animateToPage(2,
            duration: kDefaultDuration, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: defaultPadding),
              child: Text(
                '2 of 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1d3557),
                    fontSize: defaultPadding * 2),
              ),
            ),
          ),
          /*Confirmation */
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
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
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  child: TextFormField(
                    initialValue: confirmationPlace,
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
            ],
          ),

          /* Spouse informations*/
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
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
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  child: TextFormField(
                    initialValue: partnerName,
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
            ],
          ),

          /* Date of Death*/
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
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
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
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
          Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Wrap(
                    alignment: WrapAlignment.start,
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
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Container(
                  child: TextFormField(
                    initialValue: partnerName,
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
            ],
          ),
          Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Wrap(
                children: [
                  TextButton(
                      onPressed: () async {
                        DateTime pickedD = await _selectDate(context);
                        setState(() {
                          burialDate = pickedD;
                        });
                        ;
                      },
                      child: Text('Date & TIme requested for outing - ')),
                  Text(
                    '${dateFormat.format(burialDate)}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              child: TextFormField(
                initialValue: society,
                decoration: InputDecoration(hintText: 'Society in Church'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              child: TextFormField(
                initialValue: activity,
                decoration: InputDecoration(hintText: 'Church Activities'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              child: TextFormField(
                initialValue: cultStatus,
                decoration: InputDecoration(
                    hintText: 'Is the deceased a memeber of any secret cult ?'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Center(
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              runSpacing: defaultPadding,
              children: [
                MaterialButton(
                  onPressed: () => widget.pageController.animateToPage(0,
                      duration: kDefaultDuration, curve: Curves.easeInOut),
                  color: Color(0xff1d3557),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                MaterialButton(
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
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}

class FinalForm extends StatefulWidget {
  final PageController pageController;
  FinalForm({Key? key, required this.pageController}) : super(key: key);

  @override
  _FinalFormState createState() => _FinalFormState();
}

class _FinalFormState extends State<FinalForm> {
  final _formKey = GlobalKey<FormState>();

  final firstApplicant = '';
  final secondApplicant = '';
  final firstApplicantRelationship = '';
  final secondApplicantRelationship = '';
  final language = '';
  final donate = '';
  final burialLocation = '';
  final otherRequest = '';

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<BurialProvider>(context)
        .submitForm(
            firstApplicant,
            secondApplicant,
            firstApplicantRelationship,
            secondApplicantRelationship,
            language,
            donate,
            burialLocation,
            otherRequest)
        .then((value) => widget.pageController.animateToPage(2,
            duration: kDefaultDuration, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: defaultPadding),
              child: Text(
                '3 of 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1d3557),
                    fontSize: defaultPadding * 2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: TextFormField(
              initialValue: firstApplicant,
              decoration: InputDecoration(hintText: 'Name of applicant(1)'),
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
              initialValue: firstApplicantRelationship,
              decoration: InputDecoration(
                  hintText: 'Relationship of applicant to deceased (1)'),
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
              initialValue: secondApplicant,
              decoration: InputDecoration(hintText: 'Name of applicant(2)'),
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
              initialValue: firstApplicantRelationship,
              decoration: InputDecoration(
                  hintText: 'Relationship of applicant to deceased (2)'),
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
              initialValue: language,
              decoration: InputDecoration(
                  hintText:
                      'What language do you want the service/wake keep to be concluded ?'),
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
              initialValue: donate,
              decoration: InputDecoration(
                  hintText:
                      'What do you want to donate for the church in memorial of the deceased ?'),
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
              initialValue: burialLocation,
              decoration: InputDecoration(
                  hintText: 'Where will the deceased be buried ?'),
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
              initialValue: otherRequest,
              decoration: InputDecoration(
                  hintText:
                      'Do you have any other request that you want the priest to consider (e.g Deceased favorite song in pamphlet, guest choir) etc.'),
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
              child: Text(
                  'NOTE: Other useful information or biography can be written on a seperate sheet of paper and attached to this form of application \nIt is expected that the deceased  in respect of whom this applicantion is made is a baptized, regular and financial member of this Church.')),
          Center(
            child: Wrap(
              runSpacing: defaultPadding,
              children: [
                MaterialButton(
                  onPressed: () => widget.pageController.animateToPage(1,
                      duration: kDefaultDuration, curve: Curves.easeInOut),
                  color: Color(0xff1d3557),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                MaterialButton(
                  onPressed: () => _submitForm(),
                  color: Color(0xff1d3557),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
        ],
      ),
    );
  }
}
