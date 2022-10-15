import 'package:safetech_app/core/presentation/presentation.dart';
import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/blocs/blocs.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DefaultTextStyle(
      style: TextStyle(color: AppColors.WHITE),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.PRIMARY,
            border: Border.all(color: AppColors.YELLOW),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('PRUEBA UP'),
            Row(
              children: [
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PRUEBA LEFT'),
                    Text(
                      'PRUEBA MQ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.05),
                    ),
                  ],
                ),
                const Spacer(),
                const Text('PRUEBA RIGHT'),
              ],
            ),
            const Text('PRUEBA DOWN'),
          ]),
        ),
      ),
    );
  }
}
