import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'colors.dart' as color;
import 'package:video_player/video_player.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  int _isPlayingIndex = -1;
  bool _isPlaying = false;
  bool _playArea = false;
  bool _disposed = false;
  VideoPlayerController? _controller;
  List videoinfo = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoinfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: _playArea == false
                ? BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Colors.greenAccent,
                        // Colors.white,
                        color.AppColor.gradientFirst,
                        color.AppColor.gradientSecond
                      ],
                      begin: FractionalOffset(0.0, 0.4),
                      end: Alignment.topRight,
                    ),
                  )
                : BoxDecoration(color: color.AppColor.gradientSecond),
            child: Column(
              children: [
                _playArea == false
                    ? Container(
                        padding: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back_ios,
                                      size: 20,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                ),
                                Expanded(child: Container()),
                                Icon(Icons.info_outline,
                                    color: color.AppColor.secondPageIconColor,
                                    size: 28)
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Legs Toning',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: color.AppColor.secondPageTitleColor),
                            ),
                            SizedBox(height: 8),
                            Text('and Glutes Workout',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        color.AppColor.secondPageTitleColor)),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                Container(
                                    width: 90,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            color.AppColor
                                                .secondPageContainerGradient1stColor,
                                            color.AppColor
                                                .secondPageContainerGradient2ndColor
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                        )),
                                    child: Row(
                                      children: [
                                        Icon(Icons.timer,
                                            size: 20,
                                            color: color
                                                .AppColor.secondPageIconColor),
                                        SizedBox(width: 5),
                                        Text('68 min',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: color.AppColor
                                                    .secondPageIconColor))
                                      ],
                                    )),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                      width: 250,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          color.AppColor
                                              .secondPageContainerGradient1stColor,
                                          color.AppColor
                                              .secondPageContainerGradient2ndColor
                                        ]),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.handyman_outlined,
                                              size: 20,
                                              color: color.AppColor
                                                  .secondPageIconColor),
                                          SizedBox(width: 5),
                                          Text('Resistant band, Kettlebell',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: color.AppColor
                                                      .secondPageIconColor)),
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                              // width: 300,
                              height: 100,
                              padding:
                                  EdgeInsets.only(top: 50, left: 30, right: 30),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.arrow_back_ios,
                                        size: 20,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Icon(Icons.info_outline,
                                      size: 20,
                                      color:
                                          color.AppColor.secondPageTopIconColor)
                                ],
                              )),
                          _playView(context),
                          _controlView(context),
                        ],
                      ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(70))),
                        child: Column(
                          children: [
                            // SizedBox(height: 30),
                            Row(children: [
                              SizedBox(width: 30.0),
                              Text('Circuit 1:Legs Toning',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: color.AppColor.circuitsColor)),
                              Text('')
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(child: _listView())
                          ],
                        )))
              ],
            )));
  }

  _listView() {
    return ListView.builder(
      itemCount: videoinfo.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: _buildCard(index));
      },
    );
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;

  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > 0) {
      return;
    }

    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller = VideoPlayerController.networkUrl(
        Uri.parse(videoinfo[index]['videoUrl']));
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(child: Text('Being initialized plz wait')));
    }
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value?.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 2.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: Colors.redAccent,
            overlayColor: Colors.red.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorColor: Colors.redAccent,
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorTextStyle: TextStyle(color: Colors.white),
          ),
          child: Slider(
            value: max(0, min(_progress * 100, 100)),
            min: 0,
            max: 100,
            divisions: 100,
            label: _position?.toString().split(".")[0],
            onChanged: (value) {
              setState(() {
                _progress = value * 0.01;
              });
            },
            onChangeStart: (value) {
              _controller?.pause();
            },
            onChangeEnd: (value) {
              final duration = _controller?.value?.duration;
              if (duration != null) {
                var newValue = max(0, min(value, 99)) * 0.01;
                var millis = (duration.inMilliseconds * newValue).toInt();
                _controller?.seekTo(Duration(milliseconds: millis));
                _controller?.play();
              }
            },
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 5),
          color: color.AppColor.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (noMute) {
                      _controller?.setVolume(0);
                    } else {
                      _controller?.setVolume(1.0);
                    }
                    setState(() {});
                  },
                  child: Icon(noMute ? Icons.volume_up : Icons.volume_off,
                      size: 20, color: Colors.white)),
              ElevatedButton(
                  onPressed: () async {
                    final index = _isPlayingIndex - 1;
                    if (index >= 0 && videoinfo.length >= 0) {
                      _initializeVideo(index);
                    } else {
                      Get.snackbar(
                        "Video",
                        "",
                        snackPosition: SnackPosition.TOP,
                        icon: Icon(Icons.face, size: 30, color: Colors.white),
                        colorText: Colors.white,
                        messageText: Text("No more videos to play",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: color.AppColor.gradientSecond,
                      );
                    }
                  },
                  child:
                      Icon(Icons.fast_rewind, size: 36, color: Colors.white)),
              ElevatedButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      _controller?.pause();
                      setState(() {
                        _isPlaying = false;
                      });
                    } else {
                      _controller?.play();
                      setState(() {
                        _isPlaying = true;
                      });
                    }
                  },
                  child: _isPlaying == false
                      ? Icon(Icons.play_arrow, size: 36, color: Colors.white)
                      : Icon(Icons.pause_circle_filled,
                          size: 36, color: Colors.white)),
              ElevatedButton(
                  onPressed: () {
                    final index = _isPlayingIndex + 1;
                    if (index <= videoinfo.length - 1) {
                      _initializeVideo(index);
                    } else {
                      Get.snackbar(
                        "Video List",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(Icons.face, size: 30, color: Colors.white),
                        backgroundColor: color.AppColor.gradientSecond,
                        colorText: Colors.white,
                        messageText: Text("You have watched all the videos",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      );
                    }
                  },
                  child:
                      Icon(Icons.fast_forward, size: 36, color: Colors.white)),
              Text('$mins: $secs',
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(150, 0, 0, 0))
                  ]))
            ],
          ),
        ),
      ],
    );
  }

  _buildCard(int index) {
    return Container(
        height: 135,
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(videoinfo[index]["thumbnail"]),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(videoinfo[index]["title"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(videoinfo[index]['time'])),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("15s rest",
                      style: TextStyle(color: Color(0xFF839fed))),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 80; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFF839fed),
                              borderRadius: BorderRadius.circular(2),
                            ))
                        : Container(
                            height: 1,
                            width: 3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                          )
                ],
              )
            ],
          ),
        ]));
  }
}
