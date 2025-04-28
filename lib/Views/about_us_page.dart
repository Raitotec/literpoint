
import 'package:flutter/material.dart';
import 'package:gas_services_new/Constans/Base_Url.dart';
import 'package:gas_services_new/Localization/Translations.dart';
import 'package:gas_services_new/Models/AboutModel.dart';
import 'package:gas_services_new/Models/DataModel.dart';
import 'package:gas_services_new/Shared_Data/LanguageData.dart';
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
  AboutModel? data;
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
          SizedBox(height: 3.0.h,),
          Image(image: AssetImage('lib/assets/logo.png'), width: 60.0.w, height: 17.0.h,),
         // Text(Translations.of(context)!.New_user,style: Style.Secondry16Bold,),
          if(data != null)
         Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 3.0.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title(Translations.of(context)!.our_slogan),
                  des(LanguageData.languageData=="ar"?data!.sloganAR!:data!.sloganEN!),
                  SizedBox(height: 2.0.h,),
                  title(Translations.of(context)!.our_mission),
                  des(LanguageData.languageData=="ar"?data!.ourMessageAR!:data!.ourMessageEN!),
                  SizedBox(height: 2.0.h,),
                  title(Translations.of(context)!.our_vision),
                  des(LanguageData.languageData=="ar"?data!.ourVisionAR!:data!.ourVisionEN!),
                  SizedBox(height: 2.0.h,),
                  title(Translations.of(context)!.our_values),
                  if((LanguageData.languageData=="ar"&& data!.ourValuesAR!=null && data!.ourValuesAR!.length>0)||
                      (LanguageData.languageData=="en"&& data!.ourValuesEN!=null && data!.ourValuesEN!.length>0))
                  ListView.builder(
                    shrinkWrap:true,// -> Add this here
                    physics:NeverScrollableScrollPhysics(),// -> And this one
                    itemBuilder: (context, index) =>   Container(
                        margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 4.0.w),
                        child:  Row(
                          mainAxisAlignment:MainAxisAlignment.start ,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Style.SecondryColor
                            ),
                              height: 3.0.h,
                              width: 2.0.w,
                              margin: EdgeInsets.only(top: 0.2.h),
                            ),
                            SizedBox(width: 2.0.w,),
                            Expanded(child: Text( LanguageData.languageData=="ar"? data!.ourValuesAR![index]:data!.ourValuesEN![index], style: Style.MainText14,
                            )),
                          ],)),
                    itemCount:LanguageData.languageData=="ar"? data!.ourValuesAR!.length:data!.ourValuesEN!.length,
                  ),
                  SizedBox(height: 2.0.h,),

          ]))


      ])
    );
  }

  title(String t) {
    return Row(
      children: [
        Container(decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Style.SecondryColor
        ),
          height: 3.0.h,
          width: 2.8.w,
        ),
        SizedBox(width: 2.0.w,),
        Expanded(child: Text(t, style: Style.MainText16Bold,))
      ],
    );
  }

  des(String d)
  {
    return  Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 1.0.w),
        child:  Row(children: [
          Expanded(child: Text(d, style: Style.MainText14,
          )),
        ],));
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