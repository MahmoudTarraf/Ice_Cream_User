import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/controller/providers/providers.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controller/Auth/auth.dart';
import 'view/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  final secureStorage = SecureStorageService();
  final condition = await secureStorage.getCondition();
  final thatCondition = await secureStorage.getThatCondition();
  final email = await secureStorage.getEmail();
  runApp(
    ChangeNotifierProvider<LocaleProvider>(
      create: (context) => LocaleProvider(),
      child: MyApp(
        email: email,
        condition: condition,
        thatCondition: thatCondition,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? condition;
  final String? thatCondition;
  final String? email;
  const MyApp({
    super.key,
    required this.condition,
    required this.thatCondition,
    required this.email,
  });

  Widget getHome() {
    if (email == null || email!.isEmpty) {
      return IntroViewsPage();
    }
    if (condition != null && condition!.isNotEmpty) {
      return const HomePage();
    } else {
      if (thatCondition != null && thatCondition!.isNotEmpty) {
        return const LogInScreen();
      } else {
        return IntroViewsPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Validator(),
        ),
        ChangeNotifierProvider(
          create: (context) => IceCreamProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClassicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SpecialOffersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtherStuffProvider(),
        ),
      ],
      child: MaterialApp(
        locale: localeProvider.currentLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        //home: getHome(),
        home: getHome(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
      ),
    );
  }
}
