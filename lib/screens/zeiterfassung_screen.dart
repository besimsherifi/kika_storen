import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';

class ZeiterfassungScreen extends StatefulWidget {
  const ZeiterfassungScreen({Key? key}) : super(key: key);

  static const routeName = '/Zeiterfassung-screen';

  @override
  State<ZeiterfassungScreen> createState() => _ZeiterfassungScreenState();
}

class _ZeiterfassungScreenState extends State<ZeiterfassungScreen> {
  var timer;
  // DateTime now = DateTime.now();
  // dynamic formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Provider.of<TimerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: homeScreenBody(),
    );
  }

  Widget homeScreenBody() {
    return Container(child: Consumer<TimerProvider>(
      builder: (context, timeprovider, widget) {
        return Column(
          children: [
            addVerticalSpace(25),
            Center(
              child: Text(
                '${timer.hour}:' + '${timer.minute}:' + '${timer.seconds}',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            addVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (timer.startEnable)
                    ? ElevatedButton(
                        onPressed: timer.startTimer,
                        child: Text('Start'),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text('Start'),
                      ),
                (timer.stopEnable)
                    ? ElevatedButton(
                        onPressed: timer.stopTimer,
                        child: Text('Stop'),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text('Stop'),
                      ),
                (timer.continueEnable)
                    ? ElevatedButton(
                        onPressed: timer.continueTimer,
                        child: Text('Continue'),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text('Continue'),
                      ),
              ],
            ),
            addVerticalSpace(40),
            CheckboxListTile(
              title: Text("Automaticher Start und Stop"), //    <-- label
              value: false,
              onChanged: (newValue) {},
            ),
            CheckboxListTile(
              title: Text(
                  "Benachrichtigen Sie mich nach 8 Stunden"), //    <-- label
              value: false,
              onChanged: (newValue) {},
            )
          ],
        );
      },
    ));
  }
}
