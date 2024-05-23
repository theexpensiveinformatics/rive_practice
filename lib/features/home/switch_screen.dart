import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:rive_practice/utils/constants/colors.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}
class _SwitchScreenState extends State<SwitchScreen> {
  StateMachineController? _stateMachineController;
  Artboard? mainArtBoard;
  SMIBool? check;

  @override
  void initState() {
    super.initState();
    loadRiveFile();
  }

  Future<void> loadRiveFile() async {
    final riveByteData = await rootBundle.load("assets/rive/switch.riv");
    final riveFile = RiveFile.import(riveByteData);
    final mArtBoard = riveFile.mainArtboard;
    _stateMachineController =
        StateMachineController.fromArtboard(mArtBoard, "State Machine");

    if (_stateMachineController != null) {
      mArtBoard.addController(_stateMachineController!);
      mainArtBoard = mArtBoard;
      check = _stateMachineController!.findSMI("IsOn");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: mainArtBoard != null
          ? InkWell(
              onTap: () {
                check!.value = !check!.value;
              },
              child: Column(
                children: [

                  Container(
                    height: screenHeight / 3,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: AppColors.switchBackgroundTop,
                    child:
                      const Text('Skeuomorphic\nSwitch',style: TextStyle(color: AppColors.switchTextColor,fontFamily: 'Demo',fontWeight: FontWeight.w600,fontSize: 40,height: 1),textAlign: TextAlign.center,),
                  ),
                  SizedBox(
                    height: screenHeight / 3,
                    child:
                        Rive(artboard: mainArtBoard!, fit: BoxFit.fitWidth),
                  ),
                  Container(
                    height: screenHeight/ 3,
                    color: AppColors.switchBackgroundBottom,
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
