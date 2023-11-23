import 'dart:io';

import 'package:flutter_assignment/core/constants/constants.dart';
import 'package:flutter_assignment/core/utils/utils.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/services/services.dart';
import 'package:flutter_assignment/pages/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'state_picker.dart';
part 'status_picker.dart';

class AppDialogs {
  AppDialogs._();

  static Future<String?> showGenderPicker(BuildContext context,) {
    return _GenderPicker.showSheet(context);
  }

  static Future<String?> showStatusPicker(BuildContext context) {
    return _StatusPicker.showSheet(context);
  }


}
