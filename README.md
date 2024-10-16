# real_test

만들고 있는 플러터 프로젝트입니다.

무엇을 해야 하는지 모르겠다면 Issue 탭의 EPIC, FEAT, TASK를 봐주시길 바랍니다.

# Git에서 Commit 하는 법

## 주의사항

1. EPIC은 Issues로만 올립니다.
2. Branch는 FEAT 단위로 합니다.
3. Commit은 TASK 단위로 합니다.

이제 git bash를 사용하는 방법을 알려드리겠습니다.

## 1. Feature 브랜치
1-1. 새로운 기능을 개발하기 위한 브랜치입니다.

1-2. 아래에 서술할 브랜치 규칙을 꼭 지켜주시길 바랍니다.

터미널에서

git checkout -b FEAT/FEAT번호

이런 식으로 작성해서 브랜치를 만들면 됩니다.

* 예시: git checkout -b FEAT/#2
* 지금 서술한 FEAT/#2는 EPIC : UI에 있는 #2 FEAT : User Choice Page Layout을 말하는 것입니다.
* 요약하면 FEAT 번호로 브랜치를 만들면 됩니다.

## 2. 작업하고 커밋하기

현재 안드로이드 스튜디오를 쓰고 있기 때문에 git add . 을 하기 전에 git init을 해줘야 합니다.

터미널을 켠 뒤

1. git init
2. git add .
3. git commit -m "TASK #번호 : 내용 간단 요약"

* 예시: git commit -m "TASK #3 : ~~페이지 디자인을 했습니다."
* 커밋 메시지는 "~~를 했습니다.", "~~를 수정했습니다." 등등 내용을 이해할 수 있다면 어떤 식으로 쓰든 상관 없습니다.
* 지금 서술한 TASK #3는 Epic: UI에 있는 #2 FEAT : User Choice Page Layout 안에 있는 TASK : User Choice Page Design을 말하는 것입니다.
* 요약하면 "TASK #번호 : 내용" 으로 커밋메시지를 적어주시면 됩니다.

## 3. 푸쉬하고 PR 올리기

1. git push -u origin FEAT/#번호

2. 예시:ㅣ git push -u origin FEAT/#2

우리는 fork를 해서 올리기 때문에 IPL_EyeTracker_FE에 PR을 올려야 합니다.

Merge가 필요하다면 꼭 팀원에게 말해주세요.

PR을 하나 올렸다면 또 올리지 말아주세요.

## 4. 브랜치 삭제 (필요한 경우에만)

작업이 끝나고 병합된 브랜치를 삭제할 수도 있습니다.

git branch -d 아까 만든 브랜치 이름

예시: git branch -d FEAT/#2

강제로 지우고 싶다면 git branch -D 아까 만든 브랜치 이름을 하시면 됩니다.

예시: git branch -D FEAT/#2

# 주의사항

1. 만약 TASK, 즉 할 일이 끝났다면 TASK만 Close 해주시길 바랍니다.
2. FEAT, EPIC은 모든 작업이 끝난 후 교차 검증을 한 뒤 Close 할 겁니다.
3. EPIC, FEAT, TASK를 헷갈리지 않게 꼭 꼼꼼히 확인하고 브랜치를 만들어주시길 바랍니다.
4. 필요하다면 언제든 EPIC, FEAT, TASK를 만들어도 되지만 꼭 팀원에게 말해주시길 바랍니다.
5. 후일 SERVER와 연동을 해야 할 때 EPIC : SERVER 이슈를 만들 것이니 아직은 만들지 말아주시길 바랍니다.


# 만약 이런 방식이 아니라 간단한 토이 프로젝트 용으로 하나의 레포에서 커밋만 하고 싶다면

## 1. Repositories 만들기

아무렇게 이름을 만들고 빈 Repository를 만들어줍니다.

되도록이면 README.md 파일을 추가하지 않고 빈 Repository를 만들어주시길 바랍니다.

## 2. 원격 레포지토리 연결하기

만약 안드로이드 스튜디오에서 프로젝트를 처음 만들었다면 .git 폴더가 없습니다. 

.git 폴더가 있어야 원격으로 Repository에 연결할 수 있습니다.

일단 처음 만든 프로젝트의 안드로이드 스튜디오 터미널을 열어주고 git init을 작성합니다.

그러면 자동으로 .git 폴더가 생깁니다.

그리고

git remote add origin "Repository 주소"

이 명령어를 작성하면 이전에 생성했던 빈 Repository로 테스트용 프로젝트가 연결이 됩니다.

만약 원격 Repository와 잘 연결이 됐는지 확인하고 싶다면

git remote -v

명령어를 작성하면 됩니다.

보통 저 명령어를 작성하면 터미널 창에

origin  https://github.com/username/repository.git (fetch)
origin  https://github.com/username/repository.git (push)

이런 식으로 연결된 주소가 올라옵니다.

## 3. 파일 추가하기

연결이 잘 됐다면 이제 파일들을 추가해야 합니다.

터미널에

git init

이라는 명령어를 쳐주면 Reinitialized ~~~ 라고 뜰 것입니다.

앞으로 수정한 코드를 커밋해서 푸쉬해야 하는 상황이 오면 항상 맨 처음으로

저 명령어를 쳐주세요. 필수입니다.

다음으로

git add .

명령어를 작성해주세요.

여기서 . 은 initialized된 프로젝트의 모든 폴더를 푸쉬하겠다는 뜻입니다.

만약 특정 파일이나 폴더만 올리고 싶다면

git add 특정 파일 이름

이런 식으로 작성해주면 됩니다.

상황에 따라 다르긴 하지만 가끔씩 알 수 없는 Warning이 뜨기도 하고

맥이랑 윈도우랑 같은 Repository를 쓸 경우에 생기는 경고가 뜨기도 합니다. 

그냥 무시하고 명령어를 한 번 더 쳐주세요.

## 4. 커밋하기

이제 커밋을 할 차례입니다.

커밋을 할 때는 메시지를 작성해야 하고, 그 메시지를 어떻게 써야 하는지 다양한 규칙이 있지만

그건 협업을 하는 팀원과 잘 상의하시길 바라고

여기서는 그냥 커밋 메시지를 TEST라고 하겠습니다.

일단

git commit -m "TEST"

라는 명령어를 쳐주면

예시 : 6 files changed, 214 insertions(+), 97 deletions(-)

이런 식으로 몇 개의 파일이 바뀌었고, 몇 개의 코드 줄이 추가되었고, 몇 개의 코드 줄이 삭제되었는지 로그가 뜹니다.

만약 커밋 메시지를 수정하고 싶다면

git commit --amend -m "수정할 메시지"

이렇게 명령어를 작성해주세요.

## 5. 푸쉬하기

5-1. 원격 레포지토리도 연결했고

5-2. 파일도 추가했고

5-3. 커밋 메시지까지 작성했다면

푸쉬를 하면 됩니다.

git push origin master

명령어를 작성해주세요.

만약 내가 사용 중인 branch가 뭔지 모르겠다면

안드로이드 스튜디오의 좌측 상단을 보고 branch 이름을 확인하거나 터미널에

git branch

라는 명령어를 작성하여 브랜치 이름을 확인하면 됩니다.

# 주의사항

안드로이드 스튜디오에서 깃허브 토큰 연결하는 건 알아서 하시길 바랍니다.

필요에 따라 협업을 하는 사람이 많을 경우

위에 있는 방법을 사용하고

협업을 하는 사람이 적을 경우

아래에 있는 방법을 사용하는 걸 추천드립니다.


