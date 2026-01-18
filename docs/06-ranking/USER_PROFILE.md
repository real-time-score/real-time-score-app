# 유저 프로필

## 1. 개요

유저 프로필 화면은 다른 사용자의 정보와 활동 내역을 확인할 수 있는 화면입니다. 프로필 정보, 활동 통계, 게시글, 응원글, 예측게임 기록, 알림 관계 등을 제공합니다.

- **원본 PDF 참조**: 61-66 페이지

---

## 2. 화면 구성

### 2.1 전체 레이아웃 (페이지 62)

```
┌─────────────────────────────────────┐
│ [←]                         [신고🚨] │  ← 헤더
├─────────────────────────────────────┤
│                                     │
│            👤 프로필 이미지           │
│           닉네임 [인증배지]           │
│                                     │
│        [알림 OFF 🔔] 버튼            │
├─────────────────────────────────────┤
│  받은 알림        예측 성공           │
│    523개         45/50 (90%)        │
├─────────────────────────────────────┤
│  인증배지           활동온도          │
│    3개             36.5°            │
├─────────────────────────────────────┤
│ [게시글] [응원글] [예측게임] [알림]    │  ← 탭 바
├─────────────────────────────────────┤
│                                     │
│        탭 콘텐츠 영역                 │
│                                     │
└─────────────────────────────────────┘
```

### 2.2 주요 컴포넌트

| 컴포넌트 | 설명 |
|---------|------|
| 헤더 | 뒤로가기, 신고 버튼 |
| 프로필 영역 | 프로필 이미지, 닉네임, 인증배지 |
| 알림 버튼 | 해당 사용자 알림 설정 토글 |
| 통계 영역 | 받은 알림 수, 예측 성공 정보 |
| 배지/온도 영역 | 인증배지 개수, 활동온도 |
| 탭 바 | 게시글, 응원글, 예측게임, 알림 |
| 탭 콘텐츠 | 각 탭별 리스트 콘텐츠 |

---

## 3. 기능 상세

### 3.1 프로필 정보 영역

#### 3.1.1 프로필 이미지
- 기본 이미지 또는 사용자 설정 이미지
- 원형 마스크 적용
- 탭 시 이미지 확대 보기 (옵션)

#### 3.1.2 닉네임
- 사용자 닉네임 표시
- 인증배지 보유 시 닉네임 옆에 인증 아이콘 표시

#### 3.1.3 알림 버튼
- ON/OFF 토글 버튼
- ON: "알림 ON" + 활성화 아이콘
- OFF: "알림 OFF" + 비활성화 아이콘
- 탭 시 알림 설정 토글

### 3.2 통계 정보 영역

#### 3.2.1 받은 알림
- 해당 사용자를 알림 설정한 사람 수
- "523개" 형식 표시

#### 3.2.2 예측 성공
- 예측게임 성공 기록
- "45/50 (90%)" 형식 - 성공/시도 (성공률)

#### 3.2.3 인증배지
- 보유한 인증배지 개수
- "3개" 형식 표시
- 탭 시 배지 상세 팝업

#### 3.2.4 활동온도
- 사용자 활동 지표
- "36.5°" 형식 표시
- 온도에 따른 컬러 변화 (저온: 파랑, 고온: 빨강)

### 3.3 게시글 탭 (페이지 63)

해당 사용자가 작성한 게시글 목록을 표시합니다.

#### 3.3.1 게시글 리스트 항목
| 필드 | 설명 |
|------|------|
| 게시글 제목 | 게시글 제목 (말줄임 처리) |
| 카테고리 | 게시판 카테고리 |
| 작성일 | "2025.12.22" 또는 "1시간 전" |
| 댓글 수 | 💬 12 형식 |
| 좋아요 수 | ❤️ 45 형식 |
| 조회 수 | 👁 123 형식 |

#### 3.3.2 인터랙션
- 게시글 탭: 해당 게시글 상세 페이지로 이동

### 3.4 응원글 탭 (페이지 64)

해당 사용자가 작성한 응원글 목록을 표시합니다.

#### 3.4.1 응원글 리스트 항목
| 필드 | 설명 |
|------|------|
| 경기 정보 | 팀A vs 팀B |
| 응원글 내용 | 응원 메시지 (말줄임 처리) |
| 작성일 | 작성 시간 |
| 좋아요 수 | ❤️ 12 형식 |

#### 3.4.2 인터랙션
- 응원글 탭: 해당 경기 상세 페이지로 이동

### 3.5 예측게임 탭 (페이지 65)

해당 사용자의 예측게임 참여 기록을 표시합니다.

#### 3.5.1 예측게임 리스트 항목
| 필드 | 설명 |
|------|------|
| 경기 정보 | 팀A vs 팀B |
| 리그 정보 | 리그명, 날짜 |
| 예측 내용 | "홈팀 승" 등 예측 선택 |
| 결과 | ⭕ 적중 / ❌ 미적중 / ⏳ 진행중 |

#### 3.5.2 필터 옵션
- 전체 / 적중 / 미적중 / 진행중

### 3.6 알림 탭 (페이지 66)

알림 관계를 보여주는 탭입니다.

#### 3.6.1 서브 탭 구조
- **나를 알림한 사람**: 이 사용자를 알림 설정한 사람 목록
- **내가 알림한 사람**: 이 사용자가 알림 설정한 사람 목록

#### 3.6.2 알림 리스트 항목
| 필드 | 설명 |
|------|------|
| 프로필 이미지 | 사용자 프로필 사진 |
| 닉네임 | 사용자 닉네임 |
| 알림 버튼 | 해당 사용자 알림 설정 토글 |

#### 3.6.3 인터랙션
- 프로필 탭: 해당 사용자 프로필로 이동
- 알림 버튼 탭: 알림 ON/OFF 토글

### 3.7 신고 기능

#### 3.7.1 신고 플로우
1. 헤더의 신고 버튼 탭
2. 신고 사유 선택 모달 표시
3. 신고 사유 선택 (복수 선택 가능)
4. 신고 접수 완료 토스트

#### 3.7.2 신고 사유 목록
- 스팸/광고
- 불쾌한 콘텐츠
- 부적절한 닉네임
- 사기/사칭
- 기타 (직접 입력)

---

## 4. 데이터 요구사항

### 4.1 유저 프로필 데이터

```typescript
interface UserProfile {
  userId: string;                  // 사용자 ID
  nickname: string;                // 닉네임
  profileImage: string | null;     // 프로필 이미지 URL
  isVerified: boolean;             // 인증 여부
  notificationCount: number;       // 받은 알림 수
  predictionSuccess: number;       // 예측 성공 횟수
  predictionTotal: number;         // 예측 전체 횟수
  predictionRate: number;          // 예측 성공률 (%)
  badgeCount: number;              // 인증배지 개수
  activityTemperature: number;     // 활동온도
  isNotificationEnabled: boolean;  // 현재 사용자가 알림 설정 여부
  createdAt: string;               // 가입일
}
```

### 4.2 게시글 데이터

```typescript
interface UserPost {
  postId: string;                  // 게시글 ID
  title: string;                   // 제목
  category: string;                // 카테고리
  createdAt: string;               // 작성일
  commentCount: number;            // 댓글 수
  likeCount: number;               // 좋아요 수
  viewCount: number;               // 조회 수
}

interface UserPostsResponse {
  posts: UserPost[];
  totalCount: number;
  pagination: Pagination;
}
```

### 4.3 응원글 데이터

```typescript
interface UserCheer {
  cheerId: string;                 // 응원글 ID
  matchId: string;                 // 경기 ID
  homeTeam: string;                // 홈팀명
  awayTeam: string;                // 원정팀명
  content: string;                 // 응원 내용
  createdAt: string;               // 작성일
  likeCount: number;               // 좋아요 수
}

interface UserCheersResponse {
  cheers: UserCheer[];
  totalCount: number;
  pagination: Pagination;
}
```

### 4.4 예측게임 데이터

```typescript
interface UserPrediction {
  predictionId: string;            // 예측 ID
  matchId: string;                 // 경기 ID
  homeTeam: string;                // 홈팀명
  awayTeam: string;                // 원정팀명
  league: string;                  // 리그명
  matchDate: string;               // 경기 날짜
  prediction: string;              // 예측 내용 (홈팀 승, 무승부 등)
  result: 'success' | 'fail' | 'pending';  // 결과
}

interface UserPredictionsResponse {
  predictions: UserPrediction[];
  totalCount: number;
  pagination: Pagination;
}
```

### 4.5 알림 관계 데이터

```typescript
interface NotificationUser {
  userId: string;                  // 사용자 ID
  nickname: string;                // 닉네임
  profileImage: string | null;     // 프로필 이미지 URL
  isNotificationEnabled: boolean;  // 현재 사용자가 알림 설정 여부
}

interface NotificationRelationsResponse {
  type: 'followers' | 'following'; // 나를 알림한 / 내가 알림한
  users: NotificationUser[];
  totalCount: number;
  pagination: Pagination;
}
```

### 4.6 인증배지 데이터

```typescript
interface Badge {
  badgeId: string;                 // 배지 ID
  name: string;                    // 배지명
  description: string;             // 배지 설명
  iconUrl: string;                 // 배지 아이콘 URL
  acquiredAt: string;              // 획득일
}
```

---

## 5. API 요구사항

### 5.1 유저 프로필 조회

```
GET /api/v1/users/{userId}/profile
```

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "user123",
    "nickname": "축구왕",
    "profileImage": "https://...",
    "isVerified": true,
    "notificationCount": 523,
    "predictionSuccess": 45,
    "predictionTotal": 50,
    "predictionRate": 90.0,
    "badgeCount": 3,
    "activityTemperature": 36.5,
    "isNotificationEnabled": false,
    "createdAt": "2024-01-15T09:00:00Z"
  }
}
```

### 5.2 유저 게시글 목록 조회

```
GET /api/v1/users/{userId}/posts
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "posts": [
      {
        "postId": "post123",
        "title": "오늘 경기 분석",
        "category": "자유게시판",
        "createdAt": "2025-12-22T15:30:00Z",
        "commentCount": 12,
        "likeCount": 45,
        "viewCount": 123
      }
    ],
    "totalCount": 28,
    "pagination": {
      "currentPage": 1,
      "totalPages": 2,
      "hasNext": true
    }
  }
}
```

### 5.3 유저 응원글 목록 조회

```
GET /api/v1/users/{userId}/cheers
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "cheers": [
      {
        "cheerId": "cheer123",
        "matchId": "match456",
        "homeTeam": "토트넘",
        "awayTeam": "맨시티",
        "content": "손흥민 화이팅! 오늘 해트트릭 가자!",
        "createdAt": "2025-12-22T19:00:00Z",
        "likeCount": 12
      }
    ],
    "totalCount": 45,
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "hasNext": true
    }
  }
}
```

### 5.4 유저 예측게임 목록 조회

```
GET /api/v1/users/{userId}/predictions
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| result | string | X | 필터: 'all', 'success', 'fail', 'pending' |
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "predictions": [
      {
        "predictionId": "pred123",
        "matchId": "match789",
        "homeTeam": "레알마드리드",
        "awayTeam": "바르셀로나",
        "league": "라리가",
        "matchDate": "2025-12-21",
        "prediction": "홈팀 승",
        "result": "success"
      }
    ],
    "totalCount": 50,
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "hasNext": true
    }
  }
}
```

### 5.5 알림 관계 조회

```
GET /api/v1/users/{userId}/notifications/relations
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| type | string | O | 'followers' (나를 알림한) 또는 'following' (내가 알림한) |
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "type": "followers",
    "users": [
      {
        "userId": "user456",
        "nickname": "축구팬",
        "profileImage": "https://...",
        "isNotificationEnabled": true
      }
    ],
    "totalCount": 523,
    "pagination": {
      "currentPage": 1,
      "totalPages": 27,
      "hasNext": true
    }
  }
}
```

### 5.6 유저 배지 목록 조회

```
GET /api/v1/users/{userId}/badges
```

**Response:**
```json
{
  "success": true,
  "data": [
    {
      "badgeId": "badge001",
      "name": "예측왕",
      "description": "예측 성공률 90% 이상 달성",
      "iconUrl": "https://...",
      "acquiredAt": "2025-11-15T12:00:00Z"
    }
  ]
}
```

### 5.7 사용자 신고

```
POST /api/v1/users/{userId}/report
```

**Request Body:**
```json
{
  "reasons": ["spam", "inappropriate_content"],
  "description": "추가 설명 (선택)"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "reportId": "report123",
    "status": "received"
  }
}
```

---

## 6. 관리자 기능

### 6.1 관리 항목

| 기능 | 설명 |
|------|------|
| 사용자 조회 | 전체 사용자 목록 조회 및 검색 |
| 프로필 수정 | 사용자 프로필 정보 수정 |
| 계정 정지 | 규정 위반 사용자 계정 정지 |
| 신고 관리 | 신고 접수 내역 조회 및 처리 |
| 배지 관리 | 인증배지 부여/회수 |
| 활동온도 조정 | 활동온도 수동 조정 |

### 6.2 관리자 API

#### 사용자 목록 조회 (Admin)
```
GET /api/admin/users
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| search | string | X | 닉네임/이메일 검색 |
| status | string | X | 상태 필터 (active, suspended, deleted) |
| page | number | X | 페이지 번호 |
| limit | number | X | 페이지 당 개수 |

#### 사용자 상세 조회 (Admin)
```
GET /api/admin/users/{userId}
```

#### 사용자 프로필 수정 (Admin)
```
PATCH /api/admin/users/{userId}/profile
```

**Request Body:**
```json
{
  "nickname": "새닉네임",
  "profileImage": "https://...",
  "isVerified": true
}
```

#### 계정 정지 (Admin)
```
POST /api/admin/users/{userId}/suspend
```

**Request Body:**
```json
{
  "reason": "규정 위반",
  "duration": "7days",
  "notifyUser": true
}
```

#### 신고 목록 조회 (Admin)
```
GET /api/admin/reports
```

#### 신고 처리 (Admin)
```
PATCH /api/admin/reports/{reportId}
```

**Request Body:**
```json
{
  "status": "resolved",
  "action": "warning",
  "adminNote": "경고 조치"
}
```

#### 배지 부여/회수 (Admin)
```
POST /api/admin/users/{userId}/badges
```

**Request Body:**
```json
{
  "badgeId": "badge001",
  "action": "grant"
}
```

### 6.3 관리자 대시보드 요구사항

- 사용자 통계 (신규 가입, 활성 사용자, 정지 사용자)
- 신고 현황 대시보드
- 사용자 검색 및 필터링
- 일괄 작업 지원 (복수 사용자 정지/해제)

---

## 7. 비즈니스 로직

### 7.1 활동온도 계산

활동온도는 사용자의 활동 품질을 나타내는 지표입니다.

#### 온도 변화 요인
| 활동 | 온도 변화 |
|------|----------|
| 게시글 작성 | +0.1° |
| 댓글 작성 | +0.05° |
| 좋아요 받음 | +0.02° |
| 예측 성공 | +0.2° |
| 신고 접수 | -1.0° |
| 경고 조치 | -3.0° |

#### 온도 범위
- 최저: 0°
- 초기값: 36.5°
- 최고: 100°

### 7.2 인증배지 시스템

#### 배지 종류
| 배지명 | 조건 |
|-------|------|
| 예측왕 | 예측 성공률 90% 이상 (최소 20회) |
| 알림스타 | 받은 알림 1000개 이상 |
| 게시왕 | 게시글 100개 이상 |
| 활동맨 | 활동온도 80° 이상 유지 30일 |

#### 배지 정책 ✅

> **확정** (2026-01-09)

| 항목 | 정책 |
|------|------|
| 배지 회수 | **회수하지 않음** - 조건 미달 시에도 획득한 배지는 유지 |
| 배지 획득 알림 | **푸시 알림 미발송** - 배지 획득 시 별도 푸시 알림 없음 |
| 프로필 표시 | **개수로 표시** (최대 9개) |

### 7.3 신고 처리 정책

| 신고 횟수 | 처리 |
|----------|------|
| 1-2회 | 모니터링 |
| 3-4회 | 경고 알림 |
| 5회 이상 | 검토 후 조치 (정지/해제) |

---

## 8. UI/UX 고려사항

### 8.1 로딩 상태
- 프로필 영역: 스켈레톤 UI
- 탭 콘텐츠: 리스트 스켈레톤

### 8.2 빈 상태
- 게시글 없음: "작성한 게시글이 없습니다"
- 응원글 없음: "작성한 응원글이 없습니다"
- 예측게임 없음: "참여한 예측게임이 없습니다"
- 알림 없음: "알림 관계가 없습니다"

### 8.3 에러 상태
- 프로필 로드 실패 시 재시도 버튼
- 탭 콘텐츠 로드 실패 시 개별 재시도

### 8.4 탭 상태 유지
- 탭 전환 시 스크롤 위치 유지
- 뒤로가기 시 마지막 탭 상태 복원

---

## 9. 원본 참조

- **페이지 61**: 유저 프로필 섹션 타이틀
- **페이지 62**: 유저 프로필 전체 레이아웃
- **페이지 63**: 게시글 탭
- **페이지 64**: 응원글 탭
- **페이지 65**: 예측게임 탭
- **페이지 66**: 알림 탭 (나를 알림한 사람 / 내가 알림한 사람)
