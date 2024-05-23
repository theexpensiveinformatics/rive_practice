import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:rive_practice/features/home/widgets/custom_slider.dart';
import 'package:rive_practice/utils/constants/colors.dart';

class GhostScreen extends StatefulWidget {
  const GhostScreen({super.key});

  @override
  State<GhostScreen> createState() => _GhostScreenState();
}

class _GhostScreenState extends State<GhostScreen> {
  StateMachineController? _ghostStateMachineController;
  Artboard? mainGhostArtBoard;
  SMINumber? ghostHeight;
  SMINumber? ghostFat;
  SMINumber? ghostEyeSize;
  SMINumber? ghostEyeDistance;

  @override
  void initState() {
    super.initState();
    loadGhostRiveFile();
  }

  Future<void> loadGhostRiveFile() async {
    final ghostRiveByteData = await rootBundle.load('assets/rive/gost.riv');
    final ghostRiveFile = RiveFile.import(ghostRiveByteData);
    final ghostArtBoard = ghostRiveFile.mainArtboard;
    _ghostStateMachineController =
        StateMachineController.fromArtboard(ghostArtBoard, "State Machine 1");

    if (_ghostStateMachineController != null) {
      ghostArtBoard.addController(_ghostStateMachineController!);
      mainGhostArtBoard = ghostArtBoard;
      ghostHeight = _ghostStateMachineController!.findSMI("Height");
      ghostFat = _ghostStateMachineController!.findSMI("Fat");
      ghostEyeSize = _ghostStateMachineController!.findSMI("EyeSize");
      ghostEyeDistance = _ghostStateMachineController!.findSMI("Eyes");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: AppColors.ghostBackground,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 15,
            ),
            const Text(
              'Ghost\nAnimation',
              style: TextStyle(
                  color: AppColors.seekBarBackground,
                  fontFamily: 'Demo',
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  height: 1),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height: screenHeight / 2.3,
                child: mainGhostArtBoard != null
                    ? Rive(
                        artboard: mainGhostArtBoard!,
                        fit: BoxFit.fitHeight,
                      )
                    : const Center(
                        child: Text('nothing'),
                      )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSlider(
                    title: 'Height', min: 0, max: 50, smiNumber: ghostHeight),
                CustomSlider(
                    title: 'Fat', min: 0, max: 100, smiNumber: ghostFat),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSlider(
                    title: 'Eye Size',
                    min: 0,
                    max: 100,
                    smiNumber: ghostEyeSize),
                CustomSlider(
                    title: 'Eye Distance',
                    min: 0,
                    max: 100,
                    smiNumber: ghostEyeDistance),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
