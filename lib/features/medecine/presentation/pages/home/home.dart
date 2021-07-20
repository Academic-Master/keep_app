import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:keep_app/core/widgets/custom_loader.dart';
import 'package:keep_app/features/auth/domain/entities/user.dart';
import 'package:keep_app/features/medecine/presentation/bloc/medecine_bloc.dart';
import 'package:keep_app/features/medecine/presentation/widgets/custom_list_item.dart';

import '../../../../../dependency_injection.dart';

class Home extends StatelessWidget {
  late final FeatureAuthDependencies featureAuthDependencies;

  Home({required this.featureAuthDependencies});

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
            FutureBuilder<Either<LocalDatabaseException, User>>(
              future:
                  this.featureAuthDependencies.localAuthRepository.getUser(),
              builder: (context, data) {
                if (data.hasData && data.data!.isRight())
                  return _buildGreetings(context, data.data!);
                return Center(
                  child: Text('An Error Occured'),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text('Get medecine results',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.w800)),
            SizedBox(
              height: 25,
            ),
            Expanded(child: Container(
              child: BlocBuilder<MedecineBloc, MedecineState>(
                  builder: (context, data) {
                if (data is GotMedecinesList) {
                  print(data.medecines.map((e) => e));
                  return ListView.builder(
                      itemCount: data.medecines.length,
                      itemBuilder: (context, index) => CustomListItem(
                            dose: data.medecines[index].dose,
                            icon: Icon(Icons.healing),
                            name: data.medecines[index].name,
                            strength: data.medecines[index].strength,
                          ));
                } else if (data is IsLoadingState) {
                  print('Hemm');
                  return CustomLoader('Loading ...');
                }
                return Container();
              }),
            ))
          ],
        ),
      ),
    );
  }

  _buildGreetings(
          BuildContext context, Either<LocalDatabaseException, User> data) =>
      (DateTime.now().hour > 12)
          ? Text.rich(
              TextSpan(
                  text: 'Good Afternoon \n',
                  children: [
                    TextSpan(
                        text:
                            '${data.fold((l) => null, (r) => r)!.username} 🖖',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 11))
                  ],
                  style: Theme.of(context).textTheme.headline5),
              // style: Theme.of(context).textTheme.headline6,
            )
          : Text.rich(
              TextSpan(
                  text: 'Good Morning \n',
                  children: [
                    TextSpan(
                        text:
                            '${data.fold((l) => null, (r) => r)!.username} 🖖\n${data.fold((l) => null, (r) => r)!.email}',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 11))
                  ],
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.black)),
              // style: Theme.of(context).textTheme.headline6,
            );
}
