# 무료 픽 (Free Picks)

## 1. 개요

무료 픽은 **일반 유저가 직접 등록**하는 분석 픽입니다. 별도의 열람 비용이나 등록 자격 없이 모든 유저가 확인할 수 있습니다.

**✅ 확정 정책 (2026-01-06)**:
- 일반 유저가 직접 등록하는 픽
- 별도의 열람 비용 없음
- 별도의 등록 자격 없음 (모든 유저 등록 가능)
- 무분별한 픽 등록 방지를 위해 **경고 모달만 표시** (피그마 적용됨)
- 경기 종료된 유료픽이 자동 전환되어 무료픽으로도 제공됨

- **원본 PDF 참조**: 47-49, 51페이지

---

## 2. 화면 구성

### 2.1 무료픽 목록 화면

#### 상단 영역
| 요소 | 설명 |
|------|------|
| 종목 필터 | 전체, 축구, 야구, 농구 등 종목 선택 |
| 검색 버튼 | 픽 검색 기능 |

#### 픽 리스트 영역
| 요소 | 설명 |
|------|------|
| 프로필 이미지 | 작성자 프로필 사진 |
| 닉네임 | 작성자 닉네임 |
| 등급 뱃지 | 작성자 등급 표시 |
| 픽 제목 | 분석 픽 제목 |
| 경기 정보 | 팀명, 리그, 경기 시간 |
| 베팅 타입 | 승무패, 핸디캡, 언더오버 |
| 적중 라벨 | 경기 종료 후 적중/미적중 표시 |
| 조회수/좋아요 | 픽 통계 정보 |

#### 하단 플로팅 버튼
| 요소 | 설명 |
|------|------|
| 무료픽 등록하기 버튼 | 무료픽 등록 화면으로 이동 |

### 2.2 무료픽 상세 화면

#### 전문가 정보 영역
| 요소 | 설명 |
|------|------|
| 프로필 이미지 | 작성자 프로필 |
| 닉네임 | 작성자 닉네임 |
| 등급 뱃지 | 등급 표시 |
| 적중률 | 전체 적중률 |

#### 경기 정보 영역
| 요소 | 설명 |
|------|------|
| 리그 정보 | 리그명, 로고 |
| 경기 시간 | 경기 예정/진행/종료 시간 |
| 팀 정보 | 양 팀 엠블럼, 팀명 |
| 스코어 | 진행/종료 시 스코어 |
| 적중 라벨 | 경기 종료 시 "적중" 또는 "미적중" 표시 |

#### 픽 내용 영역
| 요소 | 설명 |
|------|------|
| 베팅 타입 | 승무패 / 핸디캡 / 언더오버 |
| 예측 | 예측 값 (예: "홈팀 승") |
| 픽 제목 | 분석 제목 |
| 분석 내용 | 상세 분석 텍스트 |

#### 하단 인터랙션 영역
| 요소 | 설명 |
|------|------|
| 좋아요 버튼 | 좋아요 토글 |
| 댓글 버튼 | 댓글 영역 이동 |
| 공유 버튼 | 픽 공유 |

---

## 3. 기능 상세

### 3.1 무료픽 등록 정책

**✅ 확정 정책**: 무료픽은 별도의 등록 자격 조건이 없습니다. 모든 유저가 등록 가능합니다.

#### 등록 시 경고 모달
무분별한 픽 등록을 방지하기 위해 등록 전 경고 모달을 표시합니다.

```
┌─────────────────────────────┐
│       무료픽 등록 안내        │
├─────────────────────────────┤
│                             │
│  무료픽 등록 시 주의사항:    │
│                             │
│  • 근거 없는 예측 등록 지양  │
│  • 적중률이 기록에 반영됩니다 │
│  • 부적절한 내용은 삭제될    │
│    수 있습니다               │
│                             │
├─────────────────────────────┤
│   [취소]      [등록하기]     │
└─────────────────────────────┘
```

> **참고**: 피그마에 경고 모달 디자인이 적용되어 있습니다.

### 3.2 무료픽 등록 플로우

```
1. "무료픽 등록하기" 버튼 클릭
2. 경고 모달 표시 (등록 안내)
   - [취소]: 이전 화면으로 복귀
   - [등록하기]: 등록 화면으로 이동
3. 경기 선택
   - 예정된 경기 목록에서 선택
   - 종목별 필터링 가능
4. 베팅 타입 선택
   - 승무패 / 핸디캡 / 언더오버
5. 예측 선택
   - 선택한 타입에 따른 옵션 선택
6. 제목 입력
7. 분석 내용 작성
8. 등록하기 클릭
9. 등록 완료
```

### 3.3 무료픽 등록 화면

#### 3.3.1 경기 선택 영역
| 요소 | 설명 |
|------|------|
| 종목 탭 | 축구, 야구, 농구 등 종목 선택 |
| 날짜 선택 | 경기 날짜 선택 |
| 경기 목록 | 선택 가능한 경기 리스트 |
| 선택된 경기 | 선택한 경기 하이라이트 표시 |

#### 3.3.2 베팅 타입 선택
| 타입 | 옵션 |
|------|------|
| 승무패 | 홈팀 승 / 무승부 / 원정팀 승 |
| 핸디캡 | 홈팀 / 원정팀 + 핸디캡 수치 |
| 언더오버 | 언더 / 오버 + 기준점 |

#### 3.3.3 분석 입력
| 요소 | 설명 |
|------|------|
| 제목 입력 | 최대 50자 |
| 분석 내용 | 최대 2000자, 마크다운 미지원 |

### 3.4 수정/삭제
- 경기 시작 전까지만 수정/삭제 가능
- 경기 시작 후에는 수정/삭제 불가

### 3.5 유료픽 전환
- 경기 종료 후 유료픽은 자동으로 무료픽으로 전환
- 전환된 픽에는 "유료픽 전환" 라벨 표시

---

## 4. 데이터 요구사항

### 4.1 무료픽 상세 데이터
```typescript
interface FreePickDetail {
  id: string;
  type: 'free';
  source: 'user' | 'converted';  // 사용자 등록 or 유료픽 전환
  author: {
    id: string;
    nickname: string;
    profileImage: string;
    grade: string;
    hitRate: number;
  };
  match: {
    id: string;
    league: {
      id: string;
      name: string;
      logo: string;
    };
    homeTeam: {
      id: string;
      name: string;
      logo: string;
    };
    awayTeam: {
      id: string;
      name: string;
      logo: string;
    };
    matchTime: string;
    status: 'scheduled' | 'live' | 'finished';
    score?: {
      home: number;
      away: number;
    };
  };
  pick: {
    bettingType: 'match_result' | 'handicap' | 'under_over';
    bettingOption?: {
      type: string;  // 핸디캡/언오버 세부 옵션
      value: number;
    };
    prediction: string;
    title: string;
    analysis: string;
  };
  result?: 'hit' | 'miss' | null;
  stats: {
    viewCount: number;
    likeCount: number;
    commentCount: number;
    isLiked: boolean;
  };
  createdAt: string;
  updatedAt: string;
}
```

### 4.2 등록 조건 데이터
```typescript
interface RegistrationCondition {
  id: string;
  name: string;
  description: string;
  currentValue: number;
  requiredValue: number;
  isMet: boolean;
}

interface RegistrationEligibility {
  canRegister: boolean;
  conditions: RegistrationCondition[];
}
```

### 4.3 픽 등록 요청 데이터
```typescript
interface CreateFreePickRequest {
  matchId: string;
  bettingType: 'match_result' | 'handicap' | 'under_over';
  bettingOption?: {
    type: string;
    value: number;
  };
  prediction: string;
  title: string;
  analysis: string;
}
```

---

## 5. API 요구사항

### 5.1 무료픽 목록 조회
```
GET /api/picks?type=free
```

### 5.2 무료픽 상세 조회
```
GET /api/picks/:pickId
```

### 5.3 등록 조건 확인
```
GET /api/picks/free/eligibility
```

**Response:**
```json
{
  "success": true,
  "data": {
    "canRegister": false,
    "conditions": [
      {
        "id": "level",
        "name": "레벨 조건",
        "description": "레벨 3 이상",
        "currentValue": 5,
        "requiredValue": 3,
        "isMet": true
      },
      {
        "id": "post_count",
        "name": "게시글 조건",
        "description": "게시글 10개 이상",
        "currentValue": 5,
        "requiredValue": 10,
        "isMet": false
      }
    ]
  }
}
```

### 5.4 등록 가능 경기 목록
```
GET /api/picks/free/available-matches
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| sport | string | X | 스포츠 종목 |
| date | string | X | 경기 날짜 (YYYY-MM-DD) |

### 5.5 무료픽 등록
```
POST /api/picks/free
```

**Request:**
```json
{
  "matchId": "match_123",
  "bettingType": "match_result",
  "prediction": "home_win",
  "title": "맨유 홈경기 분석",
  "analysis": "최근 홈경기 5연승 중인 맨유가..."
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "pickId": "pick_456",
    "message": "무료픽이 등록되었습니다."
  }
}
```

### 5.6 무료픽 수정
```
PUT /api/picks/:pickId
```

### 5.7 무료픽 삭제
```
DELETE /api/picks/:pickId
```

---

## 6. 관리자 기능

### 6.1 무료픽 관리
| 기능 | 설명 |
|------|------|
| 무료픽 목록 조회 | 전체 무료픽 목록 |
| 무료픽 상세 조회 | 픽 내용 확인 |
| 무료픽 삭제 | 부적절한 픽 삭제 |
| 무료픽 숨김 | 특정 픽 숨김 처리 |

### 6.2 등록 조건 관리
| 기능 | 설명 |
|------|------|
| 조건 목록 조회 | 현재 등록 조건 확인 |
| 조건 추가 | 새로운 조건 추가 |
| 조건 수정 | 조건 값 변경 |
| 조건 삭제 | 조건 제거 |
| 조건 활성화/비활성화 | 특정 조건 on/off |

**등록 조건 설정 예시:**
```typescript
interface RegistrationConditionConfig {
  id: string;
  type: 'level' | 'post_count' | 'comment_count' | 'join_days' | 'custom';
  name: string;
  description: string;
  requiredValue: number;
  isActive: boolean;
  order: number;
}
```

### 6.3 유료픽 전환 정책
| 기능 | 설명 |
|------|------|
| 전환 시점 설정 | 경기 종료 후 전환 시점 설정 |
| 전환 로그 조회 | 유료→무료 전환 기록 |

---

## 7. 팝업/모달

### 7.1 등록 조건 충족 팝업
```
┌─────────────────────────────┐
│      등록 조건 충족          │
├─────────────────────────────┤
│  무료픽 등록이 가능합니다!   │
│                             │
│  ☑ 레벨 3 이상              │
│  ☑ 게시글 10개 이상         │
│  ☑ 댓글 20개 이상           │
├─────────────────────────────┤
│  [취소]    [등록하러 가기]   │
└─────────────────────────────┘
```

### 7.2 등록 완료 토스트
```
"무료픽이 등록되었습니다."
```

### 7.3 수정 불가 안내
```
┌─────────────────────────────┐
│        수정 불가            │
├─────────────────────────────┤
│  경기가 시작되어            │
│  수정/삭제가 불가합니다.     │
├─────────────────────────────┤
│          [확인]             │
└─────────────────────────────┘
```

---

## 8. 화면 상태

### 8.1 로딩 상태
- 스켈레톤 UI 표시

### 8.2 빈 상태
- "등록된 무료픽이 없습니다"

### 8.3 경기 예정 상태
- 예측 정보 표시
- 적중 라벨 미표시

### 8.4 경기 종료 상태
- 적중/미적중 라벨 표시
- 최종 스코어 표시

### 8.5 유료픽 전환 표시
- "유료픽에서 전환됨" 라벨 표시
