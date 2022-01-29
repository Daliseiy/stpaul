import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/models/burial.dart';
import 'package:stpaulanglicanchurh/providers/burial_provider.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class BurialsScreen extends StatefulWidget {
  const BurialsScreen({Key? key}) : super(key: key);

  @override
  _BurialsScreenState createState() => _BurialsScreenState();
}

class _BurialsScreenState extends State<BurialsScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<BurialProvider>(context, listen: false)
        .fetchBurialForm()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final burial = Provider.of<BurialProvider>(context).burialData;
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
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      //constraints: BoxConstraints(maxWidth: 900),
                      margin: Responsive.isDesktop(context)
                          ? EdgeInsets.all(defaultPadding * 2)
                          : EdgeInsets.all(defaultPadding * 0.4),
                      //padding: EdgeInsets.all(defaultPadding),

                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: burial.length,
                          itemBuilder: (context, index) => BurialContainer(
                                burial: burial[index],
                              )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class BurialContainer extends StatefulWidget {
  final Burial burial;
  BurialContainer({Key? key, required this.burial}) : super(key: key);

  @override
  State<BurialContainer> createState() => _BurialContainerState();
}

class _BurialContainerState extends State<BurialContainer> {
  Future viewBurialDataDialog() {
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
                    SimpleRowText(
                        firstLabel: 'Name of Deceased',
                        secondLabel: 'Age',
                        firstText: widget.burial.nameOfDeceased,
                        secondText: widget.burial.age),
                    SimpleRowText(
                        firstLabel: 'Home Address',
                        secondLabel: 'Business Address',
                        firstText: widget.burial.homeAddress,
                        secondText: widget.burial.businessAddress),
                    SimpleRowText(
                        firstLabel: 'Date Of Birth',
                        secondLabel: 'State of Origin',
                        firstText: dateFormat.format(widget.burial.dateOfBirth),
                        secondText: widget.burial.stateOfOrigin),
                    SimpleRowText(
                        firstLabel: 'Place Of Baptism',
                        secondLabel: 'Date of Baptism',
                        firstText: widget.burial.baptismPlace,
                        secondText:
                            dateFormat.format(widget.burial.baptismDate)),
                    SimpleRowText(
                        firstLabel: 'Place of Confirmation',
                        secondLabel: 'Date of Confrimation',
                        firstText: widget.burial.confirmationPlace,
                        secondText:
                            dateFormat.format(widget.burial.confirmationDate)),
                    SimpleRowText(
                        firstLabel: 'Name of Spouse',
                        secondLabel: 'Date of Marriage',
                        firstText: widget.burial.partnerName,
                        secondText:
                            dateFormat.format(widget.burial.marriageDate)),
                    SimpleRowText(
                        firstLabel: 'Date Of Burial',
                        secondLabel: 'Date of Wake Keep',
                        firstText:
                            dateFormat.format(widget.burial.wakeKeepDate),
                        secondText:
                            dateFormat.format(widget.burial.marriageDate)),
                    SimpleRowText(
                        firstLabel: 'Burial Location',
                        secondLabel: 'Date of Outing',
                        firstText: widget.burial.burialLocation,
                        secondText:
                            dateFormat.format(widget.burial.outingDate)),
                    SimpleRowText(
                        firstLabel: 'Society in Church',
                        secondLabel: 'Activity in Church',
                        firstText: widget.burial.society,
                        secondText: widget.burial.activity),
                    SimpleRowText(
                        firstLabel: 'Is/Was the deceased in a cult group ? ',
                        secondLabel:
                            'Do you need the service of the Organist and Choir ',
                        firstText: widget.burial.cultStatus,
                        secondText: widget.burial.serviceRequest),
                    SimpleRowText(
                        firstLabel: 'Name of Applicant(1)',
                        secondLabel: 'Relationship of applicant to deceased(1)',
                        firstText: widget.burial.firstApplicant,
                        secondText: widget.burial.firstApplicantRelationship),
                    SimpleRowText(
                        firstLabel: 'Name of Applicant(2)',
                        secondLabel: 'Relationship of applicant to deceased(2)',
                        firstText: widget.burial.secondApplicant,
                        secondText: widget.burial.secondApplicantRelationship),
                    SimpleRowText(
                        firstLabel: 'Language to be used at service',
                        secondLabel: 'Donation to Church',
                        firstText: widget.burial.language,
                        secondText: widget.burial.donate),
                    SimpleRowText(
                        firstLabel: 'Other Request',
                        secondLabel: '',
                        firstText: widget.burial.otherRequest,
                        secondText: ''),
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
      onTap: () => viewBurialDataDialog(),
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
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.burial.nameOfDeceased),
                Text(widget.burial.age),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            '${dateFormat.format(widget.burial.dateOfBirth)}')),
                    Expanded(
                        child: Text(
                            '${dateFormat.format(widget.burial.dateOfDeath)}')),
                  ],
                ),
                Text(widget.burial.stateOfOrigin),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class SimpleRowText extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final String firstText;
  final String secondText;
  SimpleRowText({
    Key? key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        spacing: defaultPadding,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '${firstLabel}: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextSpan(text: firstText)
            ], style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '${secondLabel}: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextSpan(text: secondText)
            ], style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
