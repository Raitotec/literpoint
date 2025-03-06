import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:gas_services_new/Views/RequestsPage.dart';
import 'package:gas_services_new/Views/about_us_page.dart';
import 'package:gas_services_new/Views/services_page.dart';
import 'package:sizer/sizer.dart';
import '../Constans/Style.dart';
import '../Localization/Translations.dart';

import '../Api/CheckVersionApi.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/DrawerView.dart';
import 'StationMaintenancePage.dart';
import 'location_station.dart';
import 'map_page.dart';
import 'not_found_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  bool _isLoading = false;
  bool check_Version= false;
  String _pageTitle = "";

  void didChangeDependencies() {

    checkVersionFun(context);

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //resizeToAvoidBottomInset: false,
      //appBar: AppBarWithlanguage(context, _pageTitle),
      //drawer: DrawerList(context),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined,color: Style.WhiteColor,),
            labelStyle: TextStyle(color: Colors.white, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            label: Translations.of(context)!.Home_page,
          ),
          /*CurvedNavigationBarItem(
            child: Icon(Icons.shopping_bag_outlined,color: Style.WhiteColor,),
            labelStyle: TextStyle(color: Colors.white, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            label: Translations.of(context)!.Requests,
          ),*/
          CurvedNavigationBarItem(
            child: Icon(Icons.location_on_outlined,color: Style.WhiteColor,),
            labelStyle: TextStyle(color: Colors.white, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            label: Translations.of(context)!.Station_locations,
          ),
         /* CurvedNavigationBarItem(
            child: Icon(Icons.build_outlined ,color: Style.WhiteColor,),
            labelStyle: TextStyle(color: Colors.white, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            label: Translations.of(context)!.Station_maintenance,
          ),*/
          CurvedNavigationBarItem(
            child: Icon(Icons.settings ,color: Style.WhiteColor,),
            labelStyle: TextStyle(color: Colors.white, fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            label: Translations.of(context)!.Services,
          ),
        ],

        color: Style.MainColor,
        buttonBackgroundColor: Style.SecondryColor,
        backgroundColor: Style.WhiteColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body:UI(),
    ));
  }

  UI() {

    switch(_page)
    {
      case 1:
        return MapLocationStationScreen();
      case 0:
        return MapScreen();
      case 2:
        return ServicesPage(id: "");
     // case 3:
       // return StationMaintenancePage();
    }
  }


  Future<void> checkVersionFun(BuildContext context)
  async {
    showLoading();
    setState(() {
      _pageTitle= Translations.of(context)!.Home_page;
      _page = 0;
      _bottomNavigationKey = GlobalKey();
    });
    var x =await checkVersion(context);
    setState(() {
      check_Version = x;
      _pageTitle= Translations.of(context)!.Home_page;
    });
    hideLoading();
  }

  void showLoading() {
    setState(() {
      _isLoading=true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading=false;
    });
  }


}