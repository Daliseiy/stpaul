import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class EventSection extends StatelessWidget {
  const EventSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: defaultPadding),
      padding: EdgeInsets.all(defaultPadding * 1.5),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Text('Upcoming Events',
              textAlign: TextAlign.center,
              style: Responsive.isDesktop(context)
                  ? Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.black)
                  : Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.black)),
          SizedBox(
            height: defaultPadding,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.grey,
                ),
                EventBox(
                    date: 'JULY 16',
                    title: 'Weekly Meeting & prayer',
                    time: 'Monday 07:00 AM'),
                EventBox(
                    date: 'JULY 29',
                    title: 'Show me your faith',
                    time: 'Thursday 02:00 PM'),
                EventBox(
                    date: 'SEP 19',
                    title: 'Preserverance of the Saints',
                    time: 'Saturday 10:00 AM'),
                EventBox(
                    date: 'SEP 20',
                    title: 'Worship Service',
                    time: 'Sunday 07:00 AM'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventBox extends StatelessWidget {
  final String date;
  final String title;
  final String time;
  EventBox(
      {Key? key, required this.date, required this.title, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(defaultPadding * 1.5),
      child: Column(
        children: [
          Text(
            date,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: defaultPadding * 0.5,
          ),
          Container(color: Color(0xff001242), height: 3, width: 30),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: defaultPadding),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
