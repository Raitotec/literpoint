import 'package:gas_services_new/Shared_Data/LanguageData.dart';

class AboutModel {

  String? work_times;
  String? description;



  AboutModel.fromJson(Map<String, dynamic> json) {
      description=json['description']!=null?json['description']:"";
    work_times=json['work_times']!=null?json['work_times']:"";

  }

  AboutModel(this.description, this.work_times );
}


