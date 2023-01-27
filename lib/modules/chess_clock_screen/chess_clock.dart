import 'dart:async';

import 'package:flutter/material.dart';

int i = 0;
List<int> times = [1,3,5,10,15,30];

int switch1 = 0;
bool isPause = false;
int moves1 = 0;
int moves2 = 0;

int click1 = 0;
int click2 = 0;


int time = 10;

Duration duration1 = Duration(minutes: time);
Duration duration2 = Duration(minutes: time);

Timer? timer1 = Timer(duration1,() {});
Timer? timer2 = Timer(duration2, () {});


String strDigits(int n) => n.toString().padLeft(2, '0');


class ChessClock extends StatefulWidget {
  const ChessClock({Key? key}) : super(key: key);

  @override
  State<ChessClock> createState() => _ChessClockState();
}


class _ChessClockState extends State<ChessClock> {

  void resetTimer() {
    stopTimer1();
    stopTimer2();
    setState(() => duration1 = Duration(minutes: time));
    setState(() => duration2 = Duration(minutes: time));
  }

  void startTimer1( ) {
    timer1 = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown1());
  }
  void setCountDown1( ) {
    const reduceSecondsBy = 1;

    setState(() {
      final seconds = duration1.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer1!.cancel();
      } else {
        duration1 = Duration(seconds: seconds);
      }
    });

  }
  void stopTimer1() {
    setState(() => timer1!.cancel());
  }

  void startTimer2( ) {
    timer2 = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown2());
  }
  void setCountDown2( ) {
    const reduceSecondsBy = 1;

    setState(() {
      final seconds = duration2.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer2!.cancel();
      } else {
        duration2 = Duration(seconds: seconds);
      }
    });
  }
  void stopTimer2() {
    setState(() => timer2!.cancel());
  }


  @override
  Widget build(BuildContext context) {

    final minutes1 = strDigits(duration1.inMinutes.remainder(60));
    final seconds1 = strDigits(duration1.inSeconds.remainder(60));

    final minutes2 = strDigits(duration2.inMinutes.remainder(60));
    final seconds2 = strDigits(duration2.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Clock'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[500],
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    if(!isPause) {
                      click1++;
                      switch1 = 2;
                      if (click1 == 1) {
                        setState(() {
                          startTimer2();
                          stopTimer1();
                          moves1++;
                          click2 = 0;
                        });
                      }
                    }
                    },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: switch1 == 1? Colors.green:Colors.grey[500],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: Text(
                              "$minutes1:$seconds1",
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: switch1 == 1? Colors.white:Colors.black,
                              fontSize: 70,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            resetTimer();
                            switch1 = 0;
                          },
                          child:const Icon(
                            Icons.restart_alt,
                            size: 70,
                            color: Colors.white54,
                        ),
                        ),
                        const SizedBox(width: 20,),
                        MaterialButton(onPressed: () {
                          isPause = !isPause;
                          if(isPause) {
                            stopTimer1();
                            stopTimer2();
                          }else{
                            if(switch1 == 1) {
                              startTimer1();
                            } else if(switch1 == 2) {
                              startTimer2();
                            }
                          }

                        },
                          child:isPause ?const Icon(
                            Icons.not_started_outlined,
                            size: 70,
                            color: Colors.white54,
                          ):const Icon(
                            Icons.pause,
                            size: 70,
                            color: Colors.white54,
                          ),

                        ),
                        const SizedBox(width: 20,),
                        MaterialButton(onPressed: () {
                          setState(() {
                            time = times[ i % times.length];
                            ++i;
                            resetTimer();
                          });
                          },
                          child:const Icon(
                            Icons.timer_sharp,
                            size: 70,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: MaterialButton(

                  onPressed: () {
                    if(!isPause) {
                      click2++;
                      switch1 = 1;
                      if (click2 == 1) {
                        setState(() {
                          startTimer1();
                          stopTimer2();
                          moves2++;
                          click1 = 0;
                        });
                      }
                    }
                    },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: switch1 == 2 ? Colors.green:Colors.grey[500],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$minutes2:$seconds2",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: switch1 == 2 ? Colors.white:Colors.black,
                              fontSize: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

