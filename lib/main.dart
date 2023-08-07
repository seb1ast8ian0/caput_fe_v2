import 'package:Caput/caput_app.dart';
import 'package:Caput/domain/bloc/tags/tags_bloc.dart';
import 'package:Caput/domain/get/database_controller.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() async {

  //dev branch

  Get.put(TagsList([]));
  Get.put(DatabaseController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState())
      ],
      child: const Caput(),
    )
  );
  
}