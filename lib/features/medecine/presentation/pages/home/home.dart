import 'package:flutter/material.dart';
import 'package:keep_app/features/medecine/presentation/widgets/custom_list_item.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            _buildGreetings(context),
            SizedBox(
              height: 40,
            ),
            Text('Get medecine results',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w800, fontSize: 18)),
            SizedBox(
              height: 25,
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (context, index) => CustomListItem(
                        description: "description",
                        icon: Icon(Icons.app_blocking),
                        skin: 'Test me',
                      )),
            ))
          ],
        ),
      ),
    );
  }

  _buildGreetings(BuildContext context) => (DateTime.now().hour > 12)
      ? Text.rich(
          TextSpan(
              text: 'Good Afternoon \n',
              children: [
                TextSpan(
                    text: 'Obed 🖖',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold))
              ],
              style: Theme.of(context).textTheme.headline6),
          // style: Theme.of(context).textTheme.headline6,
        )
      : Text.rich(
          TextSpan(
              text: 'Good Morning \n',
              children: [
                TextSpan(
                    text: 'Obed 🖖',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold))
              ],
              style: Theme.of(context).textTheme.headline6),
          // style: Theme.of(context).textTheme.headline6,
        );
}
