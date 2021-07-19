import 'package:flutter/material.dart';
import 'package:keep_app/features/medecine/presentation/widgets/custom_rounded_container.dart';

class CustomListItem extends StatelessWidget {
  late final Icon icon;
  late final String skin;
  late final String description;

  CustomListItem(
      {required this.icon, required this.skin, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        // contentPadding: const EdgeInsets.symmetric(horizontal: 7),
        leading: CustomRoundedContainer(
          child: icon,
          color: Colors.white,
        ),
        title: Text(this.skin),
        trailing: CustomRoundedContainer(
            child: CustomRoundedContainer(
          child: Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
          color: Colors.white,
        )),
        children: [Text('sdsdfdfdf')],
      ),
    );
  }
}
