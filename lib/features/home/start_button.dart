import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../utils/constants/colors.dart';

class StartButtonScreen extends StatefulWidget {
  const StartButtonScreen({super.key});

  @override
  State<StartButtonScreen> createState() => _StartButtonScreenState();
}

class _StartButtonScreenState extends State<StartButtonScreen> {
  StateMachineController? _stateMachineController;
  Artboard? mainArtBoard;
  SMIBool? check;

  @override
  void initState() {
    super.initState();
    loadRiveFile();
  }

  Future<void> loadRiveFile() async {
    final riveByteData = await rootBundle.load("assets/rive/start_button.riv");
    final riveFile = RiveFile.import(riveByteData);
    final mArtBoard = riveFile.mainArtboard;
    _stateMachineController =
        StateMachineController.fromArtboard(mArtBoard, "State Machine 1");

    if (_stateMachineController != null) {
      mArtBoard.addController(_stateMachineController!);
      mainArtBoard = mArtBoard;
      check = _stateMachineController!.findSMI("Clicked");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: mainArtBoard != null
          ? InkWell(
        onTapUp: (details){check!.value = !check!.value;},
              onTapDown: (value) {
                check!.value = !check!.value;
              },
              onTapCancel: () {
                check!.value = !check!.value;
              },
              child: Container(
                color:AppColors.startButtonBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Start\nButton',
                      style: TextStyle(
                          color: AppColors.startButtonText,
                          fontFamily: 'Demo',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          height: 1),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenHeight / 3,
                      child:
                          Rive(artboard: mainArtBoard!, fit: BoxFit.fitWidth),
                    ),
                    const SizedBox(
                      // height: ScreenHeight/3,
                    )
                  ],
                ),
              ),
            )
          : const Text('nothing'),
    );
  }
}
