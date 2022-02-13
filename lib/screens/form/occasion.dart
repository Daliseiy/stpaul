import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../constant.dart';
import '../../responsive.dart';

class OccasionForm extends StatefulWidget {
  const OccasionForm({Key? key}) : super(key: key);

  @override
  State<OccasionForm> createState() => _OccasionFormState();
}

class _OccasionFormState extends State<OccasionForm> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? applicant;
  String? occassionType;
  DateTime occassionDate = DateTime.now();
  String? dieselPayment;
  String? mediaPayment;
  String? motherUnionPayment;
  String? choirWelfare;

  String? noOfMinisters;
  String? honorarium;
  String? giftToChurch;
  String? cashOrOthers;

  String? priestRefreshment;
  String? choirRefreshment;
  String? workersRefreshment;
  String? totalAmountPaid;
  String? totalAmountPaidWords;
  String? nameOfReceiver;
  DateTime dateOfPayment = DateTime.now();

  TimeOfDay occassionTime = TimeOfDay.now();

  Future<TimeOfDay?> _selectime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: occassionTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null && timeOfDay != occassionTime) {
      return timeOfDay;
    }
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (picked != null) {
      return picked;
    }
    throw () {};
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scaffoldKey.currentState!.dispose();
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
          child: Form(
            key: _formKey,
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
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text('Administrative form for ocassional services.',
                      textAlign: TextAlign.center,
                      style: Responsive.isDesktop(context)
                          ? Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white)
                          : Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white)),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Card(
                      margin: EdgeInsets.all(defaultPadding),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue: applicant,
                                decoration: InputDecoration(
                                  labelText: 'Applicant Name(Surname first)',
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
                                onSaved: (newValue) => applicant = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              TextFormField(
                                initialValue: occassionType,
                                decoration: InputDecoration(
                                  labelText: 'Type of Occasion',
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
                                onSaved: (newValue) => occassionType = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    color: Color(0xff001242),
                                    padding: EdgeInsets.all(6),
                                    margin: EdgeInsets.only(right: 8),
                                    child: TextButton(
                                        onPressed: () async {
                                          TimeOfDay? pickedTime =
                                              await _selectime(context);
                                          setState(() {
                                            occassionTime = pickedTime!;
                                          });
                                        },
                                        child: Text(
                                          'Select Time.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                  Text(
                                    '${formatTimeOfDay(occassionTime)}',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    color: Color(0xff001242),
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.all(6),
                                    child: TextButton(
                                        onPressed: () async {
                                          DateTime pickedD =
                                              await _selectDate(context);
                                          setState(() {
                                            occassionDate = pickedD;
                                          });
                                        },
                                        child: Text(
                                          'Select date of event',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        )),
                                  ),
                                  Text(
                                    '${stringdateFormat.format(occassionDate)}',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Divider(thickness: 2),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: Text(
                                    'Payment to be made (Please enter the amount in numbers'),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: dieselPayment,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Diesel/Fuel',
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
                                      onSaved: (newValue) =>
                                          dieselPayment = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: mediaPayment,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Media/IT',
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
                                      onSaved: (newValue) =>
                                          mediaPayment = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: motherUnionPayment,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Mother\'s Union',
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
                                      onSaved: (newValue) =>
                                          motherUnionPayment = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: choirWelfare,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Choir Welfare',
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
                                      onSaved: (newValue) =>
                                          choirWelfare = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: noOfMinisters,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Number of Ministers',
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
                                      onSaved: (newValue) =>
                                          noOfMinisters = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: honorarium,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Honorarium',
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
                                      onSaved: (newValue) =>
                                          honorarium = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: giftToChurch,
                                      decoration: InputDecoration(
                                        labelText: 'Gift to the Church',
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
                                      onSaved: (newValue) =>
                                          giftToChurch = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: cashOrOthers,
                                      decoration: InputDecoration(
                                        labelText: 'State cash or kind',
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
                                      onSaved: (newValue) =>
                                          cashOrOthers = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Text('Refreshment Arrangements'),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: priestRefreshment,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Priests',
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
                                      onSaved: (newValue) =>
                                          priestRefreshment = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: choirRefreshment,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Choir Refreshment',
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
                                      onSaved: (newValue) =>
                                          choirRefreshment = newValue,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              TextFormField(
                                initialValue: workersRefreshment,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Church Workers',
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
                                onSaved: (newValue) =>
                                    workersRefreshment = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Text('Total Fees'),
                              TextFormField(
                                initialValue: totalAmountPaid,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Total amount paid',
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
                                onSaved: (newValue) =>
                                    totalAmountPaid = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              TextFormField(
                                initialValue: totalAmountPaidWords,
                                decoration: InputDecoration(
                                  labelText: 'Total amount paid in words',
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
                                onSaved: (newValue) =>
                                    totalAmountPaidWords = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              TextFormField(
                                initialValue: nameOfReceiver,
                                decoration: InputDecoration(
                                  labelText: 'Name of Receiver',
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
                                onSaved: (newValue) =>
                                    nameOfReceiver = newValue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    color: Color(0xff001242),
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.all(6),
                                    child: TextButton(
                                        onPressed: () async {
                                          DateTime pickedDate =
                                              await _selectDate(context);
                                          setState(() {
                                            dateOfPayment = pickedDate;
                                          });
                                        },
                                        child: Text(
                                          'Select date of event',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        )),
                                  ),
                                  Text(
                                    '${stringdateFormat.format(dateOfPayment)}',
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    'NOTE: i.This form must be completed and returned at least 2 weeks before the occasion.\nii.All the above are necessary conditions for any occasion to be held in our Church.\niiiThe refreshments must arrive on time and must be handled over to the Administrative Priest in his office before the commencement of the service.\niv.Clergy Honorarium must be handed over to the vicar before the event.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        height: 1.5),
                                  )),
                              SizedBox(
                                height: defaultPadding * 1.5,
                              ),
                              _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Color(0xff1d3557),
                                    ))
                                  : Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          final isValid =
                                              _formKey.currentState!.validate();
                                          if (!isValid) {
                                            return;
                                          }
                                          _formKey.currentState!.save();
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          Provider.of<DataProvider>(context,
                                                  listen: false)
                                              .addOccasion(
                                                  applicant,
                                                  occassionType,
                                                  occassionDate,
                                                  dieselPayment,
                                                  mediaPayment,
                                                  motherUnionPayment,
                                                  choirWelfare,
                                                  noOfMinisters,
                                                  honorarium,
                                                  giftToChurch,
                                                  cashOrOthers,
                                                  priestRefreshment,
                                                  choirRefreshment,
                                                  workersRefreshment,
                                                  totalAmountPaid,
                                                  totalAmountPaidWords,
                                                  nameOfReceiver,
                                                  dateOfPayment,
                                                  occassionTime)
                                              .then((value) {
                                            setState(() {
                                              _isLoading = false;
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  backgroundColor:
                                                      Color(0xff001242),
                                                  message:
                                                      "Your service form has being recieved. We'll get back to you.",
                                                ),
                                              );
                                            });
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        color: Color(0xff001242),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(defaultPadding),
                                          child: Text(
                                            'Submit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
