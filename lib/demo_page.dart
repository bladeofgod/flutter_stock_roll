




import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget{
  final Size size;

  DemoPage(this.size);
  @override
  State<StatefulWidget> createState() {
    return DemoPageState(size);
  }

}

enum SlideDirection{
  Left,Right,Up,Down
}

class DemoPageState extends State<DemoPage> {

  final Size size;
  final double miniPageWidth;
  final double quarter;

  List<String> titles = [
    '最新','涨幅','涨跌','涨速','大单净量','总手','换手','量比'
  ];

  final double blockHeight = 40;


  //滑动方向
  SlideDirection slideDirection;

  //底层横向滚动
  ScrollController rightController;
  //ScrollController stockRowController;
  //控制左侧股票名称和右侧详情
  ScrollController stockVerticalController;
  ScrollController stockNameController;


  DemoPageState(this.size)
    : miniPageWidth = size.width/4*3,
      quarter = size.width/4;



  @override
  void initState() {

    rightController = ScrollController(
      initialScrollOffset: quarter * 2
    );
    //stockRowController = ScrollController();
    stockVerticalController = ScrollController();
    stockNameController = ScrollController();

    super.initState();
  }

  Offset lastPos;

  handleStart(DragStartDetails details){
    lastPos = details.globalPosition;
    logInfo('start', '${details.globalPosition.dx}   ${details.globalPosition.dy}');
    logInfo('start', '${stockVerticalController.offset}');
  }

  handleEnd(DragEndDetails details){
    logInfo('end', 'drag end');
  }

  handleUpdate(DragUpdateDetails details){
//    logInfo('update', 'direction   ${details.globalPosition.direction}');
//    logInfo('update', 'delta ${details.delta}');
    //logInfo('update', '${details.globalPosition.dx}---${details.globalPosition.dy}');
    if((details.globalPosition.dx - lastPos.dx).abs() > (details.globalPosition.dy - lastPos.dy).abs()){
      ///横向滑动
      if(details.globalPosition.dx > lastPos.dx){
        //向右
        slideDirection = SlideDirection.Right;
      }else{
        //向左
        slideDirection = SlideDirection.Left;
      }

    }else{
      ///纵向
      if(details.globalPosition.dy > lastPos.dy){
        //向下
        slideDirection = SlideDirection.Down;
      }else{
        //向上
        slideDirection = SlideDirection.Up;
      }
    }
    double dis = (details.globalPosition.dy - lastPos.dy).abs();
    //logInfo('distance', '$dis');
    switch(slideDirection){

      case SlideDirection.Left:
        // TODO: Handle this case.
        break;
      case SlideDirection.Right:
        // TODO: Handle this case.
        break;
      case SlideDirection.Up:

        if(stockVerticalController.offset < stockVerticalController.position.maxScrollExtent){
          stockVerticalController.jumpTo(stockVerticalController.offset+dis);
          stockNameController.jumpTo(stockNameController.offset+dis);
        }

        break;
      case SlideDirection.Down:
        if(stockVerticalController.offset > stockVerticalController.position.minScrollExtent){
          stockVerticalController.jumpTo(stockVerticalController.offset-dis);
          stockNameController.jumpTo(stockNameController.offset-dis);
        }
        break;
    }
    lastPos = details.globalPosition;
  }


  @override
  Widget build(BuildContext context) {
    //debugPrint('${MediaQuery.of(context).size}');
    return Material(
      child: GestureDetector(
        onPanStart: handleStart,
        onPanEnd: handleEnd,
        onPanUpdate: handleUpdate,
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
              child: buildStockDetail(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStockDetail(){
    return ListView.builder(
      controller: stockVerticalController,
      physics: NeverScrollableScrollPhysics(),
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
        controller: stockNameController,
        physics: NeverScrollableScrollPhysics(),
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


  logInfo(String title,String info){
    debugPrint('$title ------ $info');
  }

}























