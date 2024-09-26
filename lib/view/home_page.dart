import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/text_constant.dart';
import '../core/user_sheets_api.dart';
import '../widget/user_form_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedSheetIndex = 0; // Variável para armazenar o índice da aba selecionada
  String? selectedProductionLine; // Variável para armazenar o valor selecionado no dropdown
  Map<String, int> productionLineSheetIndex = {
    'Linha 01': 0,
    'Linha 02': 1,
    'Linha 03': 2,
    'Linha 04': 3,
    'Gradeamento': 4,
    'Reservatório': 5,
    'Serpentina': 6,
    'Solda': 7,
    'Base motor': 8,
    'Corte & dobra': 9,
    //'': 0, // Default case
  };

  void updateSelectedSheetIndex(String? value) {
    if (value != null && productionLineSheetIndex.containsKey(value)) {
      setState(() {
        selectedProductionLine = value; // Atualiza o valor selecionado
        selectedSheetIndex = productionLineSheetIndex[value]!; // Atualiza o índice da aba
        //print("Home - Índice da Aba Atualizado: $selectedSheetIndex");
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(

    // SEÇÃO 1
    body: ListView(

        children: [
          // Título: Requisição de Material no Almoxarifado
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: const Text(
              TextConstant.textAppTitle,
              style: TextStyle(
                color: ColorConstant.colorTextWhite,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),

          //  Versionamento: RADM 007
          Container(
            alignment: Alignment.topRight,
            child: const Text(
              TextConstant.textForm,
              style: TextStyle(
                color: ColorConstant.colorTextWhite,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),

          //  Versionamento: Revisão 05
          Container(
            alignment: Alignment.topRight,
            child: const Text(
              TextConstant.textFormRevision,
              style: TextStyle(
                color: ColorConstant.colorTextWhite,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),

          //  Versionamento: Data 05/06/2024
          Container(
            alignment: Alignment.topRight,
            child: const Text(
              TextConstant.textFormDate,
              style: TextStyle(
                color: ColorConstant.colorTextWhite,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),

          // SUB-SEÇÃO
          // Função que insere os dados na aba correta
          UserFormWidget(
            onSavedUser: (user) async {
              final id = await UserSheetsApi.getRowCount(selectedSheetIndex) + 1;
              final newUser = user.copy(id: id);
              //await UserSheetsApi.insert([newUser.toJson()], selectedSheetIndex);
              //print(newUser.toJson()); // Para ver os dados que estão sendo enviados// Insere na aba correta

              // Criar uma linha nova com as informações individuais
              final newRow = newUser.toJson(0); // '0' pois estamos inserindo uma linha individual por vez
              // Insere cada linha na aba correta (selectedSheetIndex)
              await UserSheetsApi.insert([newRow], selectedSheetIndex);

            },
            productionLineSheetIndex: productionLineSheetIndex, // Passa o mapeamento
            onUpdateSelectedSheetIndex: updateSelectedSheetIndex, // Passa a função de callback
          ),
        ]
    ),

    // SEÇÃO 2
    bottomNavigationBar: Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      alignment: Alignment.center,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TextConstant.textDeveloped,
            style: TextStyle(
              color: ColorConstant.colorTextWhite,
              fontSize: 14,
              //fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      //),
    ),
  );

}