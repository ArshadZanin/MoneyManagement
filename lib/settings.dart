import 'package:flutter/material.dart';
import 'package:money_management/settings/configure.dart';
import 'package:money_management/settings/help.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF020925),
        title: const Text("Settings"),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                    onPressed:(){
                      debugPrint("Configuration");
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Configure()));
                    },
                    icon: const Icon(Icons.settings_outlined,color: Colors.grey,
                    ),
                ),
                const Center(child: Text("Configuration",style: TextStyle(color: Colors.grey),)),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                  onPressed:(){
                    debugPrint("Reset App");
                  },
                  icon: const Icon(Icons.settings_backup_restore,color: Colors.grey,),),
                const Center(child: Text("Reset App",style: TextStyle(color: Colors.grey),)),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 20,),
                IconButton(
                  onPressed:(){
                    debugPrint("Helppp");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const Help()));
                  },
                  icon: const Icon(Icons.help,color: Colors.grey,),),
                const Center(child: Text("Help",style: TextStyle(color: Colors.grey),)),
              ],
            ),

          ]
      ),
    );
  }
}
