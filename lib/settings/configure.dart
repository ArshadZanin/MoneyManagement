import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/database_passcode.dart';
import 'package:money_management/db/database_reminder.dart';
import 'package:money_management/settings/expense_category.dart';
import 'package:money_management/settings/income_category.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_management/color/app_color.dart' as app_color;
import 'package:money_management/settings/passcode.dart';
import 'package:money_management/splash%20screen/splash_screen.dart';
import 'package:money_management/transaction/add_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Configure extends StatefulWidget {
  const Configure({Key? key}) : super(key: key);

  @override
  _ConfigureState createState() => _ConfigureState();
}

class _ConfigureState extends State<Configure> {

  ///set bool of passcode///
  addBoolTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
    debugPrint("set True");
  }
  addBoolFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
    debugPrint("set False");
  }
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool('boolValue');
    return boolValue;
  }




  FlutterLocalNotificationsPlugin? appNotification;

  TimeOfDay _time = const TimeOfDay(hour: 21, minute: 00);

  String? dates = "9:00 PM";

  bool? reminder = false;
  bool finger = false;
  String passcode = "";

  DatabaseHandlerTime handler = DatabaseHandlerTime();

  DatabaseHandlerPasscode handlerpasscode = DatabaseHandlerPasscode();


  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().whenComplete(()async{
      finger = await getBoolValuesSF();
    });


    ///passcode check///
    //   handlerpasscode = DatabaseHandlerPasscode();
    //   handlerpasscode.initializeDB().whenComplete(() async {
    //     passcode = (await handlerpasscode.retrievePasscode())!;
    //     finger = (await handlerpasscode.retrieveCheck())!;
    //     debugPrint("$finger");
    //     // await this.addUsers();
    //     setState(() {});
    //   });

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
      setState(() {
      });
    });
  }

  @Deprecated("Notification")
  _showNotification(String dates) async {
    var androidDetails = const AndroidNotificationDetails("Channel ID", "Programmer");
    var iOsDetails = const IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iOsDetails);

    Future.delayed(const Duration(seconds: 86400), () {
      _showNotification(dates);
      setState(() {
      });
    });
    List<String> value = dates.split(':');
    List<String> second = value[1].split(' ');
    int last = int.parse(value[0]);
    String valueLast = "$last";
    if (second[1] == 'PM') {
      last += 12;
      valueLast = "$last";
    }else{
      if(last == 11 || last == 12){
        valueLast = "$last";
      }else{
        valueLast = "0$last";
      }
    }
    String time = "$valueLast:${second[0]}";

    final DateTime now = DateTime.now();
    debugPrint("$now");
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    debugPrint(formatted);

    String dateAndTime = "$formatted $time:00.000000";

    debugPrint("time id: $dateAndTime");

    DateTime reminderTime = DateTime.parse(dateAndTime);
    appNotification!.schedule(0, "Don`t Forget to add transactions...", "add now", reminderTime, generalNotificationDetails);
    // await appNotification!.show(0, "task", "You Created a task", generalNotificationDetails,payload: "Task");
    int delay = 86400;

    for(int i = 1; i <= 3; i++){

      DateTime reminderTime = DateTime.parse(dateAndTime).add(Duration(seconds: delay));
      debugPrint("time is: $reminderTime");


      var scheduledTime = reminderTime;
      debugPrint("$i : $scheduledTime");
      appNotification!.schedule(i, "Don`t Forget to add transactions...", "add now", scheduledTime, generalNotificationDetails);
      delay += 86400;
    }
  }

  @Deprecated("message")
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        if(reminder == true){
          _showNotification(dates!);
        }
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
        setState(() {
          if(reminder == true){
            _showNotification(dates!);
          }
        });
      });
    }
  }


  @Deprecated("message")
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color.back,
      appBar: AppBar(
        title: const Text("Configuration"),
        backgroundColor: const Color(0xFF13254C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageAssist()));
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5,),
          const Text("Category",style: TextStyle(color: Colors.black,fontSize: 15),),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: app_color.widget,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: (){
                      debugPrint("Income Category Settings");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const IncomeCategory()));
                    },
                    child: const Text("Income Category Settings",style: TextStyle(color: app_color.text,fontSize: 17),),
                ),
                TextButton(
                  onPressed: (){
                    debugPrint("Expenses Category Settings");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseCategory()));
                  },
                  child: const Text("Expenses Category Settings",style: TextStyle(color: app_color.text,fontSize: 17),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            color: app_color.widget,
            child: Column(
              children: [
                FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PassCode()));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Set PassCode",style: TextStyle(color: app_color.text,fontSize: 16),),
                          Text("default Passcode : 0000",style: TextStyle(color: Colors.black54,fontSize: 14),),
                        ],
                      )),
                ),
                SwitchListTile(
                  title: const Text("App Lock", style: TextStyle(color: app_color.text,fontSize: 16)),
                  value: finger,
                  onChanged: (bool newValue) async {
                    // PasscodeDb user3 = PasscodeDb(passcode: passcode, checks: "$newValue");
                    // List<PasscodeDb> listofPasscodeDb = [user3];
                    // DatabaseHandlerPasscode db3 = DatabaseHandlerPasscode();
                    // await db3.insertPasscode(listofPasscodeDb);

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove("boolValue");

                    setState(() {
                      finger == false ? addBoolTrue() : addBoolFalse();
                    finger == false ? finger = true : finger = false;
                  });}
                ),
                SwitchListTile(
                  title: const Text("Set Reminder?", style: TextStyle(color: app_color.text,fontSize: 16)),
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
                      setState(() {
                        if(reminder == true){
                          _showNotification(dates!);
                        }
                      });
                    });
                  //  setState(() {
                  //   reminder == false ? reminder = true : reminder = false;
                  // });
                   },
                ),
                reminder == true ? FlatButton(
                  color: app_color.widget,
                    onPressed: () async {
                    debugPrint("reminder");
                    _selectTime();
                    setState(() {
                    });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text("Time?",style: TextStyle(color: app_color.text,fontSize: 16),),
                      const SizedBox(width: 10,),
                      Text(dates!,style: const TextStyle(color: app_color.text,fontSize: 16),)
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
    // showDialog(context: context,
    //   builder: (context) => AlertDialog(
    //     content: TextButton(onPressed: (){
    //       Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTrans()));
    //     }, child: const Text("Add Now",style: TextStyle(color: Colors.blue),)),
    //   ),
    // );
    Future.delayed(const Duration(milliseconds: 0), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTrans()));
      setState(() {
      });

    });
  }

}
