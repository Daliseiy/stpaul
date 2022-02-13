import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../responsive.dart';

class ActivitySection extends StatelessWidget {
  const ActivitySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding * 1.5),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.transparent
          //image: DecorationImage(
          //image: NetworkImage(
          //  'https://res.cloudinary.com/daliseiy/image/upload/v1641914406/stpaul/event2_d3dpqk.jpg'),
          //fit: BoxFit.cover,
          //colorFilter:
          //    ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
          //)
          ),
      child: Column(
        children: [
          Text('Our Weekly Activities',
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
          SizedBox(
            height: defaultPadding * 1.5,
          ),
          Responsive.isDesktop(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ActivityBox(
                          time: 'Mondays 5pm - 7pm',
                          title: 'Evangelism',
                          details:
                              'We preach the Gospel \nof christ and have intentional \nand strategic partners that do this with us.'),
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Expanded(
                      child: ActivityBox(
                          time: 'Tuesday 4pm - 6:30pm',
                          title: 'Spirit Filled Worship',
                          details:
                              'Our weekday and gatherings \ntake a lot of people to make them \nwork, from ushers to greeters, youth and others.'),
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Expanded(
                      child: ActivityBox(
                          time: 'Friday 6pm - 8pm',
                          title: 'Youth Ministry',
                          details:
                              'We believe God has \ncalled us to be a church that develops \nyouth and trains their hears to be with Jesus Christ'),
                    )
                  ],
                )
              : Column(
                  children: [
                    ActivityBox(
                        time: 'Mondays 5pm - 7pm',
                        title: 'Evangelism',
                        details:
                            'We preach the Gospel \nof christ and have intentional \nand strategic partners that do this with us.'),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    ActivityBox(
                        time: 'Tuesday 4pm - 6:30pm',
                        title: 'Spirit Filled Worship',
                        details:
                            'Our weekday and gatherings \ntake a lot of people to make them \nwork, from ushers to greeters, youth and others.'),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    ActivityBox(
                        time: 'Friday 6pm - 8pm',
                        title: 'Youth Ministry',
                        details:
                            'We believe God has \ncalled us to be a church that develops \nyouth and trains their hears to be with Jesus Christ'),
                  ],
                )
        ],
      ),
    );
  }
}

class ActivityBox extends StatelessWidget {
  final String time;
  final String title;
  final String details;
  ActivityBox(
      {Key? key,
      required this.time,
      required this.title,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      height: 350,
      width: 350,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding * 1.5),
            child: Text(details,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: defaultPadding,
                    height: 1.5,
                    color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding * 1.5),
            child: Text(time,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: defaultPadding,
                    height: 1.5,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
