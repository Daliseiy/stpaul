import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/providers/burial_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../responsive.dart';

class BurialForm extends StatefulWidget {
  BurialForm({Key? key}) : super(key: key);

  @override
  _BurialFormState createState() => _BurialFormState();
}

class _BurialFormState extends State<BurialForm> {
  final PageController _pageController = PageController();

  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _scaffoldKey.currentState!.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !Responsive.isDesktop(context) ? SideMenu() : null,
      drawerEnableOpenDragGesture: false,
      key: _scaffoldKey,
      backgroundColor: Color(0xff001242),
      body: SafeArea(
        child: SingleChildScrollView(
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
  Map initformData = {};
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
    // TODO: implement didChangeDependencies
    Map initData = Provider.of<BurialProvider>(context).getFormData();

    setState(() {
      initformData = initData;
      baptismDate = initformData['baptismDate'] == null
          ? DateTime.now()
          : initformData['baptismDate'];
      selectedDate = initformData['dateOfBirth'] == null
          ? DateTime.now()
          : initformData['dateOfBirth'];
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
              initialValue: initformData['nameOfDeceased'],
              decoration: InputDecoration(hintText: 'Full name of deceased'),
              onSaved: (newValue) => _nameOfDeceased = newValue!,
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
              initialValue: initformData['age'],
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
              onSaved: (newValue) => _age = newValue!,
              validator: (value) {
                bool isInt = int.tryParse(value as String) == null;

                if (value.isEmpty) {
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
              initialValue: initformData['homeAddress'],
              decoration: InputDecoration(hintText: 'Home Address'),
              onSaved: (newValue) => _homeAddress = newValue!,
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
              initialValue: initformData['businessAddress'],
              decoration: InputDecoration(hintText: 'Business Address(if any)'),
              onSaved: (newValue) => _businessAddress = newValue!,
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
              initialValue: initformData['stateOfOrigin'],
              onSaved: (newValue) => _stateOfOrigin = newValue!,
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
                    initialValue: initformData['baptismPlace'],
                    decoration: InputDecoration(hintText: 'Place of Baptism'),
                    onSaved: (newValue) => _baptismPlace = newValue!,
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

  DateTime outingDate = DateTime.now();

  var society = '';

  var activity = '';

  var cultStatus = '';

  var serviceRequest = '';

  final _formKey = GlobalKey<FormState>();

  Map initformData = {};

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
            cultStatus,
            outingDate,
            serviceRequest)
        .then((value) => widget.pageController.animateToPage(2,
            duration: kDefaultDuration, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    Map initData = Provider.of<BurialProvider>(context).getFormDataB();
    setState(() {
      initformData = initData;
      confirmationDate = initformData['confirmationDate'] == null
          ? DateTime.now()
          : initformData['confirmationDate'];
      marriageDate = initformData['marriageDate'] == null
          ? DateTime.now()
          : initformData['marriageDate'];
      dateOfDeath = initformData['dateOfDeath'] == null
          ? DateTime.now()
          : initformData['dateOfDeath'];
      burialDate = initformData['burialDate'] == null
          ? DateTime.now()
          : initformData['burialDate'];
      wakeWeepDate = initformData['wakeKeepDate'] == null
          ? DateTime.now()
          : initformData['wakeKeepDate'];
      outingDate = initformData['outingDate'] == null
          ? DateTime.now()
          : initformData['outingDate'];
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
                    initialValue: initformData['confirmationPlace'],
                    decoration:
                        InputDecoration(hintText: 'Place of Confirmation'),
                    onSaved: (newValue) => confirmationPlace = newValue!,
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
                    initialValue: initformData['partnerName'],
                    decoration:
                        InputDecoration(hintText: 'Name of Spouse (if any)'),
                    onSaved: (newValue) => partnerName = newValue!,
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
                    initialValue: initformData['serviceRequest'],
                    decoration: InputDecoration(
                        hintText:
                            'Do you require the service of choir or organ (yes/no)'),
                    onSaved: (newValue) => serviceRequest = newValue!,
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
                          outingDate = pickedD;
                        });
                      },
                      child: Text('Date & TIme requested for outing - ')),
                  Text(
                    '${dateFormat.format(outingDate)}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              child: TextFormField(
                initialValue: initformData['society'],
                decoration: InputDecoration(hintText: 'Society in Church'),
                onSaved: (newValue) => society = newValue!,
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
                initialValue: initformData['activity'],
                decoration: InputDecoration(hintText: 'Church Activities'),
                onSaved: (newValue) => activity = newValue!,
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
                initialValue: initformData['cultStatus'],
                decoration: InputDecoration(
                    hintText: 'Is the deceased a memeber of any secret cult ?'),
                onSaved: (newValue) => cultStatus = newValue!,
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
                  onPressed: () => {
                    _formKey.currentState!.save(),
                    widget.pageController.animateToPage(0,
                        duration: kDefaultDuration, curve: Curves.easeInOut)
                  },
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

  var firstApplicant = '';
  var secondApplicant = '';
  var firstApplicantRelationship = '';
  var secondApplicantRelationship = '';
  var language = '';
  var donate = '';
  var burialLocation = '';
  var otherRequest = '';
  bool _isLoading = false;
  Map initformData = {};

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    Provider.of<BurialProvider>(context, listen: false)
        .submitForm(
            firstApplicant,
            secondApplicant,
            firstApplicantRelationship,
            secondApplicantRelationship,
            language,
            donate,
            burialLocation,
            otherRequest)
        .then((value) => {
              setState(() {
                _isLoading = false;
              }),
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  backgroundColor: Color(0xff001242),
                  message:
                      "Your application  has being recieved. We'll get back to you.",
                ),
              )
            });
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    Map initData = Provider.of<BurialProvider>(context).getFormDataC();
    setState(() {
      initformData = initData;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
              initialValue: initformData['firstApplicant'],
              decoration: InputDecoration(hintText: 'Name of applicant(1)'),
              onSaved: (newValue) => firstApplicant = newValue!,
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
              initialValue: initformData['firstApplicantRelationship'],
              decoration: InputDecoration(
                  hintText: 'Relationship of applicant to deceased (1)'),
              onSaved: (newValue) => firstApplicantRelationship = newValue!,
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
              initialValue: initformData['secondApplicant'],
              decoration: InputDecoration(hintText: 'Name of applicant(2)'),
              onSaved: (newValue) => secondApplicant = newValue!,
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
              initialValue: initformData['secondApplicantRelationship'],
              decoration: InputDecoration(
                  hintText: 'Relationship of applicant to deceased (2)'),
              onSaved: (newValue) => secondApplicantRelationship = newValue!,
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
              initialValue: initformData['language'],
              decoration: InputDecoration(
                  hintText:
                      'What language do you want the service/wake keep to be concluded ?'),
              onSaved: (newValue) => language = newValue!,
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
              initialValue: initformData['donate'],
              decoration: InputDecoration(
                  hintText:
                      'What do you want to donate for the church in memorial of the deceased ?'),
              onSaved: (newValue) => donate = newValue!,
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
              initialValue: initformData['burialLocation'],
              decoration: InputDecoration(
                  hintText: 'Where will the deceased be buried ?'),
              onSaved: (newValue) => burialLocation = newValue!,
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
              initialValue: initformData['otherRequest'],
              decoration: InputDecoration(
                  hintText:
                      'Do you have any other request that you want the priest to consider (e.g Deceased favorite song in pamphlet, guest choir) etc.'),
              onSaved: (newValue) => otherRequest = newValue!,
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
                  onPressed: () {
                    _formKey.currentState!.save();
                    Provider.of<BurialProvider>(context, listen: false)
                        .setFinalForm(
                            firstApplicant,
                            secondApplicant,
                            firstApplicantRelationship,
                            secondApplicantRelationship,
                            language,
                            donate,
                            burialLocation,
                            otherRequest)
                        .then((value) => widget.pageController.animateToPage(1,
                            duration: kDefaultDuration,
                            curve: Curves.easeInOut));
                  },
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
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(0xff1d3557),
                      ))
                    : MaterialButton(
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
