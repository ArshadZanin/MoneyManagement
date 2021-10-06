import 'package:flutter/material.dart';
import 'package:money_management/db/database_transaction.dart';


class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {

  DatabaseHandler handler = DatabaseHandler();

  double? assets = 0.0;
  double? liabilities = 0.0;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      String? assets12 = await handler.calculateAssetsTotal();
      debugPrint("assets error hiiiii $assets12");
      assets = double.parse(assets12!);
      debugPrint("assets in int: $assets");

      String? liabilities12 = await handler.calculateLiabilitiesTotal();
      debugPrint("liabilities error hiiiii $liabilities12");
      liabilities = double.parse(liabilities12!);
      debugPrint("liabilities in int: $liabilities");

      setState(() {});
    });
  }

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
                      children: [
                        const Text("Assets",style: TextStyle(color: Colors.white),),
                        Text("$assets",style: const TextStyle(color: Colors.blueAccent),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text("Liablities",style: TextStyle(color: Colors.white),),
                        Text("$liabilities",style: const TextStyle(color: Colors.red),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text("Total",style: TextStyle(color: Colors.white),),
                        Text("${assets! - liabilities!}",style: const TextStyle(color: Colors.white),),
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


              child: FutureBuilder(
                future: handler.retrieveUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if(snapshot.data![index].trans == 'income'){
                        //   income = income! + double.parse(snapshot.data![index].amount.toString());
                        // }else{
                        //   expense = expense! + double.parse(snapshot.data![index].amount.toString());
                        // }
                        index = snapshot.data!.length - index -1;
                        return Dismissible(
                          direction: DismissDirection.none,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Icon(Icons.delete_forever),
                          ),
                          key: ValueKey<int>(snapshot.data![index].id!),
                          onDismissed: (DismissDirection direction) async {
                            await handler.deleteUser(snapshot.data![index].id!);
                            setState(() {
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: snapshot.data![index].date != "Jan 01, 2015" ?
                          Card(
                            color: Colors.white10,
                            child:
                            ListTile(
                              contentPadding: const EdgeInsets.all(12.0),
                              title: Text(
                                "${snapshot.data![index].date}\n${snapshot.data![index].account}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index].amount.toString(),
                                textAlign: TextAlign.end,
                                style: snapshot.data![index].account == 'Assets' ?
                                const TextStyle(color: Colors.blue) :
                                const TextStyle(color: Colors.red),
                              ),
                            ),
                          ) :
                          Container(),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),

          ),
          ),
        ],
      ),
    );
  }
}
