import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/model/DetailScreenModel.dart';
import 'package:model_architecture/providers/DetailsScreenProvider.dart';
import 'package:provider/provider.dart';

import 'Components/roundedCircle.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double appheight = 250;
  bool isexpanded = false;
  double _dotposition = 0;

  @override
  void initState()  {
    final provider = Provider.of<DetailScreenProvider>(
        context, listen: false);
    provider.generateColorCircles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DetailScreenModel args = ModalRoute
        .of(context)
        .settings
        .arguments;
    final provider = Provider.of<DetailScreenProvider>(
        context);

    _expandBottom() {
      print("expand bottom called");

        if (isexpanded == false) {
          appheight = appheight + 100;
          isexpanded = true;
        } else if (isexpanded == true) {
          appheight = appheight - 100;
          isexpanded = false;
        }
      provider.notifyListeners();
    }
    return Scaffold(

        body: Consumer<DetailScreenProvider>(
            builder: (context, value, child) {
              return Stack(children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: 800.0,
                      onPageChanged: (int index,
                          CarouselPageChangedReason reason) {
                        print("index is $index");
                        setState(() {
                          _dotposition = index.toDouble();
                        });
                      }),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Container(
                              child: Image.network(
                                args.imgUrl,
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                    );
                  }).toList(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DotsIndicator(dotsCount: 5,
                        position: _dotposition,
                        decorator: DotsDecorator(color: Colors.grey[400],
                            activeColor: Colors.white)),
                    AnimatedContainer(
                      duration: new Duration(milliseconds: 200),
                      height: appheight,
                      child: new Container(
                        color: Colors.transparent,
                        //could change this to Color(0xFF737373),
                        //so you don't have to change MaterialApp canvasColor
                        child: new Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(50.0),
                                    topRight: const Radius.circular(50.0))),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Container(
                                      width: 70,
                                      height: 50,
                                      child: Divider(
                                        thickness: 4,
                                        height: 20,
                                        color: Colors.grey[400],
                                      )),
                                  onTap: _expandBottom,
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(flex: 4,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 40),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Text("Woolean Coat",
                                                  textDirection: TextDirection
                                                      .ltr,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight
                                                          .w800),),
                                                Text("${value.price}")
                                              ],),
                                          ),
                                        ),
                                        Expanded(flex: 1,
                                          child: Column(
                                            children:provider.data,
                                          ),
                                        ),
                                      ]

                                  ),
                                ),

                              ],
                            )),
                      ),
                    ),
                  ],
                )
              ]);
            }
        ));
  }



}
