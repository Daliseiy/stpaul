import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/components/navbar/footer.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/responsive.dart';
import 'package:stpaulanglicanchurh/screens/home/components/activity.dart';
import 'package:stpaulanglicanchurh/screens/home/components/belief.dart';
import 'package:stpaulanglicanchurh/screens/home/components/contact.dart';

import 'components/event.dart';
import 'components/testimony.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  MenuController _controller = Get.put(
    MenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
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
                  image: AssetImage('assets/images/header.jpg'),
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
                      NavBar(
                        color: Colors.white,
                        controller: _controller,
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
                        'The pupose of our church community is to worship the Glory of God. We live to be called to speak, think and work by remembering the gospel. Join us in preaching praying and teaching His Word! where they are.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: defaultPadding * 3,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {},
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
                      )
                    ],
                  ),
                ],
              ),
            ),
            BeliefSection(),
            ActivitySection(),
            EventSection(),
            TestimonySection(),
            PastorWelcomeSection(),
            ContactSection(),
            Footer(),
          ],
        ),
      )),
    );
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
