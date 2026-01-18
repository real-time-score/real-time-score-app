# 스포츠스코어픽 UI 개발 계획서

## 1. 개요

이 문서는 Figma 디자인 파일을 기반으로 모바일 앱의 전체 페이지 트리 구조와 UI 개발 작업 항목 및 순서를 정의합니다.

### 1.1 Figma 파일 정보
- **파일명**: 리얼 타임 스코어 - 개발자 (복사)
- **파일 URL**: https://www.figma.com/design/j4KEUodbnrUVCAOjFNxJkq
- **File Key**: `j4KEUodbnrUVCAOjFNxJkq`
- **Canvas Node ID**: `0:1`

### 1.2 작업 기준
- 정의된 타이포그래피, 폰트, 컴포넌트 우선 활용
- **디자인 일치 최우선**: 컴포넌트로 구현 불가 시 직접 구현

---

## 2. 전체 페이지 트리 구조

```
스포츠스코어픽 앱
│
├── 📱 온보딩
│   ├── 스플래쉬
│   └── 알람 예시 (푸시 권한)
│
├── 📱 홈 (라이브 스코어)
│   ├── 메인 화면
│   │   ├── 배너 있는 케이스
│   │   ├── 배너 없는 케이스
│   │   └── 카테고리 예시
│   ├── 알람 리스트
│   └── 경기 리스트 풀 모드
│       ├── 기본
│       ├── 승1패
│       ├── 핸디캡
│       └── 언더오버
│
├── 📱 라이브 (경기 상세)
│   ├── 경기 전
│   ├── 경기 중
│   ├── 경기 종료
│   ├── 사용자 인터랙션
│   ├── 응원메세지
│   ├── 멘션
│   └── gif 적용 케이스 (3종)
│
├── 📱 경기 상세 - 차트
│   ├── 차트_비교
│   ├── 차트_기록
│   ├── 차트_순위
│   └── 차트_순위_바텀시트
│
├── 📱 경기 상세 - 라인업
│   ├── 라인업_축구
│   ├── 라인업_농구
│   └── 라인업_야구
│
├── 📱 경기 상세 - 예측게임
│   └── 예측게임
│
├── 📱 팀/선수 정보
│   ├── 팀 정보 상세_일정/결과
│   ├── 팀 정보 상세_순위
│   ├── 팀 정보 상세_선수
│   └── 팀 정보 상세_선수 상세
│
├── 📱 프로토
│   └── 프로토 메인
│
├── 📱 픽전문가
│   ├── 픽전문가_무료픽
│   ├── 픽전문가_유료픽
│   ├── 무료픽 등록
│   ├── 무료픽 등록(상세)
│   ├── 유료픽 상세
│   ├── 상세보기
│   └── MY PICK
│
├── 📱 커뮤니티
│   ├── 커뮤니티 메인
│   ├── 커뮤니티_상세보기
│   ├── 커뮤니티_상세보기_이미지 여러개 케이스
│   └── 게시글 등록
│
├── 📱 랭킹
│   └── 랭킹 (3개 버전)
│
├── 📱 사용자 프로필
│   ├── 사용자 프로필_게시글
│   ├── 사용자 프로필_응원글
│   ├── 사용자 프로필_예측게임
│   ├── 사용자 프로필_알림
│   └── 사용자 프로필_알림2
│
├── 📱 MY 페이지
│   ├── my (메인)
│   ├── 프로필 변경
│   ├── 인증뱃지
│   ├── 인증뱃지_획득 못한 경우
│   └── 활동온도
│
├── 📱 포인트 관리
│   ├── 포인트 관리
│   ├── 상세내역
│   ├── 최초 충전 시 휴대폰 인증
│   └── 결제수단 예시
│
├── 📱 설정/기타
│   ├── 공지사항
│   ├── F&Q
│   ├── 1:1 문의
│   ├── 앱설정
│   ├── 알림 설정
│   ├── 마케팅 수신 동의
│   ├── 약관
│   ├── 개인정보처리방침
│   ├── 이용약관 더보기
│   └── 서비스 이용약관
│
└── 📱 기타 UI 요소
    ├── 핸디캡, 언더오버 용어 설명
    └── 순위 뱃지 케이스
```

---

## 3. Figma Node ID 매핑

### 3.1 섹션별 Node ID

| 섹션 | Section Node ID | 설명 |
|------|-----------------|------|
| 온보딩 | `1:10727` | 스플래쉬, 알림 안내 |
| 라이브 | `1:11325` | 라이브 경기 화면 |
| 경기상세 공통 | `1:10773` | 경기 상세 공통 요소 |
| 차트 | `1:10774` | 차트 관련 화면 |
| 팀정보 상세 | `1:12286` | 팀/선수 상세 |
| 라인업 | `1:12512` | 종목별 라인업 |
| 예측게임 | `1:13061` | 예측게임 |
| 픽전문가 | `1:13159` | 픽전문가 관련 |
| 랭킹 | `1:13411` | 랭킹 화면 |
| 사용자 프로필 | `1:13471` | 유저 프로필 |
| MY | `1:13793` | MY 메인 |
| 인증뱃지 | `1:13822` | 인증뱃지 |
| 활동온도 | `1:14114` | 활동온도 |
| 포인트관리 | `1:14155` | 포인트 관련 |
| 공지사항 | `1:14265` | 공지사항 |
| F&Q | `1:14300` | FAQ |
| 1:1문의 | `1:14329` | 문의하기 |
| 알림 설정 | `1:14347` | 알림 설정 |
| 약관 | `1:14385` | 약관 관련 |
| 프로토 | `1:14473` | 프로토 화면 |
| 라이브 스코어 | `1:14605` | 라이브 스코어 메인 |
| 커뮤니티 | `1:15114` | 커뮤니티 |
| gif 케이스 | `1:12051` | GIF 적용 케이스 |
| point | `188:14411` | 포인트 추가 화면 |
| 용어 설명 | `207:14448` | 핸디캡/언더오버 설명 |

### 3.2 주요 화면별 Node ID

| 화면명 | Node ID | 섹션 |
|--------|---------|------|
| 스플래쉬 | `1:10728` | 온보딩 |
| 알람 예시 | `1:10751` | 온보딩 |
| 라이브 - 경기 전 | `1:11326` | 라이브 |
| 라이브 - 경기 중 | `1:11400` | 라이브 |
| 라이브 - 경기 종료 | `1:11472` | 라이브 |
| 라이브 - 사용자 인터랙션 | `1:11620` | 라이브 |
| 라이브 - 응원메세지 | `1:11698` | 라이브 |
| 라이브 - 멘션 | `1:11762` | 라이브 |
| 차트_비교 | `1:10775` | 차트 |
| 차트_기록 | `1:10933` | 차트 |
| 차트_순위 | `1:11069` | 차트 |
| 차트_순위_바텀시트 | `1:11190` | 차트 |
| 팀 정보 상세_일정/결과 | `1:12287` | 팀정보 |
| 팀 정보 상세_순위 | `1:12302` | 팀정보 |
| 팀 정보 상세_선수 | `1:12403` | 팀정보 |
| 팀 정보 상세_선수 상세 | `1:12492` | 팀정보 |
| 라인업_축구 | `1:12513` | 라인업 |
| 라인업_농구 | `1:12742` | 라인업 |
| 라인업_야구 | `1:12857` | 라인업 |
| 예측게임 | `1:13062` | 예측게임 |
| 픽전문가_무료픽 | `1:13160` | 픽전문가 |
| 픽전문가_유료픽 | `1:13187` | 픽전문가 |
| 무료픽 등록 | `1:13214` | 픽전문가 |
| 무료픽 등록(상세) | `1:13224` | 픽전문가 |
| 유료픽 상세 | `1:13341` | 픽전문가 |
| 상세보기 | `1:13283` | 픽전문가 |
| MY PICK | `1:13395` | 픽전문가 |
| 랭킹 | `1:13412` | 랭킹 |
| 사용자 프로필_게시글 | `1:13472` | 사용자 프로필 |
| 사용자 프로필_응원글 | `1:13493` | 사용자 프로필 |
| 사용자 프로필_예측게임 | `1:13558` | 사용자 프로필 |
| 사용자 프로필_알림 | `1:13632` | 사용자 프로필 |
| my | `1:13794` | MY |
| 프로필 변경 | `1:13808` | MY |
| 인증뱃지 | `1:13823` | 인증뱃지 |
| 인증뱃지_획득 못한 경우 | `1:13971` | 인증뱃지 |
| 활동온도 | `1:14115` | 활동온도 |
| 포인트 관리 | `1:14156` | 포인트관리 |
| 상세내역 | `1:14167` | 포인트관리 |
| 최초 충전 시 휴대폰 인증 | `188:14474` | 포인트관리 |
| 결제수단 예시 | `1:14237` | 포인트관리 |
| 공지사항 | `1:14266` | 공지사항 |
| F&Q | `1:14301` | F&Q |
| 1:1 문의 | `1:14330` | 1:1문의 |
| 앱설정 | `1:14348` | 알림 설정 |
| 알림 설정 | `1:14355` | 알림 설정 |
| 마케팅 수신 동의 | `1:14372` | 알림 설정 |
| 약관 | `1:14386` | 약관 |
| 개인정보처리방침 | `1:14393` | 약관 |
| 서비스 이용약관 | `1:14433` | 약관 |
| 프로토 main | `1:14474` | 프로토 |
| 라이브스코어 main | `1:14607` | 라이브 스코어 |
| 배너 없는 케이스 | `1:14645` | 라이브 스코어 |
| 알람 리스트 | `1:14719` | 라이브 스코어 |
| 경기 리스트 풀 모드 | `1:14732` | 라이브 스코어 |
| 경기 리스트 풀 모드(승1패) | `1:14793` | 라이브 스코어 |
| 경기 리스트 풀 모드(핸디캡) | `1:14854` | 라이브 스코어 |
| 경기 리스트 풀 모드(언더오버) | `1:14915` | 라이브 스코어 |
| 커뮤니티 | `1:15115` | 커뮤니티 |
| 커뮤니티_상세보기 | `1:15148` | 커뮤니티 |
| 게시글 등록 | `1:15203` | 커뮤니티 |
| gif 적용 케이스 | `1:12052` | gif 케이스 |

---

## 4. UI 개발 작업 항목

### 4.1 개발 단계 정의

| 단계 | 설명 | 우선순위 |
|------|------|----------|
| **Phase 1** | 핵심 플로우 (온보딩 → 메인 → 경기상세) | 🔴 최우선 |
| **Phase 2** | 주요 탭 화면 (픽전문가, 커뮤니티, 랭킹, MY) | 🟠 높음 |
| **Phase 3** | 상세 기능 화면 (프로필, 설정, 포인트) | 🟡 중간 |
| **Phase 4** | 부가 기능 (약관, FAQ, 문의) | 🟢 낮음 |

### 4.2 Phase 1: 핵심 플로우 (최우선)

#### 4.2.1 온보딩
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-1 | 스플래쉬 | `1:10728` | ✅ | 로고, 앱명 |
| 1-2 | 알람 예시 (푸시 권한) | `1:10751` | ✅ | 푸시 권한 요청 |

#### 4.2.2 라이브 스코어 메인
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-3 | 메인 화면 (배너 O) | `1:14607` | ✅ | 메인 홈 |
| 1-4 | 메인 화면 (배너 X) | `1:14645` | ✅ | 배너 없는 케이스 |
| 1-5 | 알람 리스트 | `1:14719` | ✅ | 알림 목록 |
| 1-6 | 경기 리스트 풀 모드 | `1:14732` | ✅ | 기본 |
| 1-7 | 경기 리스트 (승1패) | `1:14793` | ✅ | 승1패 모드 |
| 1-8 | 경기 리스트 (핸디캡) | `1:14854` | ✅ | 핸디캡 모드 |
| 1-9 | 경기 리스트 (언더오버) | `1:14915` | ✅ | 언더오버 모드 |

#### 4.2.3 라이브 (경기 상세 채팅)
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-10 | 라이브 - 경기 전 | `1:11326` | ✅ | 경기 전 상태 |
| 1-11 | 라이브 - 경기 중 | `1:11400` | ✅ | 경기 진행 중 |
| 1-12 | 라이브 - 경기 종료 | `1:11472` | ✅ | 경기 종료 |
| 1-13 | 라이브 - 사용자 인터랙션 | `1:11620` | ✅ | 인터랙션 |
| 1-14 | 라이브 - 응원메세지 | `1:11698` | ✅ | 응원 메시지 |
| 1-15 | 라이브 - 멘션 | `1:11762` | ✅ | 멘션 기능 |

#### 4.2.4 경기 상세 - 차트
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-16 | 차트_비교 | `1:10775` | ✅ | 팀 비교 차트 |
| 1-17 | 차트_기록 | `1:10933` | ✅ | 기록 차트 |
| 1-18 | 차트_순위 | `1:11069` | ✅ | 순위 차트 |
| 1-19 | 차트_순위_바텀시트 | `1:11190` | ✅ | 순위 바텀시트 |

#### 4.2.5 경기 상세 - 라인업
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-20 | 라인업_축구 | `1:12513` | ✅ | 축구 라인업 |
| 1-21 | 라인업_농구 | `1:12742` | ✅ | 농구 라인업 |
| 1-22 | 라인업_야구 | `1:12857` | ✅ | 야구 라인업 |

#### 4.2.6 경기 상세 - 예측게임
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-23 | 예측게임 | `1:13062` | ✅ | 예측 게임 |

#### 4.2.7 팀/선수 정보
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 1-24 | 팀 정보 상세_일정/결과 | `1:12287` | ✅ | 팀 일정/결과 |
| 1-25 | 팀 정보 상세_순위 | `1:12302` | ✅ | 팀 순위 |
| 1-26 | 팀 정보 상세_선수 | `1:12403` | ✅ | 팀 선수 목록 |
| 1-27 | 팀 정보 상세_선수 상세 | `1:12492` | ✅ | 선수 상세 |

---

### 4.3 Phase 2: 주요 탭 화면 (높음)

#### 4.3.1 프로토
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 2-1 | 프로토 main | `1:14474` | ✅ | 프로토 메인 |

#### 4.3.2 픽전문가
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 2-2 | 픽전문가_무료픽 | `1:13160` | ✅ | 무료픽 목록 |
| 2-3 | 픽전문가_유료픽 | `1:13187` | ✅ | 유료픽 목록 |
| 2-4 | 무료픽 등록 | `1:13214` | ✅ | 무료픽 등록 |
| 2-5 | 무료픽 등록(상세) | `1:13224` | ✅ | 등록 상세 |
| 2-6 | 상세보기 | `1:13283` | ✅ | 픽 상세 |
| 2-7 | 유료픽 상세 | `1:13341` | ✅ | 유료픽 상세 |
| 2-8 | MY PICK | `1:13395` | ✅ | MY 픽 |

#### 4.3.3 커뮤니티
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 2-9 | 커뮤니티 | `1:15115` | ✅ | 커뮤니티 메인 |
| 2-10 | 커뮤니티_상세보기 | `1:15148` | ✅ | 게시글 상세 |
| 2-11 | 커뮤니티_이미지 여러개 | `1:15174` | ✅ | 다중 이미지 |
| 2-12 | 게시글 등록 | `1:15203` | ✅ | 글 작성 |

#### 4.3.4 랭킹
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 2-13 | 랭킹 | `1:13412` | ✅ | 랭킹 화면 |

#### 4.3.5 MY 페이지
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 2-14 | my (메인) | `1:13794` | ✅ | MY 메인 |
| 2-15 | 프로필 변경 | `1:13808` | ✅ | 프로필 수정 |

---

### 4.4 Phase 3: 상세 기능 화면 (중간)

#### 4.4.1 사용자 프로필
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 3-1 | 사용자 프로필_게시글 | `1:13472` | ✅ | 작성 게시글 |
| 3-2 | 사용자 프로필_응원글 | `1:13493` | ✅ | 응원글 |
| 3-3 | 사용자 프로필_예측게임 | `1:13558` | ✅ | 예측 기록 |
| 3-4 | 사용자 프로필_알림 | `1:13632` | ✅ | 알림 목록 |

#### 4.4.2 인증뱃지/활동온도
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 3-5 | 인증뱃지 | `1:13823` | ✅ | 뱃지 목록 |
| 3-6 | 인증뱃지_획득 못한 경우 | `1:13971` | ✅ | 미획득 뱃지 |
| 3-7 | 활동온도 | `1:14115` | ✅ | 활동온도 |

#### 4.4.3 포인트 관리
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 3-8 | 포인트 관리 | `1:14156` | ✅ | 포인트 메인 |
| 3-9 | 상세내역 | `1:14167` | ✅ | 내역 조회 |
| 3-10 | 최초 충전 시 휴대폰 인증 | `188:14474` | ✅ | 본인 인증 |
| 3-11 | 결제수단 예시 | `1:14237` | ✅ | 결제 UI |

#### 4.4.4 설정
| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 3-12 | 앱설정 | `1:14348` | ✅ | 설정 메인 |
| 3-13 | 알림 설정 | `1:14355` | ✅ | 알림 설정 |
| 3-14 | 마케팅 수신 동의 | `1:14372` | ✅ | 마케팅 동의 |

---

### 4.5 Phase 4: 부가 기능 (낮음)

| # | 화면 | Node ID | 상태 | 비고 |
|---|------|---------|:----:|------|
| 4-1 | 공지사항 | `1:14266` | ✅ | 공지 목록 |
| 4-2 | F&Q | `1:14301` | ✅ | FAQ |
| 4-3 | 1:1 문의 | `1:14330` | ✅ | 문의하기 |
| 4-4 | 약관 | `1:14386` | ✅ | 약관 메인 |
| 4-5 | 개인정보처리방침 | `1:14393` | ✅ | 개인정보 |
| 4-6 | 서비스 이용약관 | `1:14433` | ✅ | 이용약관 |
| 4-7 | gif 적용 케이스 | `1:12052` | ✅ | GIF 케이스 |
| 4-8 | 용어 설명 | `207:14448` | ✅ | 핸디캡/언더오버 |

---

## 5. 진행률 요약

| Phase | 총 화면 | 완료 | 진행률 |
|-------|---------|------|--------|
| Phase 1 (핵심 플로우) | 27 | 27 | 100% |
| Phase 2 (주요 탭) | 15 | 15 | 100% |
| Phase 3 (상세 기능) | 14 | 14 | 100% |
| Phase 4 (부가 기능) | 8 | 8 | 100% |
| **전체** | **64** | **64** | **100%** |

---

## 6. 작업 규칙

### 6.1 상태 표기
- ⬜ 대기 (미시작)
- 🔄 진행 중
- ✅ 완료
- ⏸️ 보류

### 6.2 Figma 디자인 조회 방법
특정 화면의 디자인 컨텍스트가 필요한 경우:
```
File Key: j4KEUodbnrUVCAOjFNxJkq
Node ID: [위 테이블의 Node ID 참조]
```

### 6.3 작업 완료 기준
1. Figma 디자인과 픽셀 단위 일치
2. 정의된 컴포넌트/타이포그래피 활용 (가능한 경우)
3. 반응형 대응 (다양한 기기 사이즈)
4. 다크모드 지원 (해당 시)

---

## 7. 버전 관리

| 버전 | 날짜 | 변경 내용 |
|------|------|----------|
| v1.0 | 2025-01-18 | 초기 문서 작성 (Figma 기반) |

---

## 8. 참고 링크

- **Figma 파일**: https://www.figma.com/design/j4KEUodbnrUVCAOjFNxJkq
- **스펙 문서**: `docs/SPEC_ARCHITECTURE.md`
- **작업 진행**: `docs/WORK_PROGRESS.md`

---

## 9. 작업 로그

### 문서 업데이트 가이드
**각 UI 작업 완료 시 반드시 아래 항목을 업데이트해야 합니다:**

1. **섹션 4 작업 항목 테이블**: 해당 화면 상태 `⬜` → `✅` 변경
2. **섹션 5 진행률 요약**: 완료 수 및 진행률 갱신
3. **섹션 9 작업 로그**: 아래 테이블에 기록 추가

### 작업 기록

| 날짜 | Phase | 화면명 | Node ID | 작업 내용 | 담당 | 비고 |
|------|-------|--------|---------|----------|------|------|
| 2025-01-18 | - | - | - | 문서 초기 작성 | Claude | Figma 기반 페이지 트리 구성 |
| 2025-01-18 | Phase 1 | 스플래쉬 | `1:10728` | UI 구현 완료 | Claude | lib/features/splash/presentation/pages/splash_page.dart |
| 2025-01-18 | Phase 1 | 알람 예시 (푸시 권한) | `1:10751` | UI 구현 완료 | Claude | lib/features/splash/presentation/pages/notification_permission_page.dart |
| 2025-01-18 | Phase 1 | 메인 화면 (배너 O) | `1:14607` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/live_score_main_page.dart |
| 2025-01-18 | Phase 1 | 메인 화면 (배너 X) | `1:14645` | showBanner 파라미터 추가 | Claude | LiveScoreMainPage(showBanner: false) |
| 2025-01-18 | Phase 1 | 알람 리스트 | `1:14719` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/alarm_list_page.dart |
| 2025-01-18 | Phase 1 | 경기 리스트 풀 모드 | `1:14732` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/match_full_mode_page.dart |
| 2025-01-18 | Phase 1 | 경기 리스트 (승1패) | `1:14793` | 기존 페이지 활용 (initialMode 파라미터) | Claude | MatchFullModePage(initialMode: OddsMode.win1Lose) |
| 2025-01-18 | Phase 1 | 경기 리스트 (핸디캡) | `1:14854` | 기존 페이지 활용 (initialMode 파라미터) | Claude | MatchFullModePage(initialMode: OddsMode.handicap) |
| 2025-01-18 | Phase 1 | 경기 리스트 (언더오버) | `1:14915` | 기존 페이지 활용 (initialMode 파라미터) | Claude | MatchFullModePage(initialMode: OddsMode.underOver) |
| 2025-01-18 | Phase 1 | 라이브 - 경기 전 | `1:11326` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/live_match_detail_page.dart |
| 2025-01-18 | Phase 1 | 라이브 - 경기 중 | `1:11400` | 기존 페이지 확장 (matchStatus 파라미터) | Claude | LiveMatchDetailPage(matchStatus: MatchStatus.live) |
| 2025-01-18 | Phase 1 | 라이브 - 경기 종료 | `1:11472` | 기존 페이지 활용 (matchStatus 파라미터) | Claude | LiveMatchDetailPage(matchStatus: MatchStatus.finished) |
| 2025-01-18 | Phase 1 | 라이브 - 사용자 인터랙션 | `1:11620` | 사용자 컨텍스트 메뉴 추가 | Claude | 진중/구중/신고/차단 메뉴, 차단 사용자 하이라이트 |
| 2025-01-18 | Phase 1 | 라이브 - 응원메세지 | `1:11698` | 응원 메시지 입력 바 추가 | Claude | 헤더 바, 텍스트 입력, 전송 버튼, 팀별 색상 |
| 2025-01-18 | Phase 1 | 라이브 - 멘션 | `1:11762` | 멘션 입력 바 추가 | Claude | @멘션 버튼 탭 → 멘션 입력 모드, 파란색 테마 |
| 2025-01-18 | Phase 1 | 차트_비교 | `1:10775` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/chart_comparison_page.dart |
| 2025-01-18 | Phase 1 | 차트_기록 | `1:10933` | 기록 탭 콘텐츠 추가 | Claude | ChartComparisonPage(initialSubTab: ChartSubTab.record) |
| 2025-01-18 | Phase 1 | 차트_순위 | `1:11069` | 순위 탭 콘텐츠 추가 | Claude | ChartComparisonPage(initialSubTab: ChartSubTab.ranking) |
| 2025-01-18 | Phase 1 | 차트_순위_바텀시트 | `1:11190` | 년도 선택 바텀시트 추가 | Claude | _showYearSelectionBottomSheet(), _selectedYear 상태 |
| 2025-01-18 | Phase 1 | 라인업_축구 | `1:12513` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/lineup_page.dart |
| 2025-01-18 | Phase 1 | 라인업_농구 | `1:12742` | 농구 코트/선수 배치 추가 | Claude | BasketballCourtPainter, _buildBasketballContent() |
| 2025-01-18 | Phase 1 | 라인업_야구 | `1:12857` | 야구 다이아몬드/선수 배치 추가 | Claude | BaseballDiamondPainter, _buildBaseballContent() |
| 2025-01-18 | Phase 1 | 예측게임 | `1:13062` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/prediction_game_page.dart |
| 2025-01-18 | Phase 1 | 팀 정보 상세_일정/결과 | `1:12287` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/team_info_page.dart |
| 2025-01-18 | Phase 1 | 팀 정보 상세_순위 | `1:12302` | 순위 탭 콘텐츠 추가 | Claude | 리그 필터, 순위 테이블 (6컬럼) |
| 2025-01-18 | Phase 1 | 팀 정보 상세_선수 | `1:12403` | 선수 탭 콘텐츠 추가 | Claude | 리그 필터, 선수 테이블 (5컬럼) |
| 2025-01-18 | Phase 1 | 팀 정보 상세_선수 상세 | `1:12492` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/player_detail_page.dart |
| 2025-01-18 | Phase 2 | 프로토 main | `1:14474` | UI 구현 완료 | Claude | lib/features/proto/presentation/pages/proto_main_page.dart |
| 2025-01-18 | Phase 2 | 픽전문가_무료픽 | `1:13160` | UI 구현 완료 | Claude | lib/features/pick_expert/presentation/pages/pick_expert_page.dart |
| 2025-01-18 | Phase 2 | 픽전문가_유료픽 | `1:13187` | 기존 페이지 확장 (isPaidPick 분기) | Claude | 주종목 정보, 구매/가격 버튼 추가 |
| 2025-01-18 | Phase 2 | 무료픽 등록 | `1:13214` | UI 구현 완료 | Claude | lib/features/pick_expert/presentation/pages/pick_register_page.dart |
| 2025-01-19 | Phase 2 | 무료픽 등록(상세) | `1:13224` | UI 구현 완료 | Claude | lib/features/pick_expert/presentation/pages/pick_register_detail_page.dart |
| 2025-01-19 | Phase 2 | 상세보기 | `1:13283` | UI 구현 완료 | Claude | lib/features/pick_expert/presentation/pages/pick_detail_page.dart |
| 2025-01-19 | Phase 2 | 유료픽 상세 | `1:13341` | 기존 페이지 확장 (isPaidPick 분기) | Claude | 주종목 정보, 구매/가격 버튼, 상세정보 배너 추가 |
| 2025-01-19 | Phase 2 | MY PICK | `1:13395` | UI 구현 완료 | Claude | lib/features/pick_expert/presentation/pages/my_pick_page.dart |
| 2025-01-19 | Phase 2 | 커뮤니티 | `1:15115` | UI 구현 완료 | Claude | lib/features/community/presentation/pages/community_page.dart |
| 2025-01-19 | Phase 2 | 커뮤니티_상세보기 | `1:15148` | UI 구현 완료 | Claude | lib/features/community/presentation/pages/community_detail_page.dart |
| 2025-01-19 | Phase 2 | 커뮤니티_이미지 여러개 | `1:15174` | 기존 페이지 확장 (imageCount 파라미터) | Claude | CommunityDetailPage(imageCount: 3) |
| 2025-01-19 | Phase 2 | 게시글 등록 | `1:15203` | UI 구현 완료 | Claude | lib/features/community/presentation/pages/community_write_page.dart |
| 2025-01-19 | Phase 2 | 랭킹 | `1:13412` | UI 구현 완료 | Claude | lib/features/ranking/presentation/pages/ranking_page.dart |
| 2025-01-19 | Phase 2 | my (메인) | `1:13794` | UI 구현 완료 | Claude | lib/features/my/presentation/pages/my_page.dart |
| 2025-01-19 | Phase 2 | 프로필 변경 | `1:13808` | UI 구현 완료 | Claude | lib/features/my/presentation/pages/profile_edit_page.dart |
| 2025-01-19 | Phase 3 | 사용자 프로필_게시글 | `1:13472` | UI 구현 완료 | Claude | lib/features/user_profile/presentation/pages/user_profile_page.dart |
| 2025-01-19 | Phase 3 | 사용자 프로필_응원글 | `1:13493` | 탭으로 구현 완료 | Claude | UserProfilePage(initialTab: UserProfileTab.cheers) |
| 2025-01-19 | Phase 3 | 사용자 프로필_예측게임 | `1:13558` | 탭으로 구현 완료 | Claude | UserProfilePage(initialTab: UserProfileTab.prediction) |
| 2025-01-19 | Phase 3 | 사용자 프로필_알림 | `1:13632` | 탭으로 구현 완료 | Claude | UserProfilePage(initialTab: UserProfileTab.notification) |
| 2025-01-19 | Phase 3 | 인증뱃지 | `1:13823` | UI 구현 완료 | Claude | lib/features/badge/presentation/pages/certification_badge_page.dart |
| 2025-01-19 | Phase 3 | 인증뱃지_획득 못한 경우 | `1:13971` | 파라미터로 구현 완료 | Claude | CertificationBadgePage(showUnearned: true) |
| 2025-01-19 | Phase 3 | 활동온도 | `1:14115` | UI 구현 완료 | Claude | lib/features/badge/presentation/pages/activity_temperature_page.dart |
| 2025-01-19 | Phase 3 | 포인트 관리 | `1:14156` | UI 구현 완료 | Claude | lib/features/point/presentation/pages/point_management_page.dart |
| 2025-01-19 | Phase 3 | 상세내역 | `1:14167` | 3-8에서 구현 완료 | Claude | PointManagementPage 상세 내역 섹션 |
| 2025-01-19 | Phase 3 | 최초 충전 시 휴대폰 인증 | `188:14474` | UI 구현 완료 | Claude | lib/features/point/presentation/pages/phone_verification_page.dart |
| 2025-01-19 | Phase 3 | 결제수단 예시 | `1:14237` | UI 구현 완료 | Claude | lib/features/point/presentation/pages/point_charge_page.dart |
| 2025-01-19 | Phase 3 | 앱설정 | `1:14348` | UI 구현 완료 | Claude | lib/features/settings/presentation/pages/app_settings_page.dart |
| 2025-01-19 | Phase 3 | 알림 설정 | `1:14355` | UI 구현 완료 | Claude | lib/features/settings/presentation/pages/notification_settings_page.dart |
| 2025-01-19 | Phase 3 | 마케팅 수신 동의 | `1:14372` | UI 구현 완료 | Claude | lib/features/settings/presentation/pages/marketing_consent_page.dart |
| 2025-01-19 | Phase 4 | 공지사항 | `1:14266` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/notice_page.dart |
| 2025-01-19 | Phase 4 | F&Q | `1:14301` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/faq_page.dart |
| 2025-01-19 | Phase 4 | 1:1 문의 | `1:14330` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/inquiry_page.dart |
| 2025-01-19 | Phase 4 | 약관 | `1:14386` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/terms_page.dart |
| 2025-01-19 | Phase 4 | 개인정보처리방침 | `1:14393` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/privacy_policy_page.dart |
| 2025-01-19 | Phase 4 | 서비스 이용약관 | `1:14433` | UI 구현 완료 | Claude | lib/features/support/presentation/pages/service_terms_page.dart |
| 2025-01-19 | Phase 4 | gif 적용 케이스 | `1:12052` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/gif_case_page.dart |
| 2025-01-19 | Phase 4 | 용어 설명 | `207:14448` | UI 구현 완료 | Claude | lib/features/live_score/presentation/pages/glossary_page.dart |
| | | | | | | |

### 이슈 및 메모

#### 진행 중 이슈
- (이슈 발생 시 여기에 기록)

#### 해결된 이슈
- (해결된 이슈 여기에 기록)

---

## 10. Quick Reference

### Figma 디자인 조회 명령
```
mcp__figma__get_design_context(
  fileKey: "j4KEUodbnrUVCAOjFNxJkq",
  nodeId: "[Node ID]",
  clientLanguages: "dart",
  clientFrameworks: "flutter"
)
```

### 스크린샷 조회 명령
```
mcp__figma__get_screenshot(     
  fileKey: "j4KEUodbnrUVCAOjFNxJkq",
  nodeId: "[Node ID]",
  clientLanguages: "dart",
  clientFrameworks: "flutter"
)
```

### 자주 사용하는 Node ID (Phase 1)
| 화면 | Node ID | 용도 |
|------|---------|------|
| 스플래쉬 | `1:10728` | 앱 시작 화면 |
| 라이브스코어 메인 | `1:14607` | 홈 탭 메인 |
| 라이브 - 경기 전 | `1:11326` | 경기 상세 채팅 |
| 차트_비교 | `1:10775` | 경기 상세 차트 |
| 라인업_축구 | `1:12513` | 경기 상세 라인업 |
