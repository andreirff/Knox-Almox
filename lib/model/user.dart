class UserFields{

  static const String id = 'ID';
  static const String requester = 'Requisitante';
  static const String productLine = 'Linha';
  static const String date = 'Data';
  static const String hour = 'Hora';
  static const String itemNumber = 'Nº do Item';
  static const String product = 'Produto';
  static const String unit = 'Unidade';
  static const String quantity = 'Quantidade';
  static const String observation = 'Observação';

  static List<String> getFields() => [id, requester, productLine, date, hour, itemNumber, product, unit, quantity, observation];

}

class User {
  final int? id;
  final String requester;
  final String productLine;
  final String date;
  final String hour;
  final String itemNumber;
  final String product;
  final String unit;
  final String quantity;
  final String observation;

  const User ({
    required this.id,
    required this.requester,
    required this.productLine,
    required this.date,
    required this.hour,
    required this.itemNumber,
    required this.product,
    required this.unit,
    required this.quantity,
    required this.observation,

  });

  User copy({
    int? id,
    String? requester,
    String? productLine,
    String? date,
    String? hour,
    String? itemNumber,
    String? product,
    String? unit,
    String? quantity,
    String? observation,
  }) =>
      User(
          id: id ?? this.id,
          requester: requester ?? this.requester,
          productLine: productLine ?? this.productLine,
          date: date ?? this.date,
          hour: hour ?? this.hour,
          itemNumber: itemNumber ?? this.itemNumber,
          product: product ?? this.product,
          unit: unit ?? this.unit,
          quantity: quantity ?? this.quantity,
          observation: observation ?? this.observation,
      );

  //Map<String, dynamic> toJson() => {
  Map<String, dynamic> toJson(int index) => {
    UserFields.id: id,
    UserFields.requester: requester,
    UserFields.productLine: productLine,
    UserFields.date: date,
    UserFields.hour: hour,
    UserFields.itemNumber: itemNumber,
    UserFields.product: product,
    UserFields.unit: unit,
    UserFields.quantity: quantity,
    UserFields.observation: observation,
  };

}