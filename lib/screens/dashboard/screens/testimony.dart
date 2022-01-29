import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../constant.dart';

class TestimonyScreen extends StatefulWidget {
  const TestimonyScreen({Key? key}) : super(key: key);

  @override
  _TestimonyScreenState createState() => _TestimonyScreenState();
}

class _TestimonyScreenState extends State<TestimonyScreen> {
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
    Provider.of<DataProvider>(context, listen: false)
        .fetchTestimony()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final testimony = Provider.of<DataProvider>(context).testimony;
    return Scaffold(
      backgroundColor: Color(0xff001242),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : SingleChildScrollView(
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Text(
                            'Phone number',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          TextButton(onPressed: () {}, child: Text('View'))
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 900),
                      padding: EdgeInsets.all(defaultPadding),
                      color: Colors.blue.shade900.withOpacity(0.1),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: testimony.length,
                          itemBuilder: (context, index) =>
                              TestimonyList(testimony: testimony[index])),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class TestimonyList extends StatefulWidget {
  final Testimony testimony;
  TestimonyList({Key? key, required this.testimony}) : super(key: key);

  @override
  _TestimonyListState createState() => _TestimonyListState();
}

class _TestimonyListState extends State<TestimonyList> {
  bool _isLoading = false;
  bool isSwitched = false;

  Future<void> submitChange() async {}

  Future viewTestimonyDialog() {
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
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name: ${widget.testimony.name}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Phone Number${widget.testimony.phoneNumber}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        widget.testimony.testimony,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        children: [
                          Text('Make Testimony Visible on HomePage : '),
                          SizedBox(
                            width: 8,
                          ),
                          Switch(
                              value: isSwitched,
                              activeColor: Color(0xff31a062),
                              inactiveTrackColor: Colors.grey.shade500,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = !isSwitched;
                                });
                              }),
                        ],
                      ),
                      Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Color(0xff001242),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Provider.of<DataProvider>(context,
                                          listen: false)
                                      .updateTestimony(
                                          widget.testimony.id,
                                          Testimony(
                                              widget.testimony.id,
                                              widget.testimony.name,
                                              widget.testimony.phoneNumber,
                                              widget.testimony.testimony,
                                              isSwitched))
                                      .then((value) {
                                    setState(() {
                                      _isLoading = false;
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          backgroundColor: Color(0xff001242),
                                          message:
                                              "Testimony settings has been updated.",
                                        ),
                                      );
                                    });
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                color: Color(0xff001242),
                                child: Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Text(
                                    'Change Testimony Settings',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {
      isSwitched = widget.testimony.isVisible;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.testimony.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                widget.testimony.phoneNumber,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              TextButton(
                  onPressed: () => viewTestimonyDialog(), child: Text('View'))
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
