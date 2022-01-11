import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stpaulanglicanchurh/components/navbar/footer.dart';
import 'package:stpaulanglicanchurh/components/navbar/navigation_bar.dart';
import 'package:stpaulanglicanchurh/components/navbar/side_menu.dart';
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:stpaulanglicanchurh/screens/home/components/contact.dart';

import '../../responsive.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);
  MenuController _controller = Get.put(
    MenuController(),
  );

  var text =
      'St. Pual\'s Anglican Church  Odo-Ona Ibadan started as a small fellowship in the small sitting room of Pa Samuel Adepoju in the Junior Staff quarters of Agricultural Department in Moor Plantation in 1911. The founding fathers and mothers faced persecution by a zealous expatriate who destroyed their thatched roof shed built for worship. This forced these faithful ones to relocate to  Ayede quarters, it was named Ayede quarters because the inabitants of that area were farmers mainly from Ayede Ekiti, more members were added to the number and this became a parish Church. \nIn 1917, a permanent site was acquired through the efforts of Pa Olugbode, Pa Tajo and the then Archdeacon of Ibadan the Venerable Archdeacon S.V Latunde who later christened it St. Paul\'s Church under the patronal name of Saint Paul the great Apostle. \nIt can be concluded that St, Paul\'s Anglican Church Odo Ona the seat of Odo Ona Archdeacony has given birth to other three Archdeaconries in the Diocese, these are Irepo Archdeaconry, Ibarapa Archdeaconry and Oluyole Extension Archdeaconry. At the moment the remaining parishes under Odo Ona Archdeaconry are St. Paul\'s Odo Ona, St James Idi-Oro Elewa, St James Isoko/Urhobo, St John\'s Church Ido, St.Jude\'s Gbekuba and Canon Babatunde Memorial Olorunlogbon Quarters.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: !Responsive.isDesktop(context) ? SideMenu() : Drawer(),
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff001242),
              child: Column(
                children: [
                  NavBar(
                    color: Colors.white,
                    controller: _controller,
                  ),
                  SizedBox(height: defaultPadding * 3),
                  Text(
                    'About us',
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
                  )
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 1000),
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: Responsive.isDesktop(context)
                        ? defaultPadding * 2
                        : defaultPadding),
              ),
            ),
            Text(
              'Gallery',
              style: Responsive.isDesktop(context)
                  ? Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.black)
                  : Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.black),
            ),
            ImageGrid(),
            SizedBox(
              height: defaultPadding,
            ),
            ContactSection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  ImageGrid({Key? key}) : super(key: key);

  List images = [
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/1_tuijr6.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/2_t7zlcy.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/3_vfl1kd.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/4_pougtp.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/6_rxf5rz.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479759/stpaul/7_xftqlo.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479760/stpaul/8_s4s4an.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479759/stpaul/9_k6kv8j.jpg',
    'https://res.cloudinary.com/daliseiy/image/upload/v1641479759/stpaul/10_ixmf02.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1000),
      padding: EdgeInsets.all(defaultPadding),
      child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
              //maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding),
          itemCount: images.length,
          itemBuilder: (ctx, index) {
            return Image.network(images[index]);
          }),
    );
  }
}
