import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';
import '../services/authentication_service.dart';
import '../utils/config.dart';
import '../utils/helper_widgets.dart';

class MainScreenDrawer extends StatelessWidget {
  const MainScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        addVerticalSpace(90),
        TextButton(
            onPressed: () {
              currentTheme.switchTheme();
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
        MainDrawerClock()
      ],
    ));
  }
}

class MainDrawerClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<TimerProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timer.currentTime != null ? Text(timer.currentTime) : Text(''),
          GestureDetector(
            child: Icon(
              timer.startEnable ? Iconsax.play : Iconsax.pause,
            ),
            onTap: () {
              print(timer.currentTime);
              if (timer.startEnable) {
                timer.continueTimer();
              } else {
                timer.stopTimer();
              }
            },
          ),
          addHorizontalSpace(10),
          Text(timer.hour.toString()),
          addHorizontalSpace(20),
          Text(timer.minute.toString()),
          addHorizontalSpace(20),
          Text(timer.seconds.toString()),
        ],
      ),
    );
  }
}
