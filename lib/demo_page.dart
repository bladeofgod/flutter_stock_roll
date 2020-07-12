




import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }

}

class DemoPageState extends State<DemoPage> {

  List<String> titles = [
    '最新','涨幅','涨跌','涨速','大单净量','总手','换手','量比'
  ];

  final double blockHeight = 30;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        color: Colors.white,
        width: size.width,height: size.height,
        child: Stack(
          children: <Widget>[
            ///left top
            Container(
              alignment: Alignment.center,
              width: size.width/4,height: blockHeight,
              child: Text('编辑',style: TextStyle(color: Colors.black),),
            ),
            ///left stock name
            buildStockName(size),
          ],
        ),
      ),
    );
  }

  Widget buildStockName(Size size){
    return Container(
      margin: EdgeInsets.only(top: blockHeight),
      width: size.width/4,height: size.height - blockHeight,
      child: ListView.builder(
          itemCount: 50,
          itemBuilder: (ctx,index){
            return Container(
              width:size.width/4,height: blockHeight,
              alignment: Alignment.center,
              child: Text('No.$index$index'),);
          }),
    );
  }



}























