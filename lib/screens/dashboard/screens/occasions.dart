import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/models/ocassion.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';

import '../../../constant.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({Key? key}) : super(key: key);

  @override
  _OccasionScreenState createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'St Paul\'s Anglican Church Admin',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff001242),
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
                      color: Color(0xff001242),
                      fontSize: defaultPadding * 1.4,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: defaultPadding * 1.5,
              ),
              FutureBuilder<List<Occasion>>(
                future: DataProvider()
                    .fetchOccasion(), // a previously-obtained Future<String> or null
                builder: (BuildContext context,
                    AsyncSnapshot<List<Occasion>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    List<Occasion>? occasion = snapshot.data;

                    children = <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: occasion!.length,
                          itemBuilder: (context, index) => OccasionBox(
                                occasion: occasion[index],
                              )),
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
                        child:
                            Text('An error occured. Please reload the page.'),
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
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Color(0xff001242)),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class OccasionBox extends StatefulWidget {
  final Occasion occasion;
  const OccasionBox({Key? key, required this.occasion}) : super(key: key);

  @override
  State<OccasionBox> createState() => _OccasionBoxState();
}

class _OccasionBoxState extends State<OccasionBox> {
  Future viewOcassionForm() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: Container(
              constraints: BoxConstraints(minHeight: 350, minWidth: 400),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Basic Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SimpleText(
                        label: 'Applicant name: ',
                        text: widget.occasion.applicant),
                    SimpleText(
                        label: 'Occasion type: ',
                        text: widget.occasion.occasionType),
                    SimpleText(
                        label: 'Ocassion time: ',
                        text: widget.occasion.ocassionTime),
                    SimpleText(
                        label: 'Ocassion date: ',
                        text: widget.occasion.occasionDate),
                    Divider(),
                    Text(
                      'Payments Made',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SimpleTextn(
                        label: 'Diesel/Fuel: ',
                        text: widget.occasion.dieselPayment),
                    SimpleTextn(
                        label: 'Media/IT: ',
                        text: widget.occasion.mediaPayment),
                    SimpleTextn(
                        label: 'Mother\'s union: ',
                        text: widget.occasion.motherUnionPayment),
                    SimpleTextn(
                        label: 'Choir welfare: ',
                        text: widget.occasion.choirWelfare),
                    SimpleTextn(
                        label: 'Number of ministers: ',
                        text: widget.occasion.noOfMinisters),
                    SimpleTextn(
                        label: 'Honorarium: ',
                        text: widget.occasion.honorarium),
                    SimpleTextn(
                        label: 'Gift to the church: ',
                        text: widget.occasion.giftToChurch),
                    SimpleTextn(
                        label: 'Cash or Others: ',
                        text: widget.occasion.cashOrOthers),
                    Divider(),
                    Text(
                      'Refreshement Arrangements',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SimpleTextn(
                        label: 'Priests: ',
                        text: widget.occasion.priestRefreshment),
                    SimpleTextn(
                        label: 'Choir refreshements: ',
                        text: widget.occasion.choirRefreshment),
                    SimpleTextn(
                        label: 'Church workers: ',
                        text: widget.occasion.workersRefreshment),
                    Divider(),
                    Text(
                      'Total Fees',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SimpleTextn(
                        label: 'Total amount paid: ',
                        text: widget.occasion.totalAmountPaid),
                    SimpleText(
                        label: 'Total amount paid in words: ',
                        text: widget.occasion.totalAmountPaidWords),
                    SimpleText(
                        label: 'Name of receiver: ',
                        text: widget.occasion.nameOfReceiver),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => viewOcassionForm(),
      child: Container(
        //height: 400,
        margin: EdgeInsets.all(defaultPadding),
        padding: EdgeInsets.all(defaultPadding),

        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Color(0xff001242),
                  borderRadius: BorderRadius.circular(30)),
            ),
            SizedBox(
              width: defaultPadding,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(child: Text(widget.occasion.applicant)),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleTextn extends StatelessWidget {
  final String label;
  final String text;
  const SimpleTextn({Key? key, required this.label, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Text(
          "₦${formatter.format(int.parse(text))}",
        ))
      ],
    );
  }
}

class SimpleText extends StatelessWidget {
  final String label;
  final String text;
  const SimpleText({Key? key, required this.label, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Text(
          text,
        ))
      ],
    );
  }
}
