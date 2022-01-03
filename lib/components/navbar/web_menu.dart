import 'package:flutter/material.dart';
import 'package:stpaulanglicanchurh/controllers/controller.dart';
import 'package:get/get.dart';
import '../../constant.dart';

class WebMenu extends StatelessWidget {
  final Color color;
  MenuController _controller = Get.put(
    MenuController(),
  );

  WebMenu({Key? key, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _controller.menuItems.length,
          (index) => WebMenuItem(
            text: _controller.menuItems[index],
            isActive: index == _controller.selectedIndex,
            color: color,
            press: () {
              _controller.setMenuIndex(index);
              Navigator.popAndPushNamed(context, _controller.route[index]);
            },
          ),
        ),
      ),
    );
  }
}

class WebMenuItem extends StatefulWidget {
  WebMenuItem({
    Key? key,
    required this.text,
    required this.isActive,
    required this.press,
    required this.color,
  }) : super(key: key);

  final String text;
  final bool isActive;
  final Color color;
  final VoidCallback press;

  @override
  _WebMenuItemState createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;

  Color _borderColor() {
    if (widget.isActive) {
      return primaryColor;
    } else if (!widget.isActive & _isHover) {
      return primaryColor.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: kDefaultDuration,
        margin: EdgeInsets.symmetric(horizontal: defaultPadding),
        padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: _borderColor(), width: 3))),
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.color,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.normal),
        ),
      ),
    );
  }
}
