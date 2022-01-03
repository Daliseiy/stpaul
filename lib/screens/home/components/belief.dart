import 'package:flutter/material.dart';
import 'package:stpaulanglicanchurh/responsive.dart';
import 'package:stpaulanglicanchurh/screens/articles/article.dart';

import '../../../constant.dart';

class BeliefSection extends StatelessWidget {
  const BeliefSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints(minHeight: 600),
      child: Row(
        children: [
          Expanded(
              child: Container(
            //color: Color(0xff1d3557),
            constraints: BoxConstraints(minHeight: 600),
            child: Center(
              child: Text(
                'O\nU\nR \nB\nE\nL\nI\nE\nF\nS',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Color(0xff001242),
                    fontWeight: FontWeight.w300,
                    height: 1.7),
              ),
            ),
          )),
          SizedBox(
            width: defaultPadding * 0.5 - 2,
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                constraints: BoxConstraints(minHeight: 600),
                color: Color(0xff001242),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xfffbfbfa),
                      height: 6,
                      width: 200,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text(
                      '\"The \n 39 \n Articles \n of \n Faith\ \n"',
                      style: Responsive.isDesktop(context)
                          ? Theme.of(context).textTheme.headline2!.copyWith(
                              color: Color(0xfffbfbfa),
                              fontSize: defaultPadding * 4.5,
                              fontWeight: FontWeight.w300)
                          : Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        padding:
                            EdgeInsets.symmetric(vertical: defaultPadding / 2),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 3))),
                        child: Text(
                          'View here',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: defaultPadding),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
