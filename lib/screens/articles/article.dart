import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/components/navbar/footer.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/models/article.dart';

import '../../responsive.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({Key? key}) : super(key: key);

  MenuController _controller = Get.put(
    MenuController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavBar(
                color: Colors.black,
                controller: _controller,
              ),
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text('The 39 Articles of Faith',
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
