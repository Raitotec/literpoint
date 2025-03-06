import 'package:gas_services_new/Constans/Base_Url.dart';
import 'package:gas_services_new/Shared_Data/LanguageData.dart';

class DataModel {
  int? id;
  String? name;
  String? img;
  String? desc;
  String? city;
  String? icon;



  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name']!=null?json['name']:"";
    img = json['image']!=null?json['image']:"";
    if(LanguageData.languageData=="ar")
    {
      desc=json['desc_ar']!=null?json['desc_ar']:"";
    }
    else
    {
      desc=json['desc_en']!=null?json['desc_en']:"";
    }
    city= json['city']!=null?json['city']:"";

    icon = json['icon']!= null?json['icon'] :"";
  }

  DataModel(this.id, this.name,this.img,this.desc , this.icon);
}


