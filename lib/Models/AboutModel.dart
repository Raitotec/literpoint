import 'package:gas_services_new/Shared_Data/LanguageData.dart';

class AboutModel {
  String? sloganEN;
  String? ourMessageEN;
  String? ourVisionEN;
  List<String>? ourValuesEN;
  String? sloganAR;
  String? ourVisionAR;
  String? ourMessageAR;
  List<String>? ourValuesAR;

  AboutModel(
      {this.sloganEN,
        this.ourMessageEN,
        this.ourVisionEN,
        this.ourValuesEN,
        this.sloganAR,
        this.ourVisionAR,
        this.ourMessageAR,
        this.ourValuesAR});

  AboutModel.fromJson(Map<String, dynamic> json) {
    sloganEN = json['slogan_EN']!= null?json['slogan_EN'].toString():"";
    ourMessageEN = json['OurMessage_EN']!= null?json['OurMessage_EN'].toString():"";
    ourVisionEN = json['OurVision_EN']!= null?json['OurVision_EN'].toString():"";
    ourValuesEN =json['OurValues_EN']!= null? json['OurValues_EN'].cast<String>():[];
    sloganAR = json['slogan_AR']!= null?json['slogan_AR'].toString():"";
    ourVisionAR = json['OurVision_AR']!= null?json['OurVision_AR'].toString():"";
    ourMessageAR = json['OurMessage_AR']!= null?json['OurMessage_AR'].toString():"";
    ourValuesAR = json['OurValues_AR']!= null?json['OurValues_AR'].cast<String>():[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slogan_EN'] = this.sloganEN;
    data['OurMessage_EN'] = this.ourMessageEN;
    data['OurVision_EN'] = this.ourVisionEN;
    data['OurValues_EN'] = this.ourValuesEN;
    data['slogan_AR'] = this.sloganAR;
    data['OurVision_AR'] = this.ourVisionAR;
    data['OurMessage_AR'] = this.ourMessageAR;
    data['OurValues_AR'] = this.ourValuesAR;
    return data;
  }
}


