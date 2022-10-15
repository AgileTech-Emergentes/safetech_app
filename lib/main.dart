import 'package:safetech_app/modules/auth/domain/domain.dart';
import 'package:safetech_app/modules/auth/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:safetech_app/core/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safetech_app/modules/auth/infrastructure/infrastructure.dart'
as auth;
import 'package:safetech_app/pages/home_user.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  //inyeccion de dependencias
  auth.initializeDependencies();

  runApp(App(
    streamRepository: StreamRepository(),
  ));
}

class App extends StatelessWidget {
  final StreamRepository streamRepository;

  const App({
    Key? key,
    required this.streamRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: streamRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(streamRepository: streamRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState get _navigator => Navigators.mainNav.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigators.mainNav,
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY,
        backgroundColor: AppColors.SECONDARY,
        hintColor: AppColors.BLACK,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            fontSize: 15.0,
          ),
          bodyText1: TextStyle(
            fontSize: 15.0,
          ),
          bodyText2: TextStyle(
            fontSize: 13.0,
          ),
          headline5: TextStyle(
            color: AppColors.BLACK_SECONDARY,
            fontSize: 13.0,
          ),
          headline6: TextStyle(
            fontSize: 10.0,
          ),
          button: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: AppColors.BLUE_PRIMARY,
              elevation: 0,
              shape: const StadiumBorder()),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: AppColors.BLACK,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: AppColors.BLUE_PRIMARY,
            side: const BorderSide(
              color: AppColors.BLUE_PRIMARY,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.BLACK),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.BLACK),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.RED),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.RED),
          ),
        ),
      ),
      builder: (_, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: _buildAuthBlocListener,
          child: child,
        );
      },
      onGenerateRoute: (_) => LoadingPage.route(),
    );
  }

  void _buildAuthBlocListener(
      BuildContext context,
      AuthState state,
      ) async {
    //  if (state.status.isUnauthenticated) {
    if (state.status.isAuthenticated) {
      _navigator.pushAndRemoveUntil<void>(
        MaterialPageRoute<void>(builder: (_) => const Home_user()),
            (route) => false,
      );
      //  } else if (state.status.isAuthenticated) {
    } else if (state.status.isUnauthenticated) {
      _navigator.pushAndRemoveUntil<void>(
        MaterialPageRoute<void>(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }
  }
}
