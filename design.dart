import 'dart:async';

import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isvisible = true;
  bool isnotvisible = false;
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String time = "00:00:00";
  var owatch = Stopwatch();
  final dur = const Duration(seconds: 1);


  void startTimer()
  {
    Timer(dur, keeprunning);
  }

  void keeprunning()
  {
    if(owatch.isRunning)
    {
      startTimer();
    }
    setState(() {
      time = owatch.elapsed.inHours.toString().padLeft(2,"0") + ":" + (owatch.elapsed.inMinutes%60).toString().padLeft(2,'0') + ":" + (owatch.elapsed.inSeconds%60).toString().padLeft(2,'0');
    });
  }

  void startwatch()
  {
    setState(() {
      isvisible = !isvisible;
      isnotvisible = !isnotvisible;
      startispressed: false;
      stopispressed: false;
    });
    owatch.start();
    startTimer();

  }

  void stopwatch()
  {
    setState(() {
      stopispressed: true;
      resetispressed: false;
      isvisible = !isvisible;
      isnotvisible = !isnotvisible;
    });
    owatch.stop();
  }

  void resetwatch()
  {
    setState(() {
      stopispressed: true;
      resetispressed: true;
    });
    owatch.reset();
    time = "00:00:00";
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset('assets/bg.jpeg', height: double.infinity,fit: BoxFit.cover,),
            ),
            Column(
              children: [
                SizedBox(height: 75,),
                Container(
                  margin: EdgeInsets.only(left: 50, right: 50, top: 50),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red.shade400,width: 4)
                  ),
                  child: Text(time,style: TextStyle(color: Colors.red,fontSize: 50),),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: isvisible,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: InkWell(
                      onTap: startispressed ? startwatch : null,
                      child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    border: Border.all(color: Colors.red.shade200)
                  ),
                  child: Text("Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                      ),
                    ),
                      Visibility(
                        visible: isnotvisible,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: InkWell(
                        onTap: stopispressed ? null : stopwatch,
                        child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          border: Border.all(color: Colors.red.shade200)
                      ),
                      child: Text("Stop",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                      ),
                      ),
                    InkWell(
                      onTap: resetispressed ? null : resetwatch,
                      child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          border: Border.all(color: Colors.red.shade200)
                      ),
                      child: Text("Reset",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
              ],
            ),
          ],
        )
      ],
      ),
      ));
  }
}