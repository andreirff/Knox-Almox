import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knoxalmox/model/user.dart';
import 'package:knoxalmox/widget/user_button_widget.dart';
import '../constants/color_constant.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  final Map<String, int> productionLineSheetIndex;
  final Function(String?) onUpdateSelectedSheetIndex;

  const UserFormWidget({
    super.key,
    required this.onSavedUser,
    required this.productionLineSheetIndex,
    required this.onUpdateSelectedSheetIndex,
  });

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();

}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> products = [];
  late TextEditingController controllerId;
  late TextEditingController controllerRequester;
  late TextEditingController controllerDate;
  late TextEditingController controllerHour;
  late TextEditingController controllerItemNumber;
  late TextEditingController controllerProduct;
  late TextEditingController controllerUnit;
  late TextEditingController controllerQuantity;
  late TextEditingController controllerObservation;
  late bool isBeginner;
  String? selectedProductionLine;
  String? selectedItemNumberLine;
  String? selectedUnit;
  int selectedSheetIndex = 0;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() {
    controllerRequester = TextEditingController();
    controllerDate = TextEditingController();
    controllerHour = TextEditingController();
    controllerItemNumber = TextEditingController();
    controllerProduct = TextEditingController();
    controllerUnit = TextEditingController();
    controllerQuantity = TextEditingController();
    controllerObservation = TextEditingController();
    isBeginner = false;
    selectedProductionLine = null;
    selectedItemNumberLine = null;
    selectedUnit = null;
  }

  @override
  Widget build(BuildContext context) => Container(
    color: ColorConstant.colorPrimarySoft,
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          //Digite o nome do requisitante, selecione o setor, a data e a hora:
          Container(
            color: ColorConstant.colorPrimarySoft,
            height: 50,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Digite o nome do requisitante, selecione o setor, a data e a hora: ',
                style: TextStyle(color: ColorConstant.themeColor),
              ),
            ),
          ),

          // Requisitante
          buildRequest(),
          const SizedBox(height: 16),

          // Setor e Nºde Item
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajusta o alinhamento dos widgets
            children: [
              Expanded (child: buildProductLineDropdown()),
              const SizedBox(width: 16),
              Expanded(child: buildItemNumber()),
            ],
          ),
          const SizedBox(height: 16),

          // Data e Hora
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajusta o alinhamento dos widgets
            children: [
              Expanded(child: buildDate()),
              const SizedBox(width: 16),
              Expanded(child: buildHour()),
            ],
          ),
          const SizedBox(height: 16),

          //Digite o nome do produto, selecione a unidade de medida e a quantidade:
          Container(
            color: ColorConstant.colorPrimarySoft,
            height: 50,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Digite o nome do produto, selecione a unidade de medida e a quantidade: ',
                style: TextStyle(color: ColorConstant.themeColor),
              ),
            ),
          ),

          // Produto e Unidade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajusta o alinhamento dos widgets
            children: [
              Expanded(child: buildProduct()),
              const SizedBox(width: 16),
              Expanded(child: buildUnit()),
            ],
          ),

          // Quantidade
          const SizedBox(height: 16),
          buildQuantityWithButtons(),

          // Botão Adicionar
          const SizedBox(height: 16),
          buildAddProductButton(),

          // Grid de Produtos
          const SizedBox(height: 16),
          buildProductList(),

          // Observação
          const SizedBox(height: 16),
          buildObservation(),

          // Revisão - Você conferiu todos os campos, antes de enviar?
          const SizedBox(height: 16),
          Container(
            color: ColorConstant.colorPrimarySoft,
            height: 50,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Conferiu todos os campos, antes de enviar?',
                style: TextStyle(color: ColorConstant.themeColor),
              ),
            ),
          ),

          // Botão Enviar
          buildSubmit(),
        ],
      ),
    ),
  );

  // Requisitante
  Widget buildRequest() => TextFormField(
    controller: controllerRequester,
    decoration: const InputDecoration(
      labelText: 'Requisitante',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Digite Requisitante' : null,
  );

  // Setor
  Widget buildProductLineDropdown() => DropdownButtonFormField<String>(
    value: selectedProductionLine,
    items: widget.productionLineSheetIndex.keys.map((line) => DropdownMenuItem(
      value: line,
      child: Text(line),
    )).toList(),
    onChanged: (value) {
      setState(() {
        selectedProductionLine = value; // Atualiza o valor selecionado
        //print("Widget - Linha de Produção Selecionada: $selectedProductionLine");
        widget.onUpdateSelectedSheetIndex(value);
        //print("Widget - Índice da Aba Atualizado: $selectedSheetIndex");
      });
    },
    decoration: const InputDecoration(
      labelText: 'Setor',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
    validator: (value) => value == null || value.isEmpty ? 'Selecione uma Linha de Produção' : null,
  );

  // Nºde Item
  Widget buildItemNumber() => DropdownButtonFormField<String>(
    value: selectedItemNumberLine,
    items: [
      'REQ 07HS',
      'REQ 10HS',
      'REQ 14HS',
      'REQ 16HS',
      ''
    ]
        .map((item) => DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    ))
        .toList(),
    onChanged: (value) {
      setState(() {
        selectedItemNumberLine = value;
      });
    },
    decoration: const InputDecoration(
      labelText: 'Nº de Item',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
    validator: (value) => value == null ? 'Selecione um Nº de Item' : null,
  );

  // Data
  Widget buildDate() => TextFormField(
    controller: controllerDate,
    decoration: InputDecoration(
      labelText: 'Data',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: const TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
      prefixIcon: IconButton(
        icon: const Icon(Icons.calendar_today),
        color: ColorConstant.themeColor,
        onPressed: () => _selectDate(context),
      ),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Digite Data' : null,
    readOnly: true,
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controllerDate.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  // Hora
  Widget buildHour() => TextFormField(
    controller: controllerHour,
    decoration: InputDecoration(
      labelText: 'Hora',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: const TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
      prefixIcon: IconButton(
        icon: const Icon(Icons.access_time),
        color: ColorConstant.themeColor,
        onPressed: () => _selectTime(context),
      ),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Digite Hora' : null,
    readOnly: true,
  );

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controllerHour.text = picked.format(context);
      });
    }
  }

  // Produto
  Widget buildProduct() => TextFormField(
    controller: controllerProduct,
    decoration: const InputDecoration(
      labelText: 'Produto',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
    //validator: (value) => value != null && value.isEmpty ? 'Digite Produto' : null,
  );

  // Unidade de Medida
  Widget buildUnit() => TextFormField(
    controller: controllerUnit,
    decoration: const InputDecoration(
      labelText: 'Unidade',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
    //validator: (value) => value != null && value.isEmpty ? 'Digite Unidade' : null,
  );

  // Quantidade
  Widget buildQuantityWithButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton.icon(
        icon: const Icon(
          Icons.remove,
          color: ColorConstant.colorTextWhite,
        ),
        label: const Text(
          '',
          style: TextStyle(
            color: ColorConstant.colorTextWhite,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.themeColor,
          foregroundColor: ColorConstant.colorTextWhite,
        ),
        onPressed: () {
          int currentQuantity = int.tryParse(controllerQuantity.text) ?? 0;
          setState(() {
            controllerQuantity.text = (currentQuantity > 0 ? currentQuantity - 1 : 0).toString();
          });
        },
      ),
      SizedBox(width: 8), // Espaço entre o botão "Diminuir" e o campo de texto
      SizedBox(
        width: 120,
        child: TextFormField(
          controller: controllerQuantity,
          decoration: const InputDecoration(
            labelText: 'Quantidade',
            filled: true,
            fillColor: ColorConstant.colorInputForm,
            labelStyle: TextStyle(
              color: ColorConstant.themeColor,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorConstant.themeColor,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorConstant.colorInputForm,
                width: 2.0,
              ),
            ),
          ),
          //validator: (value) => value != null && value.isEmpty ? 'Digite Quantidade' : null,
          keyboardType: TextInputType.number,
        ),
      ),
      SizedBox(width: 8), // Espaço entre o campo de texto e o botão "Aumentar"
      ElevatedButton.icon(
        icon: const Icon(
          Icons.add,
          color: ColorConstant.colorTextWhite,
        ),
        label: const Text(
          '',
          style: TextStyle(
            color: ColorConstant.colorTextWhite,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.themeColor,
          foregroundColor: ColorConstant.colorTextWhite,
        ),
        onPressed: () {
          int currentQuantity = int.tryParse(controllerQuantity.text) ?? 0;
          setState(() {
            controllerQuantity.text = (currentQuantity + 1).toString();
          });
        },
      ),
    ],
  );

  // Observação
  Widget buildObservation() => TextFormField(
    controller: controllerObservation,
    decoration: const InputDecoration(
      labelText: 'Observações',
      filled: true,
      fillColor: ColorConstant.colorInputForm,
      labelStyle: TextStyle(
        color: ColorConstant.themeColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.themeColor,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstant.colorInputForm,
          width: 2.0,
        ),
      ),
    ),
  );

  // Grid de Produto - Card
  Widget buildProductList() => Flexible(
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Evita que o ListView seja rolável
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        // Verifica se todos os campos necessários estão presentes
        final productName = product['name'] ?? 'Produto desconhecido';
        final quantity = product['quantity'] ?? 'Quantidade não especificada';
        final unit = product['unit'] ?? 'Unidade não especificada';

        return Container(
          width: double.infinity, // Faz o Card ocupar toda a largura disponível
          child: Card(
            color: ColorConstant.colorButtomWhite,
            elevation: 4.0,
            child: ListTile(
              title: Text('Produto: ' + product['name']),
              subtitle: Text('Quantidade: ${product['quantity']} ${product['unit']}'),
              //title: Text('Produto: $productName'),
              //subtitle: Text('Quantidade: $quantity $unit'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: ColorConstant.colorError,
                onPressed: () {
                  setState(() {
                    products.removeAt(index);
                  });
                },
              ),
            ),
          ),
        );
      },
    ),
  );

  // Adicionar Produto
  Widget buildAddProductButton() => ElevatedButton(
    onPressed: () {
      final productName = controllerProduct.text;
      final quantity = int.tryParse(controllerQuantity.text) ?? 0;
      final unit = controllerUnit.text;

      String? errorMessage;

      if (productName.isEmpty) {
        errorMessage = 'O campo "Produto" está vazio.';
      } else if (quantity <= 0) {
        errorMessage = 'O campo "Quantidade" deve ser maior que zero.';
      } else if (unit.isEmpty) {
        errorMessage = 'O campo "Unidade" está vazio.';
      }

      if (errorMessage != null) {
        // Exibe um alerta para o usuário
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao Adicionar Informações'),
              content: Text(errorMessage!),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          products.add({
            'name': productName,
            'quantity': quantity,
            'unit': unit,
          });
        });
        controllerProduct.clear();
        controllerQuantity.clear();
        controllerUnit.clear();
      }
    },
    child: const Text('Adicionar'),
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorConstant.themeColor,
      foregroundColor: ColorConstant.colorTextWhite,
    ),
  );

// Enviar ao Almoxarifado
  Widget buildSubmit() => UserButtonWidget(
    text: 'Enviar ao Almoxarifado',
    onClicked: () {
      final form = formKey.currentState!;
      final isValid = form.validate();

      if (isValid) {
        if (products.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro'),
                content: const Text('Adicione pelo menos um produto antes de enviar.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }

        // Atribua um ID ao criar o usuário, se necessário
        final userId = 1; // ou outro valor baseado na sua lógica
        final user = User(
          id: userId,
          requester: controllerRequester.text,
          productLine: selectedProductionLine ?? '',
          date: controllerDate.text,
          hour: controllerHour.text,
          itemNumber: selectedItemNumberLine ?? '',
          product: products.map((p) => p['name']).join(', '),
          unit: products.map((p) => p['unit']).join(', '),
          quantity: products.map((p) => p['quantity'].toString()).join(', '),
          observation: controllerObservation.text,
        );

        widget.onSavedUser(user);

        // Resetando os campos e limpando as listas
        form.reset();
        controllerRequester.clear();
        selectedProductionLine = null;
        controllerProduct.clear();
        controllerDate.clear();
        controllerHour.clear();
        selectedItemNumberLine = null;
        controllerProduct.clear();
        controllerUnit.clear();
        controllerQuantity.clear();
        controllerObservation.clear();
        products.clear();

        // Exibe um alerta de confirmação
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmar Requisição'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}'),
                  Text('Requisitante: ${user.requester}'),
                  Text('Setor: ${user.productLine}'),
                  Text('Data: ${user.date}'),
                  Text('Hora: ${user.hour}'),
                  Text('Nº de Item: ${user.itemNumber}'),
                  Text('Produto: ${user.product}'),
                  Text('Unidade: ${user.unit}'),
                  Text('Quantidade: ${user.quantity}'),
                  //Text('Produtos: ${user.products.join(', ')}'),    // Exibe os produtos como string
                  //Text('Unidades: ${user.units.join(', ')}'),       // Exibe as unidades como string
                  //Text('Quantidades: ${user.quantities.join(', ')}'), // Exibe as quantidades como string
                  Text('Observação: ${user.observation}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NÃO'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Requisição enviada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('SIM'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro ao Enviar Requisição'),
              content: const Text('Verifique os campos e tente novamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    },
  );

}