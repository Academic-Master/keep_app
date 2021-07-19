import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keep_app/features/medecine/presentation/widgets/custom_rounded_container.dart';

class CustomListItem extends StatelessWidget {
  late final Icon icon;
  late final String name;
  late final String dose;
  late final String strength;
  final StreamController<bool> streamController = StreamController()
    ..add(false);

  CustomListItem(
      {required this.icon,
      required this.strength,
      required this.dose,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade100,
      ),
      child: ExpansionTile(
        onExpansionChanged: _switchIcon,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        // contentPadding: const EdgeInsets.symmetric(horizontal: 7),
        leading: CustomRoundedContainer(
          child: icon,
          color: Colors.white,
        ),
        title: Text(this.name),
        trailing: CustomRoundedContainer(
            child: CustomRoundedContainer(
          child: StreamBuilder<bool>(
              initialData: false,
              stream: this.streamController.stream,
              builder: (context, data) {
                return !data.data!
                    ? RotatedBox(
                        quarterTurns: 3,
                        child: Icon(Icons.arrow_forward_ios, size: 15),
                      )
                    : RotatedBox(
                        quarterTurns: 5,
                        child: Icon(Icons.arrow_forward_ios, size: 15),
                      );
              }),
          color: Colors.white,
        )),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
            child: Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                SizedBox(width: 3),
                Text(
                  'Dose: $dose',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 7),
            child: Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                SizedBox(width: 3),
                Text('Strenght: $strength',
                    style: TextStyle(color: Colors.green)),
              ],
            ),
          )
        ],
      ),
    );
  }

  _switchIcon(bool value) {
    this.streamController.add(!value);
  }
}
