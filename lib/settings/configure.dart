import 'package:flutter/material.dart';
import 'package:money_management/db/database_reminder.dart';
import 'package:money_management/main.dart';
import 'package:money_management/settings/expense_category.dart';
import 'package:money_management/settings/income_category.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Configure extends StatefulWidget {
  const Configure({Key? key}) : super(key: key);

  @override
  _ConfigureState createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> {

  FlutterLocalNotificationsPlugin? appNotification;

  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  String? dates = "7:15 AM";

  bool? reminder = false;

  DatabaseHandlerTime handler = DatabaseHandlerTime();

  @override
  void initState() {
    super.initState();

    ///notification settings///
    var androidInitilize = const AndroidInitializationSettings('app_icon');
    var iOsInitilize = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: androidInitilize, iOS: iOsInitilize);
    appNotification = FlutterLocalNotificationsPlugin();
    appNotification!.initialize(initializationSettings,onSelectNotification: notificationSelected);

    ///database handler///

    // dates = _time.format(context);
    handler = DatabaseHandlerTime();
    handler.initializeDB().whenComplete(() async {
      // ///add data to reminder database///
      // TimeDb user = TimeDb(time: _time.format(context),reminder: "false");
      // List<TimeDb> listofTimeDb = [user];
      // DatabaseHandlerTime db = DatabaseHandlerTime();
      // await db.insertReminder(listofTimeDb);
      ///take data to dates///
      dates = await handler.retrieveWithTime();
      ///take data to reminder boolean///
      reminder = await handler.retrieveWithReminder();

      debugPrint("data reached: $reminder");
      // await this.addUsers();
      setState(() {});
    });
  }

  _showNotification(String dates) async {
    var androidDetails = const AndroidNotificationDetails("Channel ID", "Programmer");
    var iOsDetails = const IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iOsDetails);

    List<String> value = dates.split(':');
    List<String> second = value[1].split(' ');
    int last = int.parse(value[0]);
    if (second[1] == 'PM') {
      last += 12;
    }
    String time = "$last:${second[0]}";

    String dateAndTime = "2021-10-08 $time:00.000000";

    debugPrint("time id: $dateAndTime");

    // DateTime reminderTime = DateTime.parse(dateAndTime);
    DateTime reminderTime = DateTime.now();
    debugPrint("time is: $reminderTime");

    // await appNotification!.show(0, "task", "You Created a task", generalNotificationDetails,payload: "Task");
    var scheduledTime = reminderTime;
    debugPrint("$scheduledTime");

    appNotification!.schedule(1, "Don`t Forget to add transactions...", "add now", scheduledTime, generalNotificationDetails);
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        debugPrint("$_time");
      });
      handler = DatabaseHandlerTime();
      handler.initializeDB().whenComplete(() async {
        reminder = await handler.retrieveWithReminder();
        ///add data to reminder database///
        TimeDb user = TimeDb(time: _time.format(context),reminder: "$reminder");
        List<TimeDb> listofTimeDb = [user];
        DatabaseHandlerTime db = DatabaseHandlerTime();
        await db.insertReminder(listofTimeDb);
        ///take data to dates///
        dates = await handler.retrieveWithTime();
        // await this.addUsers();
        setState(() {});
      });
    }
  }

  bool finger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                if(reminder == true){
                  _showNotification(dates!);
                }
              },
              icon: const Icon(Icons.alarm),
          )
        ],
        title: const Text("Configuration"),
        backgroundColor: const Color(0xFF13254C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyApp()));
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5,),
          const Text("Category",style: TextStyle(color: Colors.white54,fontSize: 15),),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF13254C),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: (){
                      debugPrint("Income Category Settings");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeCategory()));
                    },
                    child: const Text("Income Category Settings",style: TextStyle(color: Colors.white,fontSize: 17),),
                ),
                TextButton(
                  onPressed: (){
                    debugPrint("Expenses Category Settings");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseCategory()));
                  },
                  child: const Text("Expenses Category Settings",style: TextStyle(color: Colors.white,fontSize: 17),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF13254C),
            child: Column(
              children: [
                SwitchListTile(
                  inactiveTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.blueGrey[800],
                  activeTrackColor: Colors.blueGrey[800],
                  title: const Text("App Lock", style: TextStyle(color: Colors.white,fontSize: 20)),
                  value: finger,
                  onChanged: (bool newValue) => setState(() {
                    finger == false ? finger = true : finger = false;
                  }),
                ),
                SwitchListTile(
                  inactiveTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.blueGrey[800],
                  activeTrackColor: Colors.blueGrey[800],
                  title: const Text("Set Reminder?", style: TextStyle(color: Colors.white,fontSize: 20)),
                  value: reminder!,
                  onChanged: (bool newValue) async {
                    handler = DatabaseHandlerTime();
                    handler.initializeDB().whenComplete(() async {
                      ///add data to reminder database///
                      TimeDb user = TimeDb(time: _time.format(context),reminder: "$newValue");
                      List<TimeDb> listofTimeDb = [user];
                      DatabaseHandlerTime db = DatabaseHandlerTime();
                      await db.insertReminder(listofTimeDb);
                      ///take data to dates///
                      dates = await handler.retrieveWithTime();
                      ///take data to reminder boolean///
                      reminder = await handler.retrieveWithReminder();
                      // await this.addUsers();
                      setState(() {});
                    });
                  //  setState(() {
                  //   reminder == false ? reminder = true : reminder = false;
                  // });
                   },
                ),
                reminder == true ? FlatButton(
                  color: const Color(0xFF13254C),
                    onPressed: () async {
                    debugPrint("reminder");
                    _selectTime();
                    setState(() {
                    });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text("Time?",style: TextStyle(color: Colors.white,fontSize: 20),),
                      const SizedBox(width: 10,),
                      Text(dates!,style: const TextStyle(color: Colors.white54,fontSize: 20),)
                    ],),
                ) :
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> notificationSelected(String? payload) async {
    showDialog(context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification clicked $payload"),
      ),
    );
  }

}
