import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_services_new/Models/LineChartModel.dart';
import 'package:gas_services_new/Shared_Data/DelegateData.dart';

import '../Constans/Api_Services.dart';
import '../Constans/Base_Url.dart';
import '../Localization/Translations.dart';
import '../Models/AboutModel.dart';
import '../Models/DataModel.dart';
import '../Models/DelegateDataModel.dart';
import '../Shared_Data/LanguageData.dart';
import '../Shared_Data/NetworkCheckData.dart';
import '../Shared_View/AlertView.dart';

Future<AboutModel?> About_us(BuildContext context) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        var data = jsonEncode(<String, String>{
          "lang": lang,

        });
        final response = await Post_Data(aboutus, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_About_us200 ::: ${valueMap['message']} ${valueMap['data']}");
           // await AlertView(context, "success", Translations.of(context)!.Ok,Translations.of(context)!.success_msg);
            return  valueMap['data'] != null ? new AboutModel.fromJson(valueMap['data']) : null;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_About_us400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_LAbout_usstatusCode400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_About_usException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_About_usException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_About_usException ::: ${e} ");
    return null;
  }
}

Future<bool?> Contact_us(BuildContext context,String mobile ,String first_name,String comment,String email,String contacttype) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        var data = jsonEncode(<String, String>{
          'phone': mobile,
          "lang": lang,
          "email":DelegateData.delegateData!.id.toString(),
          "name":first_name,
          "message":comment,
          "contacttype":contacttype
        });
        final response = await Post_Data(contact, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_Contact_us200 ::: ${valueMap['message']} ${valueMap['data']}");
            await AlertView(
                context, "success", Translations.of(context)!.Ok,Translations.of(context)!.success_msg);

            return true;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_Contact_us400 ::: ${valueMap['message']} ${valueMap['data']}");
            return false;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_LContact_usstatusCode400 ::: ${response.statusCode} ");
          return false;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_Contact_usException ::: ${e} ");
        return false;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_Contact_usException ::: checkInternet ");
      return false;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_Contact_usException ::: ${e} ");
    return false;
  }
}


Future<List<CityModel>?> GetCity(BuildContext context ) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        final dataa = {
          "lang": lang,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);
        final response = await Get_Data(cities, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_GetCity200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<CityModel> obj= <CityModel>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj!.add(new CityModel.fromJson(v));
              });
            }

            return obj;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_GetCity400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_GetCity400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_GetCityException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_GetCityException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_GetCitysException ::: ${e} ");
    return null;
  }
}

Future<List<CityModel>?> GetNeighborhoods(BuildContext context ,String city) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        final dataa = {
          "lang": lang,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);
        final response = await Get_Data(neighborhoods+"/"+city, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_GetNeighborhoods200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<CityModel> obj= <CityModel>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj!.add(new CityModel.fromJson(v));
              });
            }

            return obj;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_GetNeighborhoods400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_GetNeighborhoods400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_GetNeighborhoodsException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_GetNeighborhoodsException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_GetNeighborhoodsException ::: ${e} ");
    return null;
  }
}


Future<String?> StationReviews(BuildContext context) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        final dataa = {
          "lang": lang,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);
        final response = await Get_Data(qr_code, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_StationReviews200 ::: ${valueMap['message']} ${valueMap['data']['description']}");
            // await AlertView(context, "success", Translations.of(context)!.Ok,Translations.of(context)!.success_msg);
            return valueMap['data']['link'];
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_StationReviews400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_StationReviewsstatusCode400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_StationReviewsException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_StationReviewsException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_StationReviewsException ::: ${e} ");
    return null;
  }
}

Future<List<DataModel>?> GetServices(BuildContext context ) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        final dataa = {
          "lang": lang,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);
        final response = await Get_Data(AllServices, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_GetGetServices200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<DataModel> obj= <DataModel>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj!.add(new DataModel.fromJson(v));
              });
            }

            return obj;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_GetServices400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_GetServices400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_GetServicesException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_GetServicesException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_GetServicesException ::: ${e} ");
    return null;
  }
}

Future<String?> Balance(BuildContext context,String id) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        var data = jsonEncode(<String, String>{
          "lang": lang,
          "customer_id":id
        });
        final response = await Post_Data(balance, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_About_us200 ::: ${valueMap['message']} ${valueMap['data']}");
            // await AlertView(context, "success", Translations.of(context)!.Ok,Translations.of(context)!.success_msg);
            return valueMap['data']['balance'].toString();
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_About_us400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_LAbout_usstatusCode400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_About_usException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_About_usException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_About_usException ::: ${e} ");
    return null;
  }
}

Future<List<DataModel>?> GetBranches(BuildContext context ) async {
  try {
    bool InternetConntected = await hasNetwork();
    if (InternetConntected) {
      try {
        var lang= LanguageData.languageData;
        print(lang);
        final dataa = {
          "lang": lang,
        };
        Map<String, String> data = new Map<String, String>.from(dataa);
        print(dataa);
        print(data);
        final response = await Get_Data(branches, data);
        print(response.body);
        if (response.statusCode == 200) {
          Map valueMap = jsonDecode(response.body);
          if (valueMap['code'] == 200) {
            print( " fn_GetGetServices200 ::: ${valueMap['message']} ${valueMap['data']}");
            List<DataModel> obj= <DataModel>[];
            if (valueMap['data'] != null) {
              valueMap['data'].forEach((v) {
                obj!.add(new DataModel.fromJson(v));
              });
            }

            return obj;
          }
          else {
            await AlertView(
                context, "error", Translations.of(context)!.ErrorTitle,valueMap['data'].toString());
            print( "fn_GetServices400 ::: ${valueMap['message']} ${valueMap['data']}");
            return null;
          }
        }
        else {
          await AlertView(
              context, "error", Translations.of(context)!.ErrorTitle,
              "error_statusCode ${response.statusCode} ${response.reasonPhrase}");
          print( "fn_GetServices400 ::: ${response.statusCode} ");
          return null;
        }
      }
      catch(e)
      {
        await AlertView(
            context, "error", Translations.of(context)!.ErrorTitle,
            "Exception : ${e.toString()}");
        print( "fn_GetServicesException ::: ${e} ");
        return null;
      }
    }
    else {
      await AlertView(
          context, "error", Translations.of(context)!.ErrorTitle,
          Translations.of(context)!.CheckInternet);
      print("fn_GetServicesException ::: checkInternet ");
      return null;
    }
  }
  catch (e) {
    await AlertView(
        context, "error", Translations.of(context)!.ErrorTitle,
        "Exception : ${e.toString()}");
    print("fn_GetServicesException ::: ${e} ");
    return null;
  }
}

/*
List<DataModel> GetCity(BuildContext context,String Country_id)
{

  var DataList= <DataModel>[];

  DataList.add(new DataModel(1, "City1"+"_"+Country_id));
  DataList.add(new DataModel(2, "City2"+"_"+Country_id));
  DataList.add(new DataModel(3, "City3"+"_"+Country_id));

  return DataList;
}
List<DataModel> GetCountry(BuildContext context)
{

  var DataList= <DataModel>[];

  DataList.add(new DataModel(1, "Country1"));
  DataList.add(new DataModel(2, "Country2"));
  DataList.add(new DataModel(3, "Country3"));

  return DataList;
}*/