//
//  SearchViewModelTest.swift
//  AppStoreSearchTests
//
//  Created by 윤형찬 on 3/31/24.
//

import XCTest
import Alamofire
import RxSwift
@testable import AppStoreSearch

/*
 테스트 코드를 개발하면서 업무를 진행해본 적이 없어서 많이 미흡합니다.
 감사합니다.
 */

class SearchViewModelTests: XCTestCase {
    private var bag = DisposeBag()
    
    var mockUDManager: MockUDManager!
    var mockSearchUseCase: MockSearchUseCase!
    
    override func setUpWithError() throws {
        mockUDManager = MockUDManager()
        mockSearchUseCase = MockSearchUseCase()
    }
    
    override func tearDownWithError() throws {
        mockUDManager = nil
        mockSearchUseCase = nil
    }
    
    func testLoadInitialRecentSearches() {
        XCTAssertFalse(mockUDManager.recentSearches.isEmpty)
    }
    
    func testLoadUD() {
        XCTAssertEqual(mockUDManager.recentSearches, mockUDManager.getStringArrayFromUserDefaults())
    }
    
    func testInsertUD() {
        mockUDManager.addStringToArrayInUserDefaults(newString: "테스트")
        XCTAssertEqual(4, mockUDManager.recentSearches.count, "테스트 실패")
    }
    
    func testGetContainsUD() {
        let result = mockUDManager.searchStringsContaining(searchString: "12")
        XCTAssertEqual(result, ["1258016944"], "테스트 실패")
    }
    
    func testUsecase() {
        let expectation = XCTestExpectation(description: "SearchUseCase fetches data successfully")
        let param: Parameters = ["term" : "1258016944"]
        let expectResult = getAppResultExpected()

        mockSearchUseCase.getSearchInfo(param)
            .map { $0.value.results}
            .subscribe(onNext: { result in
                guard let firstResult = result.first else {
                    XCTFail("Results should not be empty")
                    return
                }
                
                XCTAssertEqual(firstResult, expectResult, "First result should match the expected result")

                expectation.fulfill()
            }, onError: { error in
                XCTFail("Error occurred: \(error)")
            })
            .disposed(by: bag)

        wait(for: [expectation], timeout: 5.0)
    }

    
    private func getAppResultExpected() -> AppResult {
        return AppResult(
            screenshotUrls: [
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/54/73/78/5473783e-b540-3913-1f65-6e91980c1135/56182689-f686-4914-ab81-998711d9d349_ios_5.5_01.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/c3/89/0d/c3890d8e-c0f5-8105-1c4b-23bcc15aebf7/63780dcc-caf0-482f-a618-87fd0cee3b2b_ios_5.5_02.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/61/b8/73/61b87333-dae5-c8a6-b3ba-702a88b31cc9/c15a340c-d38b-4dc4-9efe-8acf0eebc961_ios_5.5_03.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/4a/34/e5/4a34e5bf-58c1-452e-5ad6-abd0625fce86/438990b6-5b48-46f9-bafc-ac8b68620b56_ios_5.5_04.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/18/60/19/1860195c-d1f3-c4ea-08a5-ff2411769a6a/9ed968f7-6592-470c-b453-0388a5ebf9f5_ios_5.5_05.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/95/77/85/95778585-ce63-47c8-5c8d-7890927b18e6/7a06d877-106f-441c-a5cf-f9b4d2da719d_ios_5.5_06.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/13/20/c9/1320c903-285c-2a7e-237e-32e3410e9745/007d9ab1-956f-43ed-81ee-171b089a7e44_ios_5.5_07.jpg/392x696bb.jpg",
                "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/1d/85/d5/1d85d5e2-8d8b-8b7b-3aa2-a1d2073edb35/47e55e13-ede0-4c34-984b-7daa98ef1321_ios_5.5_08.jpg/392x696bb.jpg"
            ],
            ipadScreenshotUrls: [],
            appletvScreenshotUrls: [],
            artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/b1/8b/1e/b18b1e57-a2db-2c8a-c3a1-cce231a406e1/AppIcon_real-0-0-1x_U007emarketing-0-7-0-85-220.png/60x60bb.jpg",
            artworkUrl512: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/b1/8b/1e/b18b1e57-a2db-2c8a-c3a1-cce231a406e1/AppIcon_real-0-0-1x_U007emarketing-0-7-0-85-220.png/512x512bb.jpg",
            artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/b1/8b/1e/b18b1e57-a2db-2c8a-c3a1-cce231a406e1/AppIcon_real-0-0-1x_U007emarketing-0-7-0-85-220.png/100x100bb.jpg",
            artistViewUrl: "https://apps.apple.com/kr/developer/kakaobank-corp/id1258016943?uo=4",
            supportedDevices: [
                "iPhone5s-iPhone5s", "iPadAir-iPadAir",
                // 기타 지원 디바이스들
            ],
            averageUserRatingForCurrentVersion: 3.34014,
            averageUserRating: 3.34014,
            trackCensoredName: "카카오뱅크",
            languageCodesISO2A: ["KO"],
            fileSizeBytes: "397811712",
            sellerUrl: "https://www.kakaobank.com/",
            formattedPrice: "무료",
            contentAdvisoryRating: "4+",
            userRatingCountForCurrentVersion: 12336,
            trackViewUrl: "https://apps.apple.com/kr/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%B1%85%ED%81%AC/id1258016944?uo=4",
            trackContentRating: "4+",
            currentVersionReleaseDate: "2024-03-18T02:00:53Z",
            releaseDate: "2017-07-26T15:24:27Z",
            releaseNotes: "2.34.0\n\n● 기기변경 시 ‘셀카인증’ 추가\n- 신분증 제출 없이 셀카 촬영으로 간편하게 기기변경 해보세요.\n\n● '최애적금' 입금 기능 개선 \n- 같은 규칙으로 최대 20회까지 한번에 입금할 수 있어요. \n- 이제 메모를 수정할 수 있어요. 더 자유롭게 기록해 보세요.\n\n● '개인사업자 보증서대출' 정책자금 상품 추가 (3월말 예정)\n- 지역별 다양한 사업자 이자지원 정책을 빠르게 확인할 수 있어요.\n- 보증기관을 방문하지 않아도 상품 비교부터 실행까지 앱으로 진행할 수 있어요. \n\n● 사용성 개선\n- 더욱 편리한 서비스 제공을 위해 기능 개선 및 불편점 해소 작업도 함께 진행했어요.",
            artistId: 1258016943,
            artistName: "KakaoBank Corp.",
            genres: ["금융"],
            price: 0.00,
            primaryGenreName: "Finance",
            primaryGenreId: 6015,
            description: "일상에서 더 쉽게, 더 자주 만나는 제1금융권 은행, 카카오뱅크\n\n■ 새롭게 디자인된 은행\n• 365일 언제나 지점 방문 없이 모든 은행 업무를 모바일에서\n• 7분만에 끝나는 쉬운 계좌개설\n\n■ 쉬운 사용성\n• 공동인증서, 보안카드 없는 계좌이체\n• 계좌번호를 몰라도 카톡 친구에게 간편 송금 (상대방이 카카오뱅크 고객이 아니어도 송금 가능)\n\n■ 내 취향대로 선택\n• 카카오프렌즈 캐릭터 디자인부터 고급스러운 블랙 컬러까지, 세련된 디자인의 체크카드\n• 내 마음대로 설정하는 계좌 이름과 색상\n\n■ 눈에 보이는 혜택\n• 복잡한 가입 조건이나 우대 조건 없이, 누구에게나 경쟁력있는 금리와 혜택 제공\n• 늘어나는 이자를 실시간으로 확인할 수 있는 정기예금\n• 만 19세 이상 대한민국 국민의 90%가 신청 가능한 비상금대출(소액 마이너스대출)\n\n■ 카카오프렌즈와 함께하는 26주적금\n• 천원부터 차곡차곡 26주동안 매주 쌓는 적금\n• 카카오프렌즈 응원과 함께하면 어느덧 만기 달성이 눈앞에!\n\n■ 알아서 차곡차곡 모아주는 저금통\n• 원하는 모으기 규칙 선택으로 부담없이 저축하기\n• 평소에는 귀여운 아이템으로, 엿보기 기능으로 잔액 확인\n\n■ 함께쓰고 같이보는 모임통장\n• 손쉽게 카카오톡 친구들을 멤버로 초대 \n• 잔액과 입출금 현황을 멤버들과 함께 보기 \n• 위트있는 메시지카드로 회비 요청\n\n■ 소중한 ‘내 신용정보’ 관리\n• 제1금융권에서 안전하게 무료로 내 신용정보 확인\n• 신용 변동내역 발생 시 알림 서비스 및 신용정보 관리 꿀팁 제공\n\n■ 파격적인 수수료로 해외송금\n• 365일 언제 어디서든 이용가능한 해외송금 (보내기 및 받기)\n• 해외계좌 및 웨스턴유니온(WU)을 통해 전세계 200여 개국으로 해외송금 가능\n• 거래외국환은행 지정, 연장 업무도 지점방문없이 모바일에서 신청 가능 \n\n■ 카카오뱅크에서 만나는 제휴서비스\n• 증권사 주식계좌도 간편하게 개설 가능\n• 프렌즈 캐릭터가 함께하는 제휴 신용카드 신청 가능\n\n■ 이체수수료 및 입출금 수수료 면제\n• 타행 이체 및 자동이체 수수료 면제\n• 국내 모든 ATM(은행, 제휴 VAN사 기기) 입금/출금/이체 수수료 면제\n\n* ATM/CD기 입금/출금/이체 수수료는 향후 정책에 따라 변경될 수 있습니다. 정책이 변경되는 경우 시행 1개월 전에 카카오뱅크 앱 및 홈페이지를 통해 미리 알려드립니다.\n\n■ 고객센터 운영 시간 안내\n• 예/적금, 대출, 카드 문의 : 1599-3333 (09:00 ~ 22:00 365일)\n• 전월세 보증금 대출, 외환 문의 : 1599-3333 (09:00 ~ 18:00 평일)\n• 사고 신고 : 1599-8888 (24시간 365일)\n\n■ 챗봇 운영 시간 안내\n• 카카오톡 플러스친구 \"카카오뱅크 고객센터\" (24시간 365일)\n\n■ 카카오뱅크 앱 이용을 위한 권한 및 목적 안내\n• 카메라(선택) : 신분증 촬영 및 서류 제출, 영상통화, 프로필 사진 등록\n• 사진(선택) : 이체⁄송금⁄출금 확인증, 카드매출전표 저장\n• 위치(선택) : 부정가입방지 및 부정거래탐지\n\n * 선택 접근권한은 동의하지 않아도 서비스를 이용하실 수 있습니다.",
            sellerName: "KakaoBank Corp.",
            genreIds: ["6015"],
            bundleId: "com.kakaobank.channel",
            trackId: 1258016944,
            trackName: "카카오뱅크",
            isVppDeviceBasedLicensingEnabled: true,
            minimumOsVersion: "13.0",
            currency: "KRW",
            version: "2.34.0",
            wrapperType: "software",
            userRatingCount: 12336
        )

    }
}
