import 'dart:async';
import 'dart:io';

import 'package:bato_mechanic/models/mechanic.dart';
import 'package:bato_mechanic/models/vehicle_repair_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../utils/toast_helper.dart';
import '../base/base_view_model.dart';
import '../../providers/mechanic_provider.dart';

class RequestMechanicScreenViewModel extends MechanicProvider
    with BaseViewModel, ViewModelInputs, ViewModelOutputs {
  init(BuildContext context) async {
    initViewModels(context);
    // super.recommendedMechanics =
    var response = await super.fetchRecomendedMechanics(
        vehicleCategoryViewModel.selectedVehicleCategory!.name.toLowerCase(),
        vehiclePartViewModel.selectedVehiclePart!.name.toLowerCase());
    if (response is List<Mechanic>) _recommendedMechanics = response;
  }

  destroy() {
    _videoController?.dispose();
  }

  Future<void> pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage(
      imageQuality: 80, // Adjust the image quality as desired
    );

    _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
    notifyListeners();
  }

  Future<void> pickVideo() async {
    final XFile? video =
        await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _videoController = VideoPlayerController.file(File(video.path));
      await _videoController!.initialize();
      notifyListeners();
    }
  }

  removeSelectedImage(File image) {
    _selectedImages.remove(image);
    notifyListeners();
  }

  requestForVehicleRepair(BuildContext context) async {
    String coordinates =
        '${mapViewModel.markerPosition.latitude},${mapViewModel.markerPosition.longitude}';
    if (mapViewModel.selectedPlaceName == null ||
        mapViewModel.selectedPlaceName!.isEmpty) {
      ToastHelper.showNotification(
        context,
        'Please select a place',
        notificationDuration: 2,
      );
      return;
    }
    if (_issueDescriptionController.text.isEmpty) {
      ToastHelper.showNotification(
        context,
        'Please describe your issue in details',
        notificationDuration: 2,
      );
      return;
    }
    if (_selectedImages.isEmpty) {
      ToastHelper.showNotification(
        context,
        'Please post some images showing the issue',
        notificationDuration: 2,
      );
      return;
    }
    if (_videoController == null) {
      ToastHelper.showNotification(
        context,
        'Please post a video showing the issue',
        notificationDuration: 2,
      );
      return;
    }
    if (_preferedMechanic == null) {
      ToastHelper.showNotification(
        context,
        'Please select your preferred mechanic',
        notificationDuration: 2,
      );
      return;
    }
    _issueDescriptionFocusNode.unfocus();
    Map<String, dynamic> requestData = {
      "customer": 1,
      "preferred_mechanic": _preferedMechanic!.id,
      "location_name": mapViewModel.selectedPlaceName,
      "location_coordinates": coordinates,
      "vehicle": vehicleViewModel.selectedVehicle!.id,
      "vehicle_part": vehiclePartViewModel.selectedVehiclePart!.id,
      "description": _issueDescriptionController.text,
    };
    systemProvider.showLoadingWithMessageOptional(context,
        message: 'Requesting for vehicle repair');
    if (await vehicleRepairRequestViewModel
        .createVehicleRepairRequest(requestData)) {
      systemProvider.showLoadingWithMessageOptional(context,
          message: 'Adding images');
      if (await vehicleRepairRequestViewModel.addImagesToVechicleRepairRequest(
          vehicleRepairRequestViewModel.vehicleRepairRequests.last.id
              .toString(),
          _selectedImages)) {
        systemProvider.closeLoading(context);
        ToastHelper.showNotification(
            context, 'Request sent successfully, We will contact you soon!');
      }
    }
  }
}

mixin ViewModelInputs {
  List<Mechanic> _recommendedMechanics = [];
  Mechanic? _preferedMechanic;
  VehicleRepairRequest? _repairRequest;
  final TextEditingController _issueDescriptionController =
      TextEditingController();
  final FocusNode _issueDescriptionFocusNode = FocusNode();

  VideoPlayerController? _videoController;
  List<File> _selectedImages = [];
  ImagePicker _imagePicker = ImagePicker();

  List<Mechanic> get recommendedMechanics => _recommendedMechanics;

  Mechanic? get preferedMechanic => _preferedMechanic;

  VehicleRepairRequest? get repairRequest => _repairRequest;

  TextEditingController get issueDescriptionController =>
      _issueDescriptionController;
  // set rmsIssueDescriptionController(TextEditingController value) {
  //   _issueDescriptionController = value;
  //   notifyListeners();
  // }

  FocusNode get issueDescriptionFocusNode => _issueDescriptionFocusNode;

  VideoPlayerController? get videoController => _videoController;

  List<File> get selectedImages => _selectedImages;

  ImagePicker get imagePicker => _imagePicker;
}

mixin ViewModelOutputs on ChangeNotifier, ViewModelInputs {
  set recommendedMechanics(List<Mechanic> value) {
    _recommendedMechanics = value;
    notifyListeners();
  }

  set preferedMechanic(Mechanic? value) {
    _preferedMechanic = value;
    notifyListeners();
  }

  set repairRequest(VehicleRepairRequest? value) {
    _repairRequest = value;
    notifyListeners();
  }

  set videoController(VideoPlayerController? value) {
    _videoController = value;
    notifyListeners();
  }

  set selectedImages(List<File> value) {
    _selectedImages = value;
    notifyListeners();
  }

  set imagePicker(ImagePicker value) {
    _imagePicker = value;
    notifyListeners();
  }
}
