# real_test

만들고 있는 플러터 프로젝트입니다.

Camera_Page (O)

Main_Page (O)

Sign_Up_Page (O)

Dismiss_Keyboard.dart (O)

Fake_Splash.dart (O)

main.dart (O)

Providers (*)

User_Registration_Page (X)

O 는 작업이 끝난 것들
X 은 아직 시작하지 않은 것들
* 은 수정이 필요한 것들
입니다.

현재 "로그인 버튼"과 "현재 동영상으로 진행 버튼"은 User_Registration_Page/User_Registration.dart와 연동이 되어 있으며
협업을 할 사람은 디자인한 것에 맞춰 User_Registration.dart에서 코드를 짜주시면 됩니다.

# 주의사항

assets 폴더는 각종 이미지나 svg 애니메이션 json 파일을 넣어두는 곳으로 임의로 "삭제", "이동"을 하지 말아주시길 바랍니다.
페이지를 만들다가 필요하다면 언제든 assets에 "추가"하는 건 가능합니다.

android/build.gradle과 android/app/build.gradle은 이미 건드려 놓은 상태이니 건들어야 하는 상황이 온다면
꼭 팀원에게 말해주시길 바랍니다.

평소에 빌드를 할 때는 debug 모드로 빌드를 하되
테스트 결과를 보고 싶다면 터미널에 flutter run --release를 써주세요.

그리고 빌드할 때 코틀린 버전과 관련된 오류가 뜰 겁니다. 앱을 빌드할 때 지장이 가지 않는 오류이니
무시해주시길 바랍니다.

코드는 300줄 이상이 넘어가면 가독성이 굉장히 떨어집니다.
되도록이면 200줄 내외로 코드를 작성해주시고 너무 길어진다면 파일을 쪼개서 import하는 방식을 추천드립니다.

앱은 상태 관리가 굉장히 중요하기 때문에 pubspec.yaml에 있는 provider를 꼭 잘 활용해 주시길 바랍니다.

# PR 규칙

제목: 이름 / 날짜
ex) 최지온 / 2024.07.14

내용: 수정사항 정리해서 쓰기
ex)
~~를 수정했습니다.
~~의 버그를 고쳤습니다.
~~를 추가했습니다.
