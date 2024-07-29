import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio; // dio 패키지 임포트에 별칭 사용

class ProfileController extends GetxController {
  var selectedImage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? selectImage = await _picker.pickImage(
      source: imageSource,
/*      maxHeight: 75,
      maxWidth: 75,
      imageQuality: 60, // 이미지 크기 압축 위해 퀼리티 30으로 낮춤*/
    );

    if (selectImage != null) {
      selectedImage.value = selectImage;
      await patchUserProfileImage(selectImage.path);
    }
  }

  Future<void> patchUserProfileImage(String filePath) async {
    print("프로필 사진을 서버에 업로드 합니다.");
    var dioClient = dio.Dio();
    try {
      dioClient.options.contentType = 'multipart/form-data';
      dioClient.options.headers = {'token': 'your_token_here'};
      //'your_token_here' 부분에는 인증 토큰을 넣어야 한다.
      //서버에 접근할 때 사용되는 인증 정보입니다. 보통은 로그인 시 서버로부터 받은 토큰을 사용

      // dio.MultipartFile 생성
      final sendData = await dio.MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      // dio.FormData 생성
      final formData = dio.FormData.fromMap({'image': sendData});

      var response = await dioClient.patch(
        'baseUri/users/profileimage', // 적절한 baseUri와 엔드포인트를 설정하세요
        //API 서버의 기본 URL이 https://api.example.com이라면:
        //baseUri는 https://api.example.com
        // 엔드포인트는 /users/profileimage
        // '$baseUri/users/profileimage', // baseUri와 엔드포인트를 조합하여 전체 URL
        data: formData,
      );
      print('성공적으로 업로드했습니다');
      return response.data;
    } catch (e) {
      print("이미지 업로드 중 오류 발생: $e");
    }
  }
}
