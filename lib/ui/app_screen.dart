import 'package:fl_project/controllers/database_controller.dart';
import 'package:fl_project/core/my_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppScreenState();
}

class AppScreenState extends State<AppScreen> {
  final DatabaseController _databaseController = Get.find();

  @override
  void initState() {
    _databaseController.initDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Get.width * 0.08,
          backgroundColor: Colors.white,
          title: buildHeader(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => _databaseController.isLoading.value
                  ? Container(
                      width: Get.width,
                      height: Get.width * 0.1,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: Get.width * 0.1),
                    )
                  : buildBody())
            ],
          ),
        ));
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: MyConstants.columns.map((e) {
          return Expanded(
              child: Column(children: [
            Container(
                alignment: Alignment.center,
                width: Get.width * 0.2,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  child: Text(
                    e,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )),
          ]));
        }).toList(),
      ),
    );
  }

  Widget buildBody() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => ListView(
                  physics: BouncingScrollPhysics(),
                  clipBehavior: Clip.antiAlias,
                  dragStartBehavior: DragStartBehavior.start,
                  shrinkWrap: true,
                  children: _databaseController.dataList.value.map((data) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: Get.width * 0.005),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text('${data.number}'))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text('${data.code}'))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text(
                                      '${data.name}_testProjectNameTestProjectName'))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text('${data.count}'))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text('${data.price}'))),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.2,
                                  child: Text('${data.sum}'))),
                        ],
                      ),
                    );
                  }).toList(),
                ))
          ],
        ));
  }
}
