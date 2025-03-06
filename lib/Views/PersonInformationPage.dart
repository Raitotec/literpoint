
import 'package:flutter/material.dart';
import 'package:gas_services_new/Localization/Translations.dart';
import 'package:gas_services_new/Shared_Data/DelegateData.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../Api/LoginApi.dart';
import '../Constans/Style.dart';
import '../Routes/route_constants.dart';
import '../Shared_Data/formatDateTime.dart';
import '../Shared_View/AlertView.dart';
import '../Shared_View/AppBarView.dart';
import '../Shared_View/DrawerView.dart';

class PersonInformationPage extends StatefulWidget {

  PersonInformationPage({Key? key}) : super(key: key);

  @override
  _PersonInformationPageState createState() => _PersonInformationPageState();
}

class _PersonInformationPageState extends State<PersonInformationPage> {

  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      GetData();
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar: AppBarWithBack(
            context, Translations.of(context)!.Info),
        drawer: DrawerList(context),
        body: LoadingOverlay(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                child: new GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: FormUI(context),
                )),

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
            margin: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.0.h),
            child:Form(
              key: _formKey,
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Row(children: [
                    SizedBox(width: 3.0.w,),
                    Icon( Icons.person,size: 3.0.h,color: Style.SecondryColor,),
                    SizedBox(width: 3.0.w,),
                    Expanded(child:
                    Theme(
                      data: Theme.of(context).copyWith(primaryColor: Style.SecondryColor),
                      child: TextFormField(
                          controller: nameController,
                          cursorColor: Style.SecondryColor,
                          style: TextStyle(fontSize: 14.0.sp, color: Style.MainTextColor),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Translations.of(context)!.username_Validation;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                             // prefixIcon:Icon( Icons.person,size: Style.SizeIcon,color: Style.SecondryColor,),
                              hintText: Translations.of(context)!.username,
                              // labelStyle: TextStyle(fontSize: 12.0.sp, color: Style.GreyColor),
                              //  labelText: Translations.of(context)!.Code,
                              hintStyle: TextStyle(fontSize: 12.0.sp,
                                color: Style.GreyColor,),
                              errorStyle: TextStyle(fontSize: 12.0.sp,
                                  color: Colors.red)
                          ),
                          keyboardType: TextInputType.name,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          }
                      ),),
                    ),
                  ],),
                  SizedBox(height: 1.0.h,),
                  Row(children: [
                    SizedBox(width: 3.0.w,),
                    Icon( Icons.phone_android,size: 3.0.h,color: Style.SecondryColor),
                    SizedBox(width: 3.0.w,),
                    Text("+966", style: TextStyle(
                        fontSize: 12.0.sp, color: Style.GreyColor),),
                    SizedBox(width: 1.0.w,),
                    Expanded(child:
                    Theme(
                      data: Theme.of(context).copyWith(primaryColor: Style.SecondryColor),
                      child: TextFormField(
                          controller: mobileController,
                          cursorColor: Style.SecondryColor,
                          style: TextStyle(fontSize: 14.0.sp, color: Style.MainTextColor),
                          validator: (value) {
                            if (value!.isEmpty ||  value.length <9) {
                              return Translations.of(context)!.Phone_number_Validation;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                             // prefixIcon:Icon( Icons.phone_android,size: Style.SizeIcon,color: Style.SecondryColor),
                              hintText: Translations.of(context)!.Phone_number,
                              // labelStyle: TextStyle(fontSize: 12.0.sp, color: Style.GreyColor),
                              //  labelText: Translations.of(context)!.Code,
                              hintStyle: TextStyle(fontSize: 12.0.sp,
                                color: Style.GreyColor,),
                              errorStyle: TextStyle(fontSize: 12.0.sp,
                                  color: Colors.red)
                          ),
                          keyboardType: TextInputType.number,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          }
                      ),),)
                  ],),

                  SizedBox(height: 1.0.h,),
                  Row(children: [
                    SizedBox(width: 3.0.w,),
               Icon(Icons.email_outlined,size: Style.SizeIcon,color: Style.SecondryColor),
                    SizedBox(width: 3.0.w,),
                    Expanded(child:
                    Theme(
                      data: Theme.of(context).copyWith(primaryColor: Style.SecondryColor),
                      child: TextFormField(
                          controller: emailController,
                          cursorColor: Style.SecondryColor,
                          style: TextStyle(fontSize: 14.0.sp, color: Style.MainTextColor),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Translations.of(context)!.Email_Validation;
                            }
                            return null;
                          },
                          decoration: InputDecoration(

                              hintText: Translations.of(context)!.Email,
                              // labelStyle: TextStyle(fontSize: 12.0.sp, color: Style.GreyColor),
                              //  labelText: Translations.of(context)!.Code,
                              hintStyle: TextStyle(fontSize: 12.0.sp,
                                color: Style.GreyColor,),
                              errorStyle: TextStyle(fontSize: 12.0.sp,
                                  color: Colors.red)
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          }
                      ),),
                    ),
                  ],),

                  // Login Button
                  InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0.w, 0.5.h, 10.0.w, 0.5.h),
                        margin: EdgeInsets.fromLTRB(0, 10.0.h, 0, 0),
                        decoration: Style.ButtonDecoration,
                        child:  Text(
                          Translations.of(context)!.send,
                          style: TextStyle(color: Colors.white,
                              fontSize: 15.0.sp),

                          textAlign: TextAlign.center,

                        ),

                      ),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showLoading();
                          var res = await EditCustomer(context, mobileController.text,nameController.text,emailController.text);
                          hideLoading();
                          if (res != null) {
                            setState(() {
                              DelegateData.delegateData=res;
                            });
                            Navigator.pushNamed(context, homeRoute);
                          }
                          hideLoading();
                        }
                      }
                  ),

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }

  Future<void> GetData()
  async {

    if(DelegateData.delegateData!= null && DelegateData.delegateData!.id!>0) {
      showLoading();
      setState(() {
        nameController.text = DelegateData.delegateData!.name!;
        mobileController.text = DelegateData.delegateData!.mobile!;
        emailController.text = DelegateData.delegateData!.email!;
      });
      hideLoading();
    }
    else
    {
      await AlertView2(context);
    }

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