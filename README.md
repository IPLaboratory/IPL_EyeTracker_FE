# real_test

만들고 있는 플러터 프로젝트입니다.

무엇을 해야 하는지 모르겠다면 Issue 탭의 EPIC, FEAT, TASK를 봐주시길 바랍니다.

# Git에서 Commit 하는 법

## 주의사항

1. EPIC은 이슈로만 올립니다.
2. branch는 FEAT 단위로 합니다.
3. Commit은 TASK 단위로 합니다.

이제 git bash를 사용하는 방법을 알려드리겠습니다.

## 1. Feature 브랜치
1-1. 새로운 기능을 개발하기 위한 브랜치입니다.

1-2. 아래에 서술할 브랜치 규칙을 꼭 지켜주시길 바랍니다.

터미널에서

git checkout -b FEAT/FEAT 번호

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
* 지금 서술한 TASK #3는 Epic: UI에 있는 #2 FEAT : User Choice Page Layout 안에 있는 TASK : User Choice Page Design을 말하는 것입니다.
* 요약하면 "TASK #번호 : 내용" 으로 커밋메시지를 적어주시면 됩니다.

## 3. 브랜치 병합

1. 먼저 메인 브랜치로 돌아가야 합니다.
1-1. git checkout main

2. 그리고 브랜치를 병합합니다.
3. 
2-1. git merge 아까 만든 브랜치 이름
   
2-2. 예시: git merge FEAT/#2

물론 fork를 해서 자신의 레포지토리에서 수정을 하는 경우 PR (Pull Request)를 올리면 됩니다.

## 4. 브랜치 삭제 (필요한 경우에만)

작업이 끝나고 병합된 브랜치를 삭제할 수도 있습니다.

git branch -d 아까 만든 브랜치 이름

예시: git branch -d FEAT/#2

# 주의사항

1. 만약 TASK, 즉 할 일이 끝났다면 TASK만 Close 해주시길 바랍니다.
2. FEAT, EPIC은 모든 작업이 끝난 후 교차 검증을 한 뒤 Close 할 겁니다.
3. EPIC, FEAT, TASK를 헷갈리지 않게 꼭 꼼꼼히 확인하고 브랜치를 만들어주시길 바랍니다.
4. 필요하다면 언제든 EPIC, FEAT, TASK를 만들어도 되지만 꼭 팀원에게 말해주시길 바랍니다.
5. 후일 SERVER와 연동을 해야 할 때 EPIC : SERVER 이슈를 만들 것이니 아직은 만들지 말아주시길 바랍니다.
