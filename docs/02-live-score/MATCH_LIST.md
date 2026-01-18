# 경기 리스트 (MATCH_LIST)

## 1. 개요

경기 리스트는 라이브 메인 화면에서 선택된 조건(종목, 서브카테고리, 날짜)에 따라 경기 정보를 표시하는 핵심 컴포넌트입니다. 각 경기의 실시간 상태, 스코어, 배당 정보를 한눈에 확인할 수 있습니다.

**원본 PDF 참조**: 14-15페이지

---

## 2. 화면 구성

### 2.1 경기 카드 레이아웃

```
┌─────────────────────────────────────────────────────┐
│ [리그 로고] 리그명                    🔔 알림 버튼   │ ← ①②③
├─────────────────────────────────────────────────────┤
│ 운영자 등록글 노출                                  │ ← ④
├─────────────────────────────────────────────────────┤
│                                                     │
│  [홈팀 로고]    NN : NN    [원정팀 로고]            │ ← ⑤⑥
│    홈팀명      진행 중       원정팀명               │ ← ⑦⑧
│                                                     │
│           7/17일 ☁ 12°C                            │ ← ⑨ 날씨 정보
│                                                     │
├─────────────────────────────────────────────────────┤
│  승    무    패               👁                    │ ← ⑩ 배당 정보
│ N.NN  N.NN  N.NN                                   │
└─────────────────────────────────────────────────────┘
```

> **디자인 참고**: 경기 카드에 날씨 정보(날짜/날씨아이콘/온도) 표시됨

### 2.2 UI 구성요소

| 번호 | 구성요소 | 설명 |
|-----|--------|------|
| ① | 리그 로고 | 해당 리그/대회 로고 이미지 |
| ② | 리그명 | 리그/대회 명칭 노출 |
| ③ | 알림 버튼 | 해당 경기 알림 설정 (🔔) |
| ④ | 운영자 등록글 | 운영자가 등록한 경기 관련 코멘트 (1줄) |
| ⑤ | 팀 로고 | 홈팀/원정팀 엠블럼 이미지 |
| ⑥ | 스코어 | 경기 스코어 (NN : NN 형식) |
| ⑦ | 팀명 | 홈팀명/원정팀명 노출 |
| ⑧ | 경기 상태 | "진행 중", "종료", 경기 시간 등 표시 |
| ⑨ | 날씨 정보 | 경기일, 날씨 아이콘, 기온 (예: 7/17일 ☁ 12°C) |
| ⑩ | 배당 정보 | 승/무/패 배당률 + 상세보기 아이콘 (👁)

---

## 3. 종목별 상태 표시

### 3.1 상태 구분

| 상태 | 설명 |
|-----|------|
| 경기전 | 경기 시작 전 상태 |
| 경기중 | 실시간 진행 중인 경기 |
| 종료 | 경기 완료 상태 |

### 3.2 종목별 상태 노출 표시

#### 축구 (Soccer)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 18:00 |
| 경기중 | 전반 MM' / 후반 MM' / 추가 +MM' | 전반 23' |
| 휴식 | HT (하프타임) | HT |
| 종료 | 종료 | 종료 |

#### 야구 (Baseball)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 18:30 |
| 경기중 | N회초 / N회말 | 5회말 |
| 종료 | 종료 | 종료 |

**스코어 표시**: 이닝별 점수 표시
```
팀A  0 0 1 2 0 0 0 0 0  | 3
팀B  1 0 0 0 2 0 0 0 X  | 3
```

#### 농구 (Basketball)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 19:00 |
| 경기중 | NQ MM:SS | 2Q 05:23 |
| 휴식 | 휴식 | 휴식 |
| 연장 | OT / 2OT 등 | OT 03:15 |
| 종료 | 종료 | 종료 |

**스코어 표시**: 쿼터별 점수 표시
```
팀A  28  24  30  25  | 107
팀B  25  28  27  30  | 110
```

#### 배구 (Volleyball)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 17:00 |
| 경기중 | N세트 | 3세트 |
| 종료 | 종료 | 종료 |

**스코어 표시**: 세트 스코어 + 현재 세트 점수
```
팀A  25  23  15  | 2
팀B  21  25  12  | 1
        현재: 15-12
```

#### 아이스하키 (Ice Hockey)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 20:00 |
| 경기중 | N피리어드 MM:SS | 2피리어드 12:45 |
| 휴식 | 휴식 | 휴식 |
| 연장 | OT | OT 05:00 |
| 종료 | 종료 | 종료 |

#### 미식축구 (American Football)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 09:00 |
| 경기중 | NQ MM:SS | 3Q 08:30 |
| 휴식 | 하프타임 | HT |
| 연장 | OT | OT |
| 종료 | 종료 | 종료 |

**스코어 표시**: 쿼터별 점수 표시
```
팀A  7  14  3  10  | 34
팀B  10  7  7  14  | 38
```

#### 테니스 (Tennis)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 15:00 |
| 경기중 | N세트 | 2세트 |
| 종료 | 종료 | 종료 |

**스코어 표시**: 세트 스코어 + 현재 게임 스코어
```
선수A  6  4  3  | 서브 ●
선수B  4  6  2  |
        현재: 40-30
```

#### 크리켓 (Cricket)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 14:00 |
| 경기중 | N이닝 | 1이닝 |
| 종료 | 종료 | 종료 |

#### e스포츠 (E-Sports)

| 상태 | 표시 형식 | 예시 |
|-----|----------|------|
| 경기전 | MM/DD HH:MM | 05/05 19:00 |
| 경기중 | N세트(맵) | 2세트 |
| 종료 | 종료 | 종료 |

**스코어 표시**: 세트(맵) 스코어
```
팀A  | 1
팀B  | 2
```

---

## 4. 기능 상세

### 4.1 경기 카드 인터랙션

| 액션 | 동작 |
|-----|------|
| 카드 터치 | 경기 상세 페이지로 이동 |
| 알림 버튼 터치 | 해당 경기 알림 설정/해제 |
| 팀 로고 터치 | 팀 상세 페이지로 이동 |
| 배당 영역 터치 | 베팅 정보 상세 보기 |

### 4.2 알림 설정

```
┌─────────────────────────────────┐
│     경기 알림 설정              │
├─────────────────────────────────┤
│ ○ 경기 시작 10분 전            │
│ ○ 경기 시작 시                 │
│ ○ 득점 시                      │
│ ○ 경기 종료 시                 │
├─────────────────────────────────┤
│   [취소]        [확인]          │
└─────────────────────────────────┘
```

### 4.3 픽전문가 라벨

| 조건 | 표시 |
|-----|------|
| 픽전문가 픽 등록됨 | "픽전문가 N명 참여" 라벨 노출 |
| 픽전문가 픽 없음 | 라벨 미노출 |

### 4.4 운영자 코멘트

- 운영자가 어드민에서 등록한 경기 관련 코멘트 노출
- 최대 1줄, 말줄임 처리
- 터치 시 전체 내용 확인 가능

### 4.5 리스트 정렬

| 정렬 기준 | 설명 |
|----------|------|
| 기본 정렬 | 경기 시작 시간 오름차순 |
| 경기중 우선 | 진행 중인 경기 상단 노출 |
| 리그별 그룹핑 | 동일 리그 경기 묶음 표시 |

### 4.6 실시간 업데이트

- WebSocket 또는 Polling으로 실시간 데이터 갱신
- 갱신 항목: 스코어, 경기 상태, 시간, 배당
- 갱신 주기: 실시간 (WebSocket) 또는 10초 (Polling)

---

## 5. 데이터 요구사항

### 5.1 경기 데이터

| 필드명 | 타입 | 필수 | 설명 |
|-------|------|------|------|
| match_id | String | Y | 경기 고유 ID |
| league_id | String | Y | 리그 ID |
| league_name | String | Y | 리그명 |
| league_logo_url | String | N | 리그 로고 URL |
| sport_type | String | Y | 종목 코드 |
| match_status | String | Y | 경기 상태 (SCHEDULED/LIVE/FINISHED) |
| match_time | DateTime | Y | 경기 시작 시간 |
| current_period | String | N | 현재 피리어드/세트/쿼터 |
| elapsed_time | String | N | 경과 시간 |
| home_team | Object | Y | 홈팀 정보 |
| away_team | Object | Y | 원정팀 정보 |
| score | Object | N | 스코어 정보 |
| odds | Object | N | 배당 정보 |
| weather | Object | N | 날씨 정보 |
| has_expert_pick | Boolean | N | 픽전문가 픽 여부 |
| expert_count | Integer | N | 참여 픽전문가 수 |
| admin_comment | String | N | 운영자 코멘트 |
| is_notification_on | Boolean | N | 알림 설정 여부 |

### 5.5 날씨 데이터

| 필드명 | 타입 | 필수 | 설명 |
|-------|------|------|------|
| date | String | Y | 경기일 (예: "7/17일") |
| weather_icon | String | N | 날씨 아이콘 코드 (sunny/cloudy/rainy 등) |
| temperature | Integer | N | 기온 (섭씨) |
| temperature_unit | String | N | 온도 단위 (default: "°C")

### 5.2 팀 데이터

| 필드명 | 타입 | 필수 | 설명 |
|-------|------|------|------|
| team_id | String | Y | 팀 고유 ID |
| team_name | String | Y | 팀명 |
| team_logo_url | String | N | 팀 로고 URL |
| country | String | N | 국가명 |
| country_flag_url | String | N | 국기 이미지 URL |

### 5.3 스코어 데이터

| 필드명 | 타입 | 필수 | 설명 |
|-------|------|------|------|
| home_score | Integer | Y | 홈팀 총점 |
| away_score | Integer | Y | 원정팀 총점 |
| period_scores | Array | N | 피리어드별 점수 배열 |
| current_game_score | Object | N | 현재 게임 점수 (테니스 등) |

### 5.4 배당 데이터

| 필드명 | 타입 | 필수 | 설명 |
|-------|------|------|------|
| domestic_odds | Object | N | 국내 배당 |
| overseas_odds | Object | N | 해외 배당 |
| odds_type | String | Y | 배당 유형 (1X2/12/HANDICAP/OVER_UNDER) |
| home_odds | Float | N | 홈 배당 |
| draw_odds | Float | N | 무승부 배당 |
| away_odds | Float | N | 원정 배당 |

---

## 6. API 요구사항

### 6.1 경기 리스트 조회

```
GET /api/v1/matches
```

**Query Parameters**:

| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| date | String | Y | 조회 날짜 (YYYY-MM-DD) |
| sport_type | String | N | 종목 코드 |
| league_id | String | N | 리그 ID |
| status | String | N | 경기 상태 필터 |
| page | Integer | N | 페이지 번호 (default: 1) |
| limit | Integer | N | 페이지당 개수 (default: 20) |

**Response**:

```json
{
  "success": true,
  "data": {
    "matches": [
      {
        "match_id": "MATCH001",
        "league_id": "LEAGUE001",
        "league_name": "K리그1",
        "league_logo_url": "https://...",
        "sport_type": "SOCCER",
        "match_status": "LIVE",
        "match_time": "2025-05-05T18:00:00+09:00",
        "current_period": "2H",
        "elapsed_time": "67'",
        "home_team": {
          "team_id": "TEAM001",
          "team_name": "전북 현대",
          "team_logo_url": "https://...",
          "country": "대한민국"
        },
        "away_team": {
          "team_id": "TEAM002",
          "team_name": "울산 현대",
          "team_logo_url": "https://...",
          "country": "대한민국"
        },
        "score": {
          "home_score": 2,
          "away_score": 1,
          "period_scores": [
            {"period": "1H", "home": 1, "away": 0},
            {"period": "2H", "home": 1, "away": 1}
          ]
        },
        "odds": {
          "domestic_odds": {
            "home_odds": 1.85,
            "draw_odds": 3.20,
            "away_odds": 4.50
          },
          "overseas_odds": {
            "home_odds": 1.82,
            "draw_odds": 3.25,
            "away_odds": 4.60
          }
        },
        "has_expert_pick": true,
        "expert_count": 3,
        "admin_comment": "주목 경기! 양 팀 최근 5경기 전승",
        "is_notification_on": false
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_count": 87
    }
  }
}
```

### 6.2 경기 알림 설정

```
POST /api/v1/matches/{match_id}/notifications
```

**Request Body**:

```json
{
  "notification_types": ["START_BEFORE_10", "START", "SCORE", "END"]
}
```

**Response**:

```json
{
  "success": true,
  "message": "알림이 설정되었습니다."
}
```

### 6.3 경기 알림 해제

```
DELETE /api/v1/matches/{match_id}/notifications
```

---

## 7. 관리자 기능

### 7.1 경기 코멘트 관리

| 기능 | 설명 |
|-----|------|
| 코멘트 등록 | 특정 경기에 운영자 코멘트 추가 |
| 코멘트 수정 | 등록된 코멘트 수정 |
| 코멘트 삭제 | 코멘트 삭제 |

### 7.2 Admin API 엔드포인트

| 메서드 | 엔드포인트 | 설명 |
|-------|-----------|------|
| POST | /admin/api/v1/matches/{id}/comment | 경기 코멘트 등록 |
| PUT | /admin/api/v1/matches/{id}/comment | 경기 코멘트 수정 |
| DELETE | /admin/api/v1/matches/{id}/comment | 경기 코멘트 삭제 |

---

## 8. 참고사항

### 8.1 확인 필요 사항

- [ ] 실시간 업데이트 방식 (WebSocket vs Polling) 결정
- [ ] 배당 데이터 제공 업체 확인
- [ ] 종목별 상세 상태 코드 정의

### 8.2 관련 문서

- 라이브 메인: `LIVE_MAIN.md`
- 경기 상세: `MATCH_DETAIL.md`
- 베팅 탭: `BETTING_TABS.md`
