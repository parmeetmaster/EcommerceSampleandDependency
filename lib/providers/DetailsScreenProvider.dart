
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/screens/DetailScreen/Components/roundedCircle.dart';

class DetailScreenProvider extends ChangeNotifier{

  int activeIndex=0;
  List<Color> productColors=[Colors.red,Colors.green,Colors.amber,Colors.pinkAccent];
  List<Widget> data;

  var price="\$80";

  generateColorCircles()async {
    data=[];
    int i=0;
    for(Color item in productColors){
      if(i==0) {
        data.add(InkWell(
            onTap: (){
            changeActiveColor(item);
            },
            child: RoundedCircle( color: item, isborderActive: true)));
      }else {
        data.add(InkWell(
            onTap: (){activeIndex=i;
            changeActiveColor(item);
            },
            child: RoundedCircle( color: item, isborderActive: false)));
      }
      data.add( SizedBox(height: 10,));
      print("$i");
      i++;
    }
  }

  changeActiveColor(Color activecolor){
    data=[];
    int i=0;
    for(Color item in productColors){
      if(item==activecolor) {
        data.add(InkWell(
            onTap: (){
              changeActiveColor(item);
            },
            child: RoundedCircle( color: item, isborderActive: true)));
      }else {
        data.add(InkWell(
            onTap: (){changeActiveColor(item);},
            child: RoundedCircle(color: item, isborderActive: false)));
      }
      data.add( SizedBox(height: 10,));
   i++;
    }
   notifyListeners();
  }



}