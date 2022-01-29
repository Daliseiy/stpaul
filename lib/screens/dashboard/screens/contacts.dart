import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:stpaulanglicanchurh/responsive.dart';

import '../../../constant.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      setState(() {
        _isLoading = true;
      });
      _isLoading = true;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<DataProvider>(context, listen: false)
        .fetchContacts()
        .then((value) {
      setState(() {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<DataProvider>(context).contacts;
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
                          : EdgeInsets.all(defaultPadding),
                      padding: EdgeInsets.all(defaultPadding),
                      color: Colors.blue.shade900.withOpacity(0.1),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) =>
                              ContactList(contact: contacts[index])),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  final Contact contact;
  ContactList({Key? key, required this.contact}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  bool _isLoading = false;
  bool isSwitched = false;

  Future<void> submitChange() async {}

  Future viewContactDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (ctx, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                constraints: BoxConstraints(minHeight: 350, minWidth: 400),
                //padding: EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${widget.contact.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        'Phone Number: ${widget.contact.phoneNumber}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        'Email: ${widget.contact.email}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        'Message: ${widget.contact.message}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      // Center(
                      //   child: _isLoading
                      //       ? CircularProgressIndicator(
                      //           color: Color(0xff001242),
                      //         )
                      //       : MaterialButton(
                      //           onPressed: () async {
                      //             setState(() {
                      //               _isLoading = true;
                      //             });
                      //             await Provider.of<DataProvider>(context,
                      //                     listen: false)
                      //                 .updateContact(
                      //                     widget.Contact.id,
                      //                     Contact(
                      //                         widget.Contact.id,
                      //                         widget.Contact.name,
                      //                         widget.Contact.phoneNumber,
                      //                         widget.Contact.Contact,
                      //                         isSwitched))
                      //                 .then((value) {
                      //               setState(() {
                      //                 _isLoading = false;
                      //                 showTopSnackBar(
                      //                   context,
                      //                   CustomSnackBar.success(
                      //                     backgroundColor: Color(0xff001242),
                      //                     message:
                      //                         "Contact settings has been updated.",
                      //                   ),
                      //                 );
                      //               });
                      //             });
                      //           },
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(25)),
                      //           color: Color(0xff001242),
                      //           child: Padding(
                      //             padding: EdgeInsets.all(defaultPadding),
                      //             child: Text(
                      //               'Change Contact Settings',
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //           ),
                      //         ),
                      // )
                    ],
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.contact.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Text(
                  widget.contact.email,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              TextButton(
                  onPressed: () => viewContactDialog(), child: Text('View'))
            ],
          ),
          Divider(
            color: Colors.white,
            thickness: 2.0,
          )
        ],
      ),
    );
  }
}
