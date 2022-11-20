import 'dart:math';

import 'package:fl_project/domain/data/product_data.dart';
import 'package:get/get.dart';

import '../domain/repository/database_helper.dart';

class DatabaseController extends GetxController{
  Rx<List<ProductData>> dataList = Rx<List<ProductData>>([]);
  RxBool isLoading = false.obs;
  final databaseHelper = DatabaseHelper.instance;

  initDataBase()async{
    isLoading.value = true;
    List<Map<String, dynamic>> list = await databaseHelper.queryAllRows();
    dataList.value = list.map((e) {
      return ProductData.fromMap(map: e);
    }).toList();
    if(list.isEmpty){
      await insertData();
      initDataBase();
    }
    isLoading.value = false;
  }

  insertData()async{
    for(int i = 0; i<1000; i++){
      databaseHelper.insert(ProductData(number: i,
          code: "${i} code",
          name: "${i} name", count: Random().nextInt(100),
          price: "${Random().nextInt(10)*2}",
          sum: "${Random().nextInt(10)/2}").toMap());
    }
  }




}