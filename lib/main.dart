import 'package:flutter/material.dart';
import 'package:sqlite_demo/screens/gallery.dart';
import 'package:sqlite_demo/screens/table.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.indigo,
        title: Text('SQLite for Flutter',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),), centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelPadding: EdgeInsets.only(left: 20, right: 20),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[300],
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Table"),
              Tab(text: "Gallery")
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TableWidget(), GalleryWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

