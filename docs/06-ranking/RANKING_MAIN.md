# 랭킹 메인 화면

## 1. 개요

랭킹 화면은 사용자들의 활동을 기반으로 순위를 표시하는 기능입니다. 알림 랭킹과 예측게임 랭킹 두 가지 유형의 랭킹을 제공합니다.

- **원본 PDF 참조**: 58-60 페이지

---

## 2. 화면 구성

### 2.1 전체 레이아웃

#### 알림 랭킹 (투데이)
```
┌─────────────────────────────────────┐
│ 랭킹                                │  ← 헤더
├─────────────────────────────────────┤
│   [알림 랭킹]      예측게임 랭킹      │  ← 메인 탭 (활성: 네이비 배경)
├─────────────────────────────────────┤
│   [투데이]        전체               │  ← 서브 탭 (활성: 밑줄)
├─────────────────────────────────────┤
│ 🥇 [프로필] 닉네임  🔔 NNN           │
│              예측성공 NN            │  ← 1위 (금메달)
│ 🥈 [프로필] 닉네임  🔔 NNN     🔔    │
│              예측성공 NN            │  ← 2위 (은메달)
│ 🥉 [프로필] 닉네임  🔔 NNN     🔔    │
│              예측성공 NN            │  ← 3위 (동메달)
│  4  [프로필] 닉네임  🔔 NNN     🔔    │
│              예측성공 NN            │  ← 4위 이하 (숫자)
│  5  ...                             │
│  6  ...                             │
├─────────────────────────────────────┤
│  홈  픽전문가  커뮤니티  [랭킹]  MY   │  ← 하단 탭바
└─────────────────────────────────────┘
```

#### 예측게임 랭킹
```
┌─────────────────────────────────────┐
│ 랭킹                                │  ← 헤더
├─────────────────────────────────────┤
│    알림 랭킹     [예측게임 랭킹]      │  ← 메인 탭 (활성: 네이비 배경)
├─────────────────────────────────────┤
│   [투데이]        전체               │  ← 서브 탭
├─────────────────────────────────────┤
│  ┌─────────────────────────────┐    │
│  │   카테고리 이름           ▼│    │  ← 카테고리 드롭다운
│  └─────────────────────────────┘    │
├─────────────────────────────────────┤
│ 🥇 [프로필] 닉네임  🔔 NNN     🔔    │
│ 🥈 [프로필] 닉네임  🔔 NNN     🔔    │
│ 🥉 [프로필] 닉네임  🔔 NNN     🔔    │
│  4  [프로필] 닉네임  🔔 NNN     🔔    │
│  5  ...                             │
├─────────────────────────────────────┤
│  홈  픽전문가  커뮤니티  [랭킹]  MY   │  ← 하단 탭바
└─────────────────────────────────────┘
```

### 2.2 주요 컴포넌트

| 컴포넌트 | 설명 |
|---------|------|
| 헤더 | "랭킹" 타이틀 |
| 메인 탭 | 알림 랭킹 / 예측게임 랭킹 전환 (활성: 네이비 배경 + 흰색 텍스트) |
| 서브 탭 | 투데이 / 전체 기간 전환 (활성: 밑줄) |
| 카테고리 드롭다운 | 예측게임 랭킹 전용 (카테고리 이름 ▼) |
| 랭킹 리스트 | 순위별 사용자 목록 |
| 랭킹 아이템 | 순위, 프로필, 닉네임, 알림수, 예측성공 수, 알림 버튼 |

### 2.3 랭킹 아이템 구성

| 요소 | 설명 |
|------|------|
| 순위 표시 | 1~3위: 메달 아이콘 (🥇🥈🥉), 4위 이하: 숫자 |
| 프로필 이미지 | 원형 프로필 사진 |
| 닉네임 | 사용자 닉네임 |
| 알림 수 | 🔔 NNN 형식 |
| 예측성공 | "예측성공 NN" (빨간색 텍스트, 알림 랭킹에서만) |
| 알림 버튼 | 🔔 아이콘 (우측, 알림 설정 토글) |

---

## 3. 기능 상세

### 3.1 알림 랭킹 (페이지 59)

사용자가 받은 알림(팔로우) 수를 기준으로 순위를 매깁니다.

#### 3.1.1 탭 구조
- **투데이**: 당일(00:00~23:59) 기준 알림 수
- **전체**: 누적 알림 수

#### 3.1.2 랭킹 리스트 항목
| 필드 | 설명 |
|------|------|
| 순위 | 1, 2, 3... (숫자 표시) |
| 프로필 이미지 | 사용자 프로필 사진 |
| 닉네임 | 사용자 닉네임 |
| 알림 수 | "123개" 형식 표시 |
| 알림 버튼 | 해당 사용자 알림 설정 토글 |

#### 3.1.3 인터랙션
- **프로필 탭**: 해당 사용자 프로필 페이지로 이동
- **알림 버튼 탭**: 알림 ON/OFF 토글
  - ON 상태: 아이콘 활성화
  - OFF 상태: 아이콘 비활성화

### 3.2 예측게임 랭킹 (페이지 60)

예측게임 성공률을 기준으로 순위를 매깁니다.

#### 3.2.1 탭 구조
- **투데이**: 당일 기준 예측 성공 수
- **전체**: 누적 예측 성공 수

#### 3.2.2 카테고리 필터
스포츠 종목별 필터링 드롭다운:
- 전체
- 축구
- 농구
- 야구
- 배구
- 기타

#### 3.2.3 랭킹 리스트 항목
| 필드 | 설명 |
|------|------|
| 순위 | 1, 2, 3... (숫자 표시) |
| 프로필 이미지 | 사용자 프로필 사진 |
| 닉네임 | 사용자 닉네임 |
| 예측 성공 | "45/50 (90%)" 형식 - 성공/시도 (성공률) |
| 알림 버튼 | 해당 사용자 알림 설정 토글 |

### 3.3 공통 기능

#### 3.3.1 무한 스크롤
- 랭킹 리스트는 페이지네이션 적용
- 스크롤 시 추가 데이터 로드

#### 3.3.2 Pull to Refresh
- 당겨서 새로고침 지원
- 최신 랭킹 데이터 갱신

#### 3.3.3 Top 3 강조 표시
- 1위: 금색 배경 또는 아이콘
- 2위: 은색 배경 또는 아이콘
- 3위: 동색 배경 또는 아이콘

---

## 4. 데이터 요구사항

### 4.1 알림 랭킹 데이터

```typescript
interface NotificationRankingItem {
  rank: number;                    // 순위
  userId: string;                  // 사용자 ID
  profileImage: string | null;     // 프로필 이미지 URL
  nickname: string;                // 닉네임
  notificationCount: number;       // 알림 수
  isNotificationEnabled: boolean;  // 현재 사용자가 알림 설정 여부
}

interface NotificationRankingResponse {
  period: 'today' | 'all';         // 기간 타입
  rankings: NotificationRankingItem[];
  totalCount: number;              // 전체 랭킹 수
  myRank: number | null;           // 내 순위 (로그인 시)
}
```

### 4.2 예측게임 랭킹 데이터

```typescript
interface PredictionRankingItem {
  rank: number;                    // 순위
  userId: string;                  // 사용자 ID
  profileImage: string | null;     // 프로필 이미지 URL
  nickname: string;                // 닉네임
  successCount: number;            // 성공 횟수
  totalCount: number;              // 전체 시도 횟수
  successRate: number;             // 성공률 (%)
  isNotificationEnabled: boolean;  // 현재 사용자가 알림 설정 여부
}

interface PredictionRankingResponse {
  period: 'today' | 'all';         // 기간 타입
  category: string;                // 스포츠 카테고리
  rankings: PredictionRankingItem[];
  totalCount: number;              // 전체 랭킹 수
  myRank: number | null;           // 내 순위 (로그인 시)
}
```

### 4.3 스포츠 카테고리

```typescript
interface SportCategory {
  id: string;                      // 카테고리 ID
  name: string;                    // 카테고리명 (축구, 농구 등)
  code: string;                    // 카테고리 코드
}
```

---

## 5. API 요구사항

### 5.1 알림 랭킹 조회

```
GET /api/v1/rankings/notification
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| period | string | O | 'today' 또는 'all' |
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "period": "today",
    "rankings": [
      {
        "rank": 1,
        "userId": "user123",
        "profileImage": "https://...",
        "nickname": "축구왕",
        "notificationCount": 523,
        "isNotificationEnabled": false
      }
    ],
    "totalCount": 1500,
    "myRank": 42,
    "pagination": {
      "currentPage": 1,
      "totalPages": 75,
      "hasNext": true
    }
  }
}
```

### 5.2 예측게임 랭킹 조회

```
GET /api/v1/rankings/prediction
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| period | string | O | 'today' 또는 'all' |
| category | string | X | 스포츠 카테고리 ID (기본값: 'all') |
| page | number | X | 페이지 번호 (기본값: 1) |
| limit | number | X | 페이지 당 개수 (기본값: 20) |

**Response:**
```json
{
  "success": true,
  "data": {
    "period": "today",
    "category": "soccer",
    "rankings": [
      {
        "rank": 1,
        "userId": "user456",
        "profileImage": "https://...",
        "nickname": "예측신",
        "successCount": 45,
        "totalCount": 50,
        "successRate": 90.0,
        "isNotificationEnabled": true
      }
    ],
    "totalCount": 800,
    "myRank": 15,
    "pagination": {
      "currentPage": 1,
      "totalPages": 40,
      "hasNext": true
    }
  }
}
```

### 5.3 스포츠 카테고리 목록 조회

```
GET /api/v1/categories/sports
```

**Response:**
```json
{
  "success": true,
  "data": [
    { "id": "all", "name": "전체", "code": "ALL" },
    { "id": "soccer", "name": "축구", "code": "SOCCER" },
    { "id": "basketball", "name": "농구", "code": "BASKETBALL" },
    { "id": "baseball", "name": "야구", "code": "BASEBALL" },
    { "id": "volleyball", "name": "배구", "code": "VOLLEYBALL" }
  ]
}
```

### 5.4 사용자 알림 설정 토글

```
POST /api/v1/users/{userId}/notification
```

**Request Body:**
```json
{
  "enabled": true
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "user123",
    "isNotificationEnabled": true
  }
}
```

---

## 6. 관리자 기능

### 6.1 관리 항목

| 기능 | 설명 |
|------|------|
| 랭킹 데이터 조회 | 전체 랭킹 데이터 조회 및 검색 |
| 사용자 랭킹 수정 | 비정상 활동 사용자 랭킹 제외 처리 |
| 랭킹 초기화 | 투데이 랭킹 수동 초기화 |
| 부정 행위 모니터링 | 비정상적인 랭킹 상승 패턴 감지 |

### 6.2 관리자 API

#### 랭킹 목록 조회 (Admin)
```
GET /api/admin/rankings
```

#### 사용자 랭킹 제외 처리
```
POST /api/admin/rankings/{userId}/exclude
```

**Request Body:**
```json
{
  "reason": "부정 행위 감지",
  "duration": "permanent"  // 또는 "7days", "30days"
}
```

#### 랭킹 초기화
```
POST /api/admin/rankings/reset
```

**Request Body:**
```json
{
  "type": "notification",  // 또는 "prediction"
  "period": "today"
}
```

### 6.3 관리자 대시보드 요구사항

- 실시간 랭킹 변동 모니터링
- 비정상 활동 알림 (급격한 순위 상승 등)
- 랭킹 통계 (일별/주별/월별 추이)
- 제외된 사용자 목록 관리

---

## 7. 비즈니스 로직

### 7.1 랭킹 갱신 주기

| 타입 | 갱신 주기 | 설명 |
|------|----------|------|
| 투데이 랭킹 | 실시간 | 활동 발생 시 즉시 반영 |
| 전체 랭킹 | 1시간 | 배치 처리로 갱신 |

### 7.2 투데이 랭킹 초기화

- 매일 00:00 (자정) 자동 초기화
- 이전 날 데이터는 전체 랭킹에 누적

### 7.3 동점자 처리

동일 점수인 경우 처리 기준:
1. 먼저 달성한 사용자 우선
2. 가입일 순 (오래된 사용자 우선)

---

## 8. UI/UX 고려사항

### 8.1 로딩 상태
- 스켈레톤 UI 표시
- 랭킹 아이템 형태의 플레이스홀더

### 8.2 빈 상태
- 랭킹 데이터가 없는 경우 안내 메시지
- "아직 랭킹 데이터가 없습니다" + 관련 일러스트

### 8.3 에러 상태
- 네트워크 에러 시 재시도 버튼 제공
- 토스트 메시지로 에러 알림

### 8.4 내 순위 표시
- 로그인 사용자의 경우 화면 하단에 내 순위 고정 표시
- "내 순위: 42위" 형태로 항상 확인 가능

---

## 9. 원본 참조

- **페이지 58**: 랭킹 섹션 타이틀
- **페이지 59**: 알림 랭킹 화면 레이아웃
- **페이지 60**: 예측게임 랭킹 화면 레이아웃
