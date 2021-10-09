import 'package:money_management/color/app_color.dart' as app_color;
import 'package:flutter/material.dart';
import 'package:money_management/db/database_passcode.dart';
import 'package:money_management/settings/configure.dart';

class PassCode extends StatefulWidget {
  const PassCode({Key? key}) : super(key: key);

  @override
  _PassCodeState createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {

  DatabaseHandlerPasscode handler = DatabaseHandlerPasscode();


  int count = 0;
  String passcode = "";
  bool check = false;


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandlerPasscode();
    handler.initializeDB().whenComplete(() async {

      passcode = (await handler.retrievePasscode())!;
      debugPrint(passcode);
      passcode = "";
      check = (await handler.retrieveCheck())!;
      debugPrint("$check");
      // await this.addUsers();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: app_color.back,
        appBar: AppBar(
          title: const Text("Set Passcode"),
          backgroundColor: app_color.button,
          actions: [
            FlatButton(onPressed: () async {
              if(passcode.length == 4){

                PasscodeDb user3 = PasscodeDb(passcode: passcode, checks: "$check");
                List<PasscodeDb> listofPasscodeDb = [user3];
                DatabaseHandlerPasscode db3 = DatabaseHandlerPasscode();
                await db3.insertPasscode(listofPasscodeDb);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Configure()));
              }
            }, child: const Text("Done",style: TextStyle(color: app_color.textWhite),))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Passcode",style: TextStyle(color: app_color.text,fontSize: 33),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                count >= 1 ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
                const SizedBox(width: 5,),
                count >= 2 ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
                const SizedBox(width: 5,),
                count >= 3 ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
                const SizedBox(width: 5,),
                count >= 4 ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
              ],
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "1";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("1",style: TextStyle(color: app_color.text,fontSize: 33),)),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "2";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("2",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "3";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("3",style: TextStyle(color: app_color.text,fontSize: 33),),),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              FlatButton(onPressed: (){
                if(count != 4){
                  if(passcode.length != 4){
                    passcode = passcode + "4";
                  }
                setState(() {
                  count++;
                });
              }},child: const Text("4",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
              FlatButton(onPressed: (){
                if(count != 4){
                  if(passcode.length != 4){
                    passcode = passcode + "5";
                  }
                setState(() {
                  count++;
                });
              }},child: const Text("5",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "6";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("6",style: TextStyle(color: app_color.text,fontSize: 33),),),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "7";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("7",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                    passcode = passcode + "8";
                  }
                  setState(() {
                    count++;
                  });
                }},child: const Text("8",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "9";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("9",style: TextStyle(color: app_color.text,fontSize: 33),),),
              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(onPressed: (){},child: const Text("",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(onPressed: (){
                  if(count != 4){
                    if(passcode.length != 4){
                      passcode = passcode + "0";
                    }
                  setState(() {
                    count++;
                  });
                }},child: const Text("0",style: TextStyle(color: app_color.text,fontSize: 33),),),
                const SizedBox(width: 5,),
                FlatButton(
                  onPressed: (){
                    if(count != 0){
                      setState(() {
                        passcode = passcode.substring(0, passcode.length-1);
                        debugPrint(passcode);
                        count--;
                      });
                    }
                  },
                  child: const Icon(Icons.backspace),
                ),              ],
            ),
            const SizedBox(height: 30,),
          ],
        ));
  }
}
