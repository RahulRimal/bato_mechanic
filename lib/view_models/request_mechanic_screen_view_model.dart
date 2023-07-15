import 'dart:async';
import 'dart:io';

import 'package:bato_mechanic/models/mechanic.dart';
import 'package:bato_mechanic/models/vehicle.dart';
import 'package:bato_mechanic/models/vehicle_repair_request.dart';
import 'package:bato_mechanic/view_models/base_view_model.dart';
import 'package:bato_mechanic/view_models/map_search_widget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../models/vehicle_category.dart';
import '../utils/toast_helper.dart';

mixin RequestMechanicScreenViewModel
    on ChangeNotifier, BaseViewModel, MapSearchWidgetViewModel {
  List<Mechanic> _recommendedMechanics = [];
  Mechanic? _preferedMechanic;
  VehicleRepairRequest? _repairRequest;
  late TextEditingController _issueDescriptionController;

  VideoPlayerController? _videoController;
  List<File> _selectedImages = [];
  ImagePicker _imagePicker = ImagePicker();

  List<Mechanic> get rmsRecommendedMechanics => _recommendedMechanics;
  set rmsRecommendedMechanics(List<Mechanic> value) {
    _recommendedMechanics = value;
    notifyListeners();
  }

  Mechanic? get rmsPreferedMechanic => _preferedMechanic;
  set rmsPreferedMechanic(Mechanic? value) {
    _preferedMechanic = value;
    notifyListeners();
  }

  VehicleRepairRequest? get rmsRepairRequest => _repairRequest;
  set rmsRepairRequest(VehicleRepairRequest? value) {
    _repairRequest = value;
    notifyListeners();
  }

  TextEditingController get rmsIssueDescriptionController =>
      _issueDescriptionController;
  // set rmsIssueDescriptionController(TextEditingController value) {
  //   _issueDescriptionController = value;
  //   notifyListeners();
  // }

  VideoPlayerController? get rmsVideoController => _videoController;
  set rmsVideoController(VideoPlayerController? value) {
    _videoController = value;
    notifyListeners();
  }

  List<File> get rmsSelectedImages => _selectedImages;
  set rmsSelectedImages(List<File> value) {
    _selectedImages = value;
    notifyListeners();
  }

  ImagePicker get rmsImagePicker => _imagePicker;
  set rmsImagePicker(ImagePicker value) {
    _imagePicker = value;
    notifyListeners();
  }

  Future<void> rmsPickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage(
      imageQuality: 80, // Adjust the image quality as desired
    );

    _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
    notifyListeners();
  }

  Future<void> rmsPickVideo() async {
    final XFile? video =
        await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _videoController = VideoPlayerController.file(File(video.path));
      await _videoController!.initialize();
      // setState(() {});
      notifyListeners();
    }
  }

  rmsRequestForVehicleRepair(BuildContext context) async {
    String coordinates =
        '${mechanicProvider.mswMarkerPosition.latitude},${mechanicProvider.mswMarkerPosition.longitude}';

    Map<String, dynamic> requestData = {
      "customer": 1,
      "preferred_mechanic": mechanicProvider.rmsPreferedMechanic!.id,
      "location_name": mechanicProvider.mapProvider.mswSelectedPlaceName,
      "location_coordinates": coordinates,
      "vehicle": mechanicProvider.vehicleProvider.selectedVehicle!.id,
      "vehicle_part":
          mechanicProvider.vehiclePartProvider.selectedVehiclePart!.id,
      "description": mechanicProvider.rmsIssueDescriptionController.text,
    };

    systemProvider.showLoadingWithMessageOptional(context,
        message: 'Requesting for vehicle repair');
    // Future.delayed(const Duration(seconds: 5), () {

    // });

    if (await vehicleRepairRequestProvider
        .createVehicleRepairRequest(requestData)) {
      systemProvider.showLoadingWithMessageOptional(context,
          message: 'Adding images');
      if (await vehicleRepairRequestProvider.addImagesToVechicleRepairRequest(
          vehicleRepairRequestProvider.vehicleRepairRequests.last.id.toString(),
          _selectedImages)) {
        systemProvider.closeLoading(context);
        ToastHelper.showNotification(
            context, 'Request sent successfully, We will contact you soon!');
      }
    }
  }

  bindRMSViewModel(BuildContext context, WidgetsBindingObserver observer) {
    bindBaseViewModal(context);
    _issueDescriptionController = TextEditingController();
    // Register this object as an observer
    WidgetsBinding.instance.addObserver(observer);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      rmsRecommendedMechanics = await mechanicProvider.fetchRecomendedMechanics(
          vehicleCategoryProvider.selectedVehicleCategory!.name.toLowerCase(),
          vehiclePartProvider.selectedVehiclePart!.name.toLowerCase());
    });
  }

  unBindRMSViewModel(WidgetsBindingObserver observer) {
    unBindBaseViewModal();
    _videoController?.dispose();
    // Unregister this object as an observer
    WidgetsBinding.instance.removeObserver(observer);
  }
}
