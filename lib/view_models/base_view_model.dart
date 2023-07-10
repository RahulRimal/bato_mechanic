import 'package:bato_mechanic/view_models/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin BaseViewModel on ChangeNotifier {
  late MapProvider mapProvider;

  // Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  bindBaseViewModal(BuildContext context) {
    mapProvider = Provider.of<MapProvider>(context, listen: false);
  }

  unBindBaseViewModal() {}
}
