import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedImage = Rx<XFile?>(null);
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImage.value = XFile(pickedFile.path);
    }
  }
}