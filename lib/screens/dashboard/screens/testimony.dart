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
  bool _iscLoading = false;
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  Future viewTestimonyDialog(Testimony testimonyy) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (ctx, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: Container(
                constraints: BoxConstraints(
                    minHeight: 350, minWidth: 400, maxWidth: 600),
                //padding: EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.network(
                            testimonyy.imagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        'Name: ${testimonyy.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Phone Number:   ${testimonyy.phoneNumber}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Text(
                        testimonyy.testimony,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        children: [
                          Center(
                            child: Text(
                              'Make Testimony Visible on HomePage : ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Center(
                            child: Switch(
                                value: isSwitched,
                                activeColor: Color(0xff31a062),
                                inactiveTrackColor: Colors.grey.shade500,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = !isSwitched;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Center(
                        child: _iscLoading
                            ? CircularProgressIndicator(
                                color: Color(0xff001242),
                              )
                            : MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    _iscLoading = true;
                                  });
                                  await Provider.of<DataProvider>(context,
                                          listen: false)
                                      .updateTestimony(
                                          testimonyy.id,
                                          Testimony(
                                              testimonyy.id,
                                              testimonyy.name,
                                              testimonyy.phoneNumber,
                                              testimonyy.testimony,
                                              isSwitched,
                                              testimonyy.imagePath))
                                      .then((value) {
                                    setState(() {
                                      _iscLoading = false;
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
      //backgroundColor: Color(0xff001242,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Color(0xff001242),
              ))
            : SingleChildScrollView(
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
                      height: defaultPadding,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Table(
                        children: [
                          TableRow(
                              decoration: BoxDecoration(color: Colors.white),
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: defaultPadding),
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff001242)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: defaultPadding),
                                      child: Text(
                                        'Phone number',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff001242)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: defaultPadding),
                                      child: Text(
                                        ' ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff001242)),
                                      ),
                                    ),
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                    Container(
                      //constraints: BoxConstraints(maxWidth: 900),
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Table(
                          border: TableBorder.all(
                              color: Color(0xff001242),
                              style: BorderStyle.solid,
                              width: 2),
                          children: List.generate(
                              testimony.length,
                              (index) => TableRow(
                                      decoration: BoxDecoration(
                                          color: index.isOdd
                                              ? Colors.white
                                              : Colors.grey.shade100),
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: defaultPadding),
                                              child: Text(
                                                testimony[index].name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff001242)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: defaultPadding),
                                              child: Text(
                                                testimony[index].phoneNumber,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff001242)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: defaultPadding),
                                              child: TextButton(
                                                  onPressed: () =>
                                                      viewTestimonyDialog(
                                                          testimony[index]),
                                                  child: Text('View')),
                                            )
                                          ],
                                        ),
                                      ]))
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: testimony.length,
                          //     itemBuilder: (context, index) =>
                          //         TestimonyList(testimony: testimony[index])),
                          ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

// class TestimonyList extends StatefulWidget {
//   final Testimony testimony;
//   TestimonyList({Key? key, required this.testimony}) : super(key: key);

//   @override
//   _TestimonyListState createState() => _TestimonyListState();
// }

// class _TestimonyListState extends State<TestimonyList> {

//   Future<void> submitChange() async {}



//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     setState(() {
//       isSwitched = testimonyy.isVisible;
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           testimonyy.name,
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff001242)),
//         ),
//         Text(
//           testimonyy.phoneNumber,
//           style: TextStyle(fontSize: 16, color: Color(0xff001242)),
//         ),
//         TextButton(onPressed: () => viewTestimonyDialog(), child: Text('View'))
//       ],
//     );
//   }
// }
