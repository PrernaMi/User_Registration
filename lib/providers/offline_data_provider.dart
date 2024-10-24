import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class OfflineDataProvider extends ChangeNotifier{

  SharedPreferences?prefs;
  List<UserModel> _mList =[];

  void setOfflineData(UserModel newUser)async{
    prefs = await SharedPreferences.getInstance();
    _mList.add(newUser);
    //add this updated mList in sharedPrefs
    prefs!.setString("offlineData",jsonEncode(_mList));
    notifyListeners();
  }

  List<UserModel> getList(){
    return _mList;
  }

  void getInitialOfflineList()async{
    prefs = await SharedPreferences.getInstance();
    dynamic data = prefs!.getString('offlineData')??[];
    _mList = jsonDecode(data!);
  }
}