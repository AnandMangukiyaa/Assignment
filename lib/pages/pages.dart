import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_assignment/blocs/images/images_bloc.dart';
import 'package:flutter_assignment/blocs/images/images_state.dart';
import 'package:flutter_assignment/blocs/user/user_bloc.dart';
import 'package:flutter_assignment/core/constants/constants.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/core/routes/app_routes.dart';
import 'package:flutter_assignment/core/utils/utils.dart';
import 'package:flutter_assignment/pages/widgets/widgets.dart';
import 'package:flutter_assignment/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:stories_editor/stories_editor.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img;
import 'package:gallery_media_picker/src/provider/gallery_provider.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';


part 'login_page.dart';
part 'home_page.dart';
part 'about_us.dart';
part 'contact_us.dart';
part 'edit image.dart';
part 'saved_images.dart';
part 'users_page.dart';