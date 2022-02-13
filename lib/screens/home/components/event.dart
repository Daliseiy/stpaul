import 'package:flutter/material.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';
import 'package:stpaulanglicanchurh/providers/data_provider.dart';

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
          FutureBuilder<List<Event>>(
            future: DataProvider()
                .fetchEvent(), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                List<Event>? data = snapshot.data;
                children = <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        ),
                        Row(
                          children: List.generate(
                              data!.length,
                              (index) => EventBox(
                                  date: data[index].date,
                                  title: data[index].title,
                                  time: data[index].time)),
                        ),
                      ],
                    ),
                  ),
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
                    child: Text('Error: ${snapshot.error}'),
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
                    child: Text('Awaiting result...'),
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
