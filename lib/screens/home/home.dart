import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stpaulanglicanchurh/components/navbar/footer.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/controllers/home_controller.dart';
import 'package:stpaulanglicanchurh/responsive.dart';
import 'package:stpaulanglicanchurh/screens/articles/article.dart';
import 'package:stpaulanglicanchurh/screens/form/burial.dart';
import 'package:stpaulanglicanchurh/screens/home/components/activity.dart';
import 'package:stpaulanglicanchurh/screens/home/components/belief.dart';
import 'package:stpaulanglicanchurh/screens/home/components/contact.dart';

import 'components/event.dart';
import 'components/testimony.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _scaffoldKey.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !Responsive.isDesktop(context) ? SideMenu() : null,
      drawerEnableOpenDragGesture: false,
      key: _scaffoldKey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? defaultPadding * 10
                      : defaultPadding,
                  vertical: defaultPadding),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://res.cloudinary.com/daliseiy/image/upload/v1646823836/stpaul/gettyimages-584533472-594x594_iosnes.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              onPressed: () {
                                if (_scaffoldKey.currentState!.isDrawerOpen) {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                } else {
                                  _scaffoldKey.currentState!.openDrawer();
                                }
                              },
                              icon: Icon(Icons.menu),
                              color: Colors.white,
                              iconSize: 32,
                            ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                            child: NavBar(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding * 3.5,
                      ),
                      Text(
                        'We are a church that believes in Jesus & loves God.',
                        textAlign: TextAlign.center,
                        style: Responsive.isDesktop(context)
                            ? Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white)
                            : Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: defaultPadding * 3,
                      ),
                      Text(
                        'The pupose of our church community is to worship the Glory of God. We live to be called to speak, think and work by remembering the gospel. Join us in preaching praying and teaching his word!!.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: Responsive.isDesktop(context)
                                ? defaultPadding * 1.5
                                : defaultPadding * 1.5),
                      ),
                      SizedBox(
                        height: defaultPadding * 3,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () => Navigator.pushNamed(context, 'about'),
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text(
                            'ABOUT US',
                            style: TextStyle(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultPadding * 2,
                      ),
                      ActivitySection(),
                    ],
                  ),
                ],
              ),
            ),
            //BeliefSection(),
            NewBeliefSection(),
            EventSection(),
            TestimonySection(),
            BurialSection(),
            PastorWelcomeSection(),
            ContactSection(),
            Footer(),
          ],
        ),
      )),
    );
  }
}

class NewBeliefSection extends StatelessWidget {
  NewBeliefSection({
    Key? key,
  }) : super(key: key);
  List children = <Widget>[];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        margin: EdgeInsets.all(defaultPadding),
        constraints: BoxConstraints(maxWidth: 1000),
        child: Responsive.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      'Our\nBeliefs.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 6.5 * defaultPadding),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Transform.rotate(
                          angle: -math.pi / 25,
                          child: Container(
                            height: 500,
                            width: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              color: Color(0xff001242),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(defaultPadding * 1.5),
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'The 39 Articles of Faith',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                'The 39 Articles are a brief and condensed statement of what Anglican Christians believe and teach.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: defaultPadding),
                                  padding: EdgeInsets.symmetric(
                                      vertical: defaultPadding / 2),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 3))),
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
                        )
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  Text(
                    'Our\nBeliefs.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 4.5 * defaultPadding),
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Stack(
                    children: [
                      Transform.rotate(
                        angle: -math.pi / 25,
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            color: Color(0xff001242),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(defaultPadding * 1.5),
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The 39 Articles of Faith',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'The 39 Articles are a brief and condensed statement of what Anglican Christians believe and teach.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                padding: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 2),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white, width: 3))),
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
                      )
                    ],
                  ),
                ],
              ));
  }
}

class PastorWelcomeSection extends StatelessWidget {
  const PastorWelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 1000),
        padding: EdgeInsets.all(defaultPadding),
        child: Responsive.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        'You matter to God. You matter to us.',
                        style:
                            Theme.of(context).textTheme.headline2!.copyWith(),
                      ),
                      SizedBox(
                        height: defaultPadding * 1.5,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod'
                        'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'
                        'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo'
                        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse'
                        'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non'
                        'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/event3.jpg'))),
                      ),
                      Text(
                        'Bishop Balogun Vincent',
                        style:
                            Theme.of(context).textTheme.headline5!.copyWith(),
                      ),
                    ],
                  ))
                ],
              )
            : Column(
                children: [
                  Text(
                    'You matter to God. You matter to us.',
                    style: Theme.of(context).textTheme.headline2!.copyWith(),
                  ),
                  SizedBox(
                    height: defaultPadding * 1.5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod'
                    'tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'
                    'quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo'
                    'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse'
                    'cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non'
                    'proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                  ),
                  Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/event3.jpg'))),
                  ),
                  Text(
                    'Bishop Balogun Vincent',
                    style: Theme.of(context).textTheme.headline5!.copyWith(),
                  ),
                ],
              ));
  }
}

class BurialSection extends StatelessWidget {
  const BurialSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(defaultPadding),
      constraints: BoxConstraints(maxWidth: 1000),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffc5c8c9), width: 0.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            child: Text(
              '2 Corinthians 5:8',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffc5c8c9),
                  fontSize: 12,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'A Proper\nHomecoming',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Get a proper burial or wake keep service for your late \nloved one\'s through this ministry.',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: Color(0xffc5c8c9),
              fontSize: Responsive.isMobile(context) ? 12 : 12,
            ),
          ),
          SizedBox(
            height: 64,
          ),
          FittedBox(
            child: MaterialButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => BurialForm())),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff001242)),
                borderRadius: BorderRadius.circular(25),
              ),
              hoverColor: Colors.blue.shade900.withOpacity(0.3),
              hoverElevation: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text('APPLY',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
