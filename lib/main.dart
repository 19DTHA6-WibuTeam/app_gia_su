import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gia_su_trung_tam_mobile/theme/colors.dart';
import 'package:gia_su_trung_tam_mobile/theme/theme.dart';
import 'manager/manager_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: AppColors.primary,
      theme: defaultTheme,
      initialRoute: ManagerRoutes.splashScreen,
      //MANAGERS ROUTES ALL APP
      routes: {
        ...ManagerRoutes.manager,
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

String numberWithDot(String x) {
  return x.toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
}
