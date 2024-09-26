import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knoxalmox/view/home_page.dart';
import 'constants/color_constant.dart';
import 'core/user_sheets_api.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorConstant.themeColor, // Sobreposição da cor da barra de status pela mesma cor do tema
    systemNavigationBarColor: ColorConstant.themeColor, // Sobreposição da cor da barra de navegação na mesma cor do tema
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Fixar a posição da tela em retrato
    DeviceOrientation.portraitDown, // Fixar a posição da tela em retrato
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const KnoxAlmox());
}

class KnoxAlmox extends StatelessWidget {
  const KnoxAlmox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover tag referente ao Debug Flutter
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.themeColor, // Cor Tema de Fundo
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}