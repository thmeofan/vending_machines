import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machines/util/app_routes.dart';
import 'package:vending_machines/util/shared_pref_service.dart';

import 'blocs/vending_machine_cubit/vending_machine_cubit.dart';
import 'data/repository/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFirstTime = await OnboardingRepository().checkFirstTime();
  runApp(MyApp(isFirstLaunch: isFirstTime));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (context) => VendingMachineCubit(SharedPreferencesService()),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
      ),
    );
  }
}
