import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _screenisLoading = true;
  String? title = 'Bible Study';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<TimeOfDay?> _selectime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null && timeOfDay != selectedTime) {
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

  Future showEventDialog() {
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
                          'Add an Event',
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
                          initialValue: title,
                          decoration: InputDecoration(
                            labelText: 'Title',
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
                          onSaved: (newValue) => title = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required';
                            }
                          },
                        ),
                        SizedBox(
                          height: defaultPadding * 2,
                        ),
                        Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Wrap(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      DateTime pickedD =
                                          await _selectDate(context);
                                      setState(() {
                                        selectedDate = pickedD;
                                      });
                                    },
                                    child: Text(
                                      'Select date of event - ',
                                      style: TextStyle(
                                          color: Color(0xff001242),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    )),
                                Text(
                                  '${stringdateFormat.format(selectedDate)}',
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
                                      TimeOfDay? pickedTime =
                                          await _selectime(context);
                                      setState(() {
                                        selectedTime = pickedTime!;
                                      });
                                    },
                                    child: Text(
                                      'Choose time of event.',
                                      style: TextStyle(
                                        color: Color(0xff001242),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    )),
                                Text(
                                  '${formatTimeOfDay(selectedTime)}',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )),
                        SizedBox(
                          height: defaultPadding,
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
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .addEvent(
                                          title!, selectedDate, selectedTime)
                                      .then((_) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        backgroundColor: Color(0xff001242),
                                        message: "Event updated succesfully",
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
                                    'Upload Event',
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
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _screenisLoading = true;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<DataProvider>(context).fetchEvents().then((value) {
      setState(() {
        _screenisLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001242),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'St Paul\'s Anglican Church Admin',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: defaultPadding * 2,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: defaultPadding * 3,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Go Back to Dashboard',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 1.4,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: MaterialButton(
                      onPressed: () => showEventDialog(),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Add an Event',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              _screenisLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<DataProvider>(builder: (context, events, _) {
                      return Container(
                        //height: 600,

                        margin: EdgeInsets.all(defaultPadding),
                        constraints:
                            BoxConstraints(maxWidth: 900, minHeight: 600),
                        child: GridView.count(
                          crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                          crossAxisSpacing: defaultPadding,
                          mainAxisSpacing: defaultPadding,
                          shrinkWrap: true,
                          children: List.generate(
                              events.events.length,
                              (index) =>
                                  EventCard(event: events.events[index])),
                        ),
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final Event event;
  EventCard({Key? key, required this.event}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Container(
          height: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isLoading)
                Expanded(
                  child: Text(
                    widget.event.title,
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 18 : 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              if (!isLoading)
                SizedBox(
                  height: Responsive.isDesktop(context) ? 8 : 2,
                ),
              if (!isLoading)
                Expanded(
                  child: Text(
                    widget.event.date,
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? 16 : 12,
                    ),
                  ),
                ),
              if (!isLoading)
                SizedBox(
                  height: Responsive.isDesktop(context) ? 8 : 2,
                ),
              if (!isLoading)
                Expanded(
                  child: Text(
                    widget.event.time,
                    style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? 16 : 12,
                        color: Colors.grey.shade600),
                  ),
                ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff001242),
                  ),
                ),
              Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<DataProvider>(context, listen: false)
                            .deleteEvent(
                          widget.event.id,
                        )
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.shade800,
                        size: Responsive.isDesktop(context) ? 24 : 18,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
