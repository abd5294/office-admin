import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:office/core/themes/app_color.dart';
import 'package:office/core/utils/show_snackbar.dart';
import 'package:office/features/checkin/controller/check_in_out_controller.dart';
import 'package:office/shared/widgets/large_button.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInOutScreen extends ConsumerStatefulWidget {
  static const route = '/check-in-out-employee';

  const CheckInOutScreen({super.key});

  @override
  ConsumerState<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends ConsumerState<CheckInOutScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(
      checkInOutControllerProvider(_selectedImage?.path).notifier,
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
                    ? Image.file(_selectedImage!)
                    : const Icon(
                      Icons.image_rounded,
                      size: 300,
                      color: Color(0xFFb4dbff),
                    ),
                const Spacer(),
                LargeButton(
                  text: _selectedImage != null ? 'Check In' : 'Open Camera',
                  onPressed: () {
                    _selectedImage == null
                        ? pickImageFromCamera()
                        : controller.createCheckIn();
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
