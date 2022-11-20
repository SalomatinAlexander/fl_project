import 'dart:ffi';

class ProductData {
  final int number;
  final String code;
  final String name;
  final int count;
  final String price;
  final String sum;

  ProductData({required this.number, required this.code,
    required this.name, required this.count, required this.price,
    required this.sum});


  factory ProductData.fromMap({required Map map}) {
    return ProductData(number: map['number'],
        code: map['code'],
        name: map['name'],
        count: map['count'],
        price: map['price'],
        sum: map['sum']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': this.number,
      'code': this.code,
      'name': this.name,
      'count': this.count,
      'price': this.price,
      'sum': this.sum,
    };
  }
}
