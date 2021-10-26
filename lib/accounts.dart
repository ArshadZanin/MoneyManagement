// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_management/color/app_color.dart' as app_color;
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
      final String? assets12 = await handler.calculateAssetsTotal();
      assets = double.parse(assets12!);

      final String? liabilities12 = await handler.calculateLiabilitiesTotal();
      liabilities = double.parse(liabilities12!);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: app_color.back,
      appBar: AppBar(
        backgroundColor: app_color.back,
        elevation: 0.2,
        centerTitle: true,
        title: const Text(
          'Accounts',
          style: TextStyle(
            color: app_color.text,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(35),
            // color: app_color.back,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // Alignment(0.8, 0.8), // 10% of the width, so there are ten blinds.
                colors: <Color>[
                  Color(0xff28008d),
                  Color(0xff3003a5),
                  Color(0xff6325ff)
                ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text(
                          'Assets',
                          style: TextStyle(color: app_color.textWhite),
                        ),
                        Text(
                          '$assets',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text(
                          'Liabilities',
                          style: TextStyle(color: app_color.textWhite),
                        ),
                        Text(
                          '$liabilities',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(color: app_color.textWhite),
                        ),
                        Text(
                          '${assets! - liabilities!}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Expanded(
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: handler.retrieveUsers(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        index = snapshot.data!.length - index - 1;
                        return Dismissible(
                          direction: DismissDirection.none,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: const Icon(Icons.delete_forever),
                          ),
                          key: ValueKey<int>(snapshot.data![index].id!),
                          onDismissed: (DismissDirection direction) async {
                            await handler.deleteUser(snapshot.data![index].id!);
                            setState(() {
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: snapshot.data![index].date != 'Jan 01, 2015'
                              ? Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8.5),
                                    title: Text(
                                      '${snapshot.data![index].date}\n${snapshot
                                          .data![index].account}',
                                      style: const TextStyle(
                                          color: app_color.text),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index].amount.toString(),
                                      textAlign: TextAlign.end,
                                      style: snapshot.data![index].account ==
                                              'Assets'
                                          ? const TextStyle(color: Colors.blue)
                                          : const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                )
                              : Container(),
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
