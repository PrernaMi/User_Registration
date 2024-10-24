import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/providers/offline_data_provider.dart';

import '../model/user_model.dart';

class PendingSubmission extends StatefulWidget{

  @override
  State<PendingSubmission> createState() => _PendingSubmissionState();
}

class _PendingSubmissionState extends State<PendingSubmission> {
  List<UserModel> mList =[];
  @override
  void initState() {
    context.read<OfflineDataProvider>().getInitialOfflineList();
    mList = context.watch<OfflineDataProvider>().getList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Currently added forms")),
      ),
      body: ListView.builder(
        itemCount: mList.length,
          itemBuilder: (context,index){
        return ListTile(
          title: Text(mList[index].name),
        );
      }),
    );
  }
}