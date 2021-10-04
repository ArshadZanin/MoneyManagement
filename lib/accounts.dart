import 'package:flutter/material.dart';
import 'package:money_management/accounts/add.dart';
import 'package:money_management/accounts/delete.dart';


class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF020925),
      appBar: AppBar(
        backgroundColor: const Color(0xFF020925),
        elevation: 0,
        title: const Text(
            'Accounts',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         Navigator.push(context, MaterialPageRoute(builder: (_) => const AddData()));
        //         debugPrint("options clicked");
        //       },
        //       icon: const Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //   ),
        // //   PopupMenuButton<int>(
        // //     onSelected: (item) => handleClick(item),
        // //     itemBuilder: (context) => [
        // //       const PopupMenuItem<int>(value: 0, child: Text('Add')),
        // //       const PopupMenuItem<int>(value: 1, child: Text('Delete')),
        // //     ],
        // //   ),
        // ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Container(
            color: const Color(0xFF020925),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child: Column(
                      children: const [
                        Text("Assets",style: TextStyle(color: Colors.white),),
                        Text("0.00",style: TextStyle(color: Colors.blueAccent),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: const [
                        Text("Liablities",style: TextStyle(color: Colors.white),),
                        Text("0.00",style: TextStyle(color: Colors.red),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: const [
                        Text("Total",style: TextStyle(color: Colors.white),),
                        Text("0.00",style: TextStyle(color: Colors.white),),
                      ],
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 50,),
          Expanded(
            child: Container(
            color: Colors.grey.withOpacity(0.1),
            width: MediaQuery.of(context).size.width,
          ),),
        ],
      ),
    );
  }
  void handleClick(int item) {
    switch (item) {
      case 0:
        debugPrint("Add");
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddData()));
        break;
      case 1:
        debugPrint("Delete");
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DeleteData()));
        break;

    }
  }
}
