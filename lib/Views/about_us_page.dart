
import 'package:flutter/material.dart';
import 'package:gas_services_new/Constans/Base_Url.dart';
import 'package:gas_services_new/Localization/Translations.dart';
import 'package:gas_services_new/Models/AboutModel.dart';
import 'package:gas_services_new/Models/DataModel.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../Api/DataApi.dart';
import '../Constans/Style.dart';
import '../Shared_Data/formatDateTime.dart';
import '../Shared_View/AlertView.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/DrawerView.dart';

class AboutUsPage extends StatefulWidget {

  AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  bool _isLoading = false;
  AboutModel data= AboutModel("", "");
  List<DataModel> branches=<DataModel>[];

  @override
  void initState() {
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBarWithBack(context, Translations.of(context)!.About_us),
        drawer: DrawerList(context),
        body: LoadingOverlay(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child:FormUI(context),
                ),

            isLoading: _isLoading,
            opacity: 0.3,
            color: Style.WhiteColor,
            progressIndicator: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Style.MainColor),))
    ));
  }

  Widget FormUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 8.0.h,),
          Image(image: AssetImage('lib/assets/logo.png'), width: 60.0.w, height: 12.0.h,),
         // Text(Translations.of(context)!.New_user,style: Style.Secondry16Bold,),
         Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                  Expanded(child: Text(data.description!, style: Style.MainText14,
                  )),
                  ],),

                  SizedBox(height: 2.0.h,),
                  Container(decoration: Style.BoxDecorationRadius,
                    padding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 4.0.w),
                    child: Text(Translations.of(context)!.work_hours, style: Style.MainText14Bold),
                  ),
                  Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 4.0.w),
        child:  Row(children: [
                    Expanded(child: Text(data.work_times!, style: Style.MainText14,
                    )),
                  ],)),
                  SizedBox(height: 2.0.h,),
                  Container(
                    decoration: Style.BoxDecorationRadius,
                    padding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 4.0.w),
                    child: Text(Translations.of(context)!.branches, style: Style.MainText14Bold),
                  ),
                  if(branches != null &&branches.length>0)
                  ListView.builder(
                    shrinkWrap:true,// -> Add this here
                    physics:NeverScrollableScrollPhysics(),// -> And this one
                    itemBuilder: (context, index) =>   Container(
                        margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 4.0.w),
                        child:  Row(
                          mainAxisAlignment:MainAxisAlignment.start ,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         Container(
                             child:  Text((index+1).toString()+"  ",style: Style.Secondry12Bold,),
                         margin: EdgeInsets.symmetric(vertical: 0.5.h),),
                          Expanded(child: Text( branches[index].name!+" - "+branches[index].city!, style: Style.MainText14,
                          )),
                        ],)),
                    itemCount: branches.length,
                  ),

          ]))


      ])
    );
  }

  Future<void> GetData()
  async {
    showLoading();
    var x= await About_us(context);
    if(x != null) {
      setState(() {
        data = x!;
      });
    }
    hideLoading();
    showLoading();
    var xx= await GetBranches(context);
    if(xx != null) {
      setState(() {
        branches = xx!;
      });
    }
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