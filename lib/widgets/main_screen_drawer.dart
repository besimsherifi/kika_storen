import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/screens/hours_report_screen.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';
import '../services/authentication_service.dart';
import '../utils/config.dart';
import '../utils/helper_widgets.dart';

class MainScreenDrawer extends StatefulWidget {
  const MainScreenDrawer({Key? key}) : super(key: key);

  @override
  State<MainScreenDrawer> createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        addVerticalSpace(90),
        TextButton(
            onPressed: () {
              currentTheme.switchTheme();
              setState(() {});
            },
            child: currentTheme.isDark
                ? const Icon(Iconsax.sun)
                : const Icon(Iconsax.moon)),
        TextButton(
          onPressed: () {
            context.read<AuthenticationService>().singOut();
          },
          child: const Icon(Iconsax.logout),
        ),
        MainDrawerClock(),
        // GestureDetector(
        //   child: Row(
        //     children: [Text('Mein Raport'), Icon(Icons.calendar_month)],
        //   ),
        //   onTap: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //       builder: (_) => HoursReportScreen(),
        //     ));
        //   },
        // )
      ],
    ));
  }
}

class MainDrawerClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<TimerProvider>(context);
    return Container(
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              GestureDetector(
                child: Icon(
                  timer.startEnable
                      ? Iconsax.play_circle
                      : Iconsax.pause_circle,
                  size: 40,
                ),
                onTap: () {
                  if (timer.startEnable) {
                    timer.continueTimer();
                  } else {
                    timer.stopTimer();
                  }
                },
              ),
            ],
          ),
          addHorizontalSpace(10),
          Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     timer.currentTime != null
              //         ? Text('ARBEIT GEANFANGT AM ${timer.currentTime}')
              //         : Text(''),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(timer.hour.toString()),
                  Text(':'),
                  Text(timer.minute.toString()),
                  Text(':'),
                  Text(timer.seconds.toString()),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
