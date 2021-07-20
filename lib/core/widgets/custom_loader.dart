import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  late final String message;

  CustomLoader(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.grey.shade100,
                offset: Offset(1, 2))
          ]),
      padding: EdgeInsets.all(20),
      child: Center(
          child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  message,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
