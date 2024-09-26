import 'package:gsheets/gsheets.dart';
import 'package:knoxalmox/model/user.dart';

class UserSheetsApi{

  // CREDENCIAL PARA INTEGRAÇÃO COM API GOOGLE SHEETS
  static const _credentials = r'''
      {    }
  ''';

  static const _spreadsheetId = '';   // CHAVE PARA CONEXÃO COM PLANILHA NO GOOGLE SHEETS
  static final _gsheets = GSheets(_credentials);
  static final List<Worksheet?> _userSheets = []; // Lista para armazenar várias abas
  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId); // Buscar planilha pelo id

      // Lista de títulos de abas no Google Sheets
      List<String> sheetTitles = [
        'Linha 01',
        'Linha 02',
        'Linha 03',
        'Linha 04',
        'Gradeamento',
        'Reservatório',
        'Serpentina',
        'Solda',
        'Base motor',
        'Corte & dobra',
      ]; // Adicione as abas que você quiser

      for (String title in sheetTitles) {
        // Criar ou obter as planilhas (abas)
        Worksheet? sheet = await _getWorkSheet(spreadsheet, title: title);
        if (sheet != null) {
          _userSheets.add(sheet);
          final firstRow = UserFields.getFields(); // Modifique conforme necessário para cada aba
          await sheet.values.insertRow(1, firstRow); // Inserir primeira linha em cada aba
        }
      }
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async{
    try {
      // Tenta adicionar a aba, se já existir, apenas acessa
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      // Se a aba já existe, apenas retorna a aba existente
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future<int> getRowCount(int sheetIndex) async {
    if (sheetIndex >= _userSheets.length || _userSheets[sheetIndex] == null) return 0;
    final lastRow = await _userSheets[sheetIndex]!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList, int sheetIndex) async {
    if (sheetIndex >= _userSheets.length || _userSheets[sheetIndex] == null) return;
    await _userSheets[sheetIndex]!.values.map.appendRows(rowList);
  }

}