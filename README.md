윤형찬 iOS 과제 ReadMe
=====

카카오뱅크 iOS 개발자 채용 과제 전형을 진행하면서 개발한 내용과 느낀점을 간략하게 정리하였습니다.


## 목차

1. 구현 내용
2. 미구현 내용
3. 마무리 및 회고
<br/>

### 개발 환경
| 구분 | 값 |
| **Xcode** | 15.3 이상 |
| **개발언어** | Swift |
| **최소 지원 버전** | iOS 13.0 이상|
| **Dependency Manager** | SPM |

## 구현 내용

- 하단 TabBar 구현 및 UI 적용
- 검색 기능 구현 (UserDefaults)
	- 텍스트 입력 > Store 검색
    - 최근 검색어 선택 > Store 검색
    - 검색어 매칭 및 매칭 검색어 선택 > Store 검색
- 상세화면 "더 보기" 버튼 및 UI 구현
- ScreenShot 페이징 구현
- 인터넷 미연결 시 검색 방어 로직 구현

등
<br/>
 

## 미구현 내용
- "이미 모두의 은행" 과 같은 SubTitle 미구현
	- API Response에서 해당 내용을 찾지 못함
<br/>

## 마무리 및 회고

- UI 관련하여 Layout가이드와 Resource가 부족하여 개발을 진행하면서 깔끔하게 넘어가지 못하는 느낌을 받았습니다.

- 내부 저장소 라이브러리의 사용을 고민하였으나, 단순 String 배열만 필요했기에 UserDefaults로 작업하였습니다.

- 평소 테스트 코드를 작성하지 않아서 테스트 코드 작성 후 개발하는데 어려움을 겪었습니다. 이 점은 추가로 스터디 및 프로젝트에 적용해보고 싶습니다.

- 카카오뱅크에서 사용 중인 FlexLayout을 공부하여 적용해보려고 했으나, 시간이 충분치 못해 사용 중 기존 개발하던 방식으로 전환한 것이 아쉽습니다.
이 라이브러리를 잠시 써보면서 선언형 UI 개발하는 것과 유사하다는 느낌을 받았고, 학습 후 프로젝트에 적용해보고자 합니다.


#### 앱 빌드 시 오류가 발생하면?
- `AppStoreSearch/AppStoreSearch.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved` 를 삭제하면 됩니다.
