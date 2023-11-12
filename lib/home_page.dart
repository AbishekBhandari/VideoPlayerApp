import 'dart:convert';
import 'dart:ffi';
import 'video_info.dart';
import 'package:flutter/material.dart';
import 'colors.dart' as color;
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((value) {
      setState(() {
        info = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: color.AppColor.homePageBackground,
          body: Container(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Training",
                        style: TextStyle(
                            fontSize: 30,
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: Container()),
                      Icon(Icons.arrow_back_ios,
                          size: 20, color: color.AppColor.homePageIcons),
                      SizedBox(width: 10),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                        color: color.AppColor.homePageIcons,
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios,
                          color: color.AppColor.homePageIcons, size: 20),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Text('Your program',
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.homePageSubtitle,
                            fontWeight: FontWeight.w700)),
                    Expanded(child: Container()),
                    Text('Details',
                        style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.homePageDetail)),
                    InkWell(
                      onTap: () {
                        Get.to(() => VideoInfo());
                      },
                      child: Icon(Icons.arrow_forward,
                          size: 28, color: color.AppColor.homePageIcons),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              color.AppColor.gradientFirst,
                              color.AppColor.gradientSecond
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(80),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(5, 10),
                              blurRadius: 20,
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.2))
                        ]),
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 25, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Next Workout',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: color
                                        .AppColor.homePageContainerTextSmall)),
                            SizedBox(height: 5),
                            Text('Legs Toning',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: color
                                        .AppColor.homePageContainerTextSmall)),
                            Text('and Glutes Workout',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: color
                                        .AppColor.homePageContainerTextSmall)),
                            SizedBox(height: 25),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.timer,
                                        size: 20,
                                        color: color.AppColor
                                            .homePageContainerTextSmall),
                                    SizedBox(width: 10),
                                    Text("60 min",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: color.AppColor
                                                .homePageContainerTextSmall)),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  color.AppColor.gradientFirst,
                                              blurRadius: 10,
                                              offset: Offset(4, 8)),
                                        ]),
                                    child: Icon(
                                        color: Colors.white,
                                        Icons.play_circle_fill)),
                              ],
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/card.jpg"),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 40,
                                  offset: Offset(8, 10),
                                  color: color.AppColor.gradientSecond
                                      .withOpacity(0.3))
                            ]),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(right: 200, bottom: 60),
                        decoration: BoxDecoration(
                            // color: Colors.redAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage("assets/figure.png"))),
                      ),
                      Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(left: 250, top: 20),
                          // color: Colors.redAccent.withOpacity(0.3),
                          child: Column(
                            children: [
                              Text('You are doing great',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: color.AppColor.homePageDetail)),
                              SizedBox(
                                height: 10,
                              ),
                              // RichText(
                              //     text: TextSpan(
                              //         text: "Keep it up",
                              //         style: TextStyle(
                              //             color: color.AppColor.homePagePlanColor,
                              //             fontSize: 16))),
                              // RichText(
                              //     text: TextSpan(
                              //         text: 'Stick to your plan',
                              //         style: TextStyle(
                              //             fontSize: 16,
                              //             color:
                              //                 color.AppColor.homePagePlanColor)))
                            ],
                          )),
                    ]),
                  ),
                  Row(children: [
                    Text('Area of Focus',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: color.AppColor.homePageTitle)),
                  ]),
                  Expanded(
                      child: ListView.builder(
                    itemCount: (info.length.toDouble() / 2).toInt(),
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(
                        children: [
                          Container(
                              width: 200,
                              height: 170,
                              padding: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(info[a]["img"])),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(5, 5),
                                      color: color.AppColor.gradientSecond
                                          .withOpacity(0.1))
                                ],
                              ),
                              child: Center(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(info[a]["title"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: color.AppColor.homePageDetail)),
                              ))),
                          Container(
                              width: 120,
                              height: 170,
                              padding: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(info[b]["img"])),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(5, 5),
                                      color: color.AppColor.gradientSecond
                                          .withOpacity(0.1))
                                ],
                              ),
                              child: Center(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(info[b]["title"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: color.AppColor.homePageDetail)),
                              ))),
                        ],
                      );
                    },
                  ))
                ],
              ))),
    );
  }
}
