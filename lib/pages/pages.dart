import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_assignment/core/constants/constants.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/core/routes/app_routes.dart';
import 'package:flutter_assignment/core/utils/utils.dart';
import 'package:flutter_assignment/pages/widgets/widgets.dart';
import 'package:flutter_assignment/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_editor/stories_editor.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_page.dart';
part 'home_page.dart';
part 'about_us.dart';
part 'contact_us.dart';
part 'edit image.dart';