




import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget{
  final Size size;

  DemoPage(this.size);
  @override
  State<StatefulWidget> createState() {
    return DemoPageState(size);
  }

}

class DemoPageState extends State<DemoPage> {

  final Size size;
  final double miniPageWidth;
  final double quarter;

  List<String> titles = [
    '最新','涨幅','涨跌','涨速','大单净量','总手','换手','量比'
  ];

  final double blockHeight = 40;

  ScrollController rightController;

  DemoPageState(this.size)
    : miniPageWidth = size.width/4*3,
      quarter = size.width/4;



  @override
  void initState() {

    rightController = ScrollController(
      initialScrollOffset: quarter * 2
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Material(
      child: Container(
        padding: MediaQuery.of(context).padding,
        color: Colors.white,
        width: size.width,height: size.height,
        child: Stack(
          children: <Widget>[
            ///right part
            buildRightPart(size),
            ///left top
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              width: quarter,height: blockHeight,
              child: Text('编辑',style: TextStyle(color: Colors.black),),
            ),
            ///left stock name
            buildStockName(size),


          ],
        ),
      ),
    );
  }

  buildRightPart(Size size){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: rightController,
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: quarter*7,height: size.height,
        child: Row(
          children: <Widget>[
            ///left
            Container(
              width: miniPageWidth,height: size.height,
              color: Colors.red,
            ),
            ///right
            Container(
              width: miniPageWidth,height: size.height,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStockName(Size size){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: blockHeight),
      width: quarter,height: size.height - blockHeight,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
          itemCount: 50,
          itemBuilder: (ctx,index){
            return Container(
              width:quarter,height: blockHeight,
              alignment: Alignment.center,
              child: Text('No.600$index'),);
          }),
    );
  }



}























