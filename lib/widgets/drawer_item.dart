import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DrawerItem extends StatelessWidget {

  final bool isCurrentItem;
  final VoidCallback onClick;
  final String title;

  DrawerItem({@required this.isCurrentItem, @required this.onClick, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: InkWell(
        onTap: onClick,
        child: Text(
          title,
          style: isCurrentItem ? Theme.of(context).textTheme.title : Theme.of(context).textTheme.subtitle,
        ),
      ),
    );
  }
}
