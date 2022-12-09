import 'package:flutter/material.dart';
import 'package:goAbsensi/common/common.dart';
import 'package:goAbsensi/size_config.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.press,
  });
  final String title, subtitle;
  final IconData icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize;

    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: CircleAvatar(
        backgroundColor: primaryColor,
        child: Icon(icon, color: screenColor),
      ),
      onTap: press(),
    );
  }
}
