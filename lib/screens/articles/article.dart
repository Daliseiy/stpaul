import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/components/navbar/footer.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/models/article.dart';

import '../../responsive.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
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
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff001242),
                child: Column(
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
                    SizedBox(height: defaultPadding * 3),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text('The 39 Articles of Faith',
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
                    ),
                    SizedBox(
                      height: defaultPadding * 3,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(defaultPadding),
                constraints: BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      articles.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding + 2),
                            child: ArticlesText(article: articles[index]),
                          )),
                ),
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}

class ArticlesText extends StatelessWidget {
  final Articles article;
  ArticlesText({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: defaultPadding + 2),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Text(
          article.body,
          style: TextStyle(fontSize: defaultPadding),
        ),
      ],
    );
  }
}
