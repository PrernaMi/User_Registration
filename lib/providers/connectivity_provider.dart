import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier{
  bool _isOnline = true;
   void setNetwork({required bool status}){
     //if true then online
     _isOnline = status;
     notifyListeners();
   }

   bool getNetwork() => _isOnline;
}