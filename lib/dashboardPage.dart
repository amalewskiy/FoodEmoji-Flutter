import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_emoji/foodTabs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';
import 'foodPage.dart';
import 'dart:math';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  Random rnd = Random();
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.menu, color: Colors.black),
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 6.0,
                            spreadRadius: 4.0,
                            offset: Offset(0.0, 3.0))
                      ],
                      color: Color(0xFFC6E7FE),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/tuxedo.png'),
                          fit: BoxFit.contain)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "SEARCH FOR",
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w800, fontSize: 27.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "RECIPES",
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w800, fontSize: 27.0),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
                    border: InputBorder.none,
                    fillColor: Colors.grey.withOpacity(0.5),
                    prefixIcon: Icon(Icons.search, color: Colors.grey)),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Recommended",
              style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w500, fontSize: 18.0),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildListItem(0),
                _buildListItem(1),
                _buildListItem(2),
                _buildListItem(3),
                _buildListItem(4)
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.5),
              labelStyle: GoogleFonts.notoSans(
                  fontSize: 16.0, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.notoSans(
                  fontSize: 12.0, fontWeight: FontWeight.w500),
              tabs: [
                Tab(child: Text("FEATURED")),
                Tab(child: Text("COMBO")),
                Tab(child: Text("FAVORITES")),
                Tab(child: Text("RECOMMENDED"))
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - 450.0,
              child: TabBarView(controller: tabController, children: [
                FoodTab(),
                FoodTab(),
                FoodTab(),
                FoodTab(),
              ]))
        ],
      ),
    );
  }

  Padding _buildListItem(int bgColorIndex) {
    var randomFood = [];
    randomFood = allFoods[rnd.nextInt(allFoods.length)];
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: InkWell(
        onTap: () {
          _getNumberOrders(randomFood);
        },
        child: Container(
          height: 175.0,
          width: 150.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(colorsPalette[bgColorIndex])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                  tag: randomFood[0],
                  child: Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                        child: Image.asset(
                      randomFood[1],
                      height: 50.0,
                      width: 50.0,
                    )),
                  )),
              SizedBox(height: 25.0),
              Text(
                randomFood[0],
                style: GoogleFonts.notoSans(
                    fontSize: 17.0, color: Color(0xffffffff)),
              ),
              Text('\$' + randomFood[2],
                  style: GoogleFonts.notoSans(
                      fontSize: 17.0, color: Color(0xffffffff)))
            ],
          ),
        ),
      ),
    );
  }

  Future _getNumberOrders(List randomFood) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FoodPage(
            foodName: randomFood[0],
            imgPath: randomFood[1],
            pricePerItem: randomFood[2],
            heroTag: randomFood[0],
            ordersNumber: data.ordersNumber)));
    print('HELLO $result');
    setState(() {
      if (result == 1)
        data.ordersNumber(data.ordersNumber++);
    });
  }
}
