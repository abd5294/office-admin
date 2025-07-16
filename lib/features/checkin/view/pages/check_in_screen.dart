import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/checkin/controller/check_in_out_controller.dart';
import 'package:office/features/checkin/controller/check_in_out_state.dart';
import 'package:office/features/checkin/view/pages/checkin_error_screen.dart';
import 'package:office/shared/widgets/large_button.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  static const route = '/check-in-employee';

  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  File? _selectedImage;
  String type = 'checkin';

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(
      checkInOutControllerProvider(_selectedImage?.path).notifier,
    );

    final controllerState = ref.watch(
      checkInOutControllerProvider(_selectedImage?.path),
    );
    ref.listen<CheckInOutState>(
      checkInOutControllerProvider(_selectedImage?.path),
      (previous, next) {
        if (next is CheckInOutSuccess) {
          showSnackBar(context, 'Check In Successful');
          context.pop();
        }
        if (next is CheckInOutFailure) {
          showSnackBar(context, next.errorMessage);
          context.push(
            '${CheckinErrorScreen.route}?error=${next.errorMessage}',
          );
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Palette.primaryColor,
          ),
        ),
        title: const Text(
          'Check In',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 400)
                    : const Icon(
                      Icons.image_rounded,
                      size: 300,
                      color: Color(0xFFb4dbff),
                    ),
                const Spacer(),
                Visibility(
                  visible: controllerState is CheckInOutLoading,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 12),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),

                SizedBox(height: 12),
                LargeButton(
                  text: _selectedImage != null ? type : 'Open Camera',
                  onPressed: () {
                    if (controllerState is CheckInOutLoading) {
                      return;
                    }
                    if (type == '') {
                      showSnackBar(context, 'Select checkIn or CheckOut');
                      return;
                    }

                    _selectedImage == null
                        ? pickImageFromCamera()
                        : controller.createCheckIn(type);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImageFromCamera() async {
    final status = await Permission.camera.request();

    if (!status.isGranted) {
      showSnackBar(context, 'Camera permission is required');
    }
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
