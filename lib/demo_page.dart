




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
  ScrollController stockRowController;

  DemoPageState(this.size)
    : miniPageWidth = size.width/4*3,
      quarter = size.width/4;



  @override
  void initState() {

    rightController = ScrollController(
      initialScrollOffset: quarter * 2
    );
    stockRowController = ScrollController();

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
            ///bottom part
            buildBottomPart(size),
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

  buildBottomPart(Size size){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: rightController,
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: blockHeight),
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
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: buildStockDetail(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStockDetail(){
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: 50,
      itemBuilder: (ctx,index){
        return Container(
          width: quarter * titles.length,height: blockHeight,
          child: stockDetail(index),
        );
      },
    );
  }

  Widget stockDetail(int index){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,
      children: List.generate(titles.length, (index){
        return Container(
          color: index % 2 == 0 ? Colors.yellow : Colors.purple,
          width:quarter,height: blockHeight,
          alignment: Alignment.center,
          child: Text('$index.2%'),);
      }),
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























