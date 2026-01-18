# 댓글 시스템

## 1. 개요

댓글 시스템은 커뮤니티 게시글에 대한 사용자 의견을 작성하고, 대댓글(답글) 및 좋아요 기능을 제공하는 시스템입니다.

- **원본 PDF 참조**: 55페이지

---

## 2. 화면 구성

### 2.1 댓글 영역 헤더

| 요소 | 설명 |
|------|------|
| 댓글 수 표시 | "댓글 N개" 형식으로 표시 |
| 정렬 옵션 | 최신순 / 인기순 [확인 필요] |

### 2.2 댓글 리스트

| 요소 | 설명 |
|------|------|
| 프로필 이미지 | 댓글 작성자 프로필 |
| 닉네임 | 댓글 작성자 닉네임 |
| 작성 시간 | 상대적 시간 표시 (예: 1시간 전) |
| 댓글 내용 | 댓글 텍스트 |
| 좋아요 버튼 | 하트 아이콘 + 좋아요 수 |
| 답글 버튼 | "답글" 텍스트 버튼 |
| 더보기 메뉴 | 수정/삭제(본인), 신고(타인) |

### 2.3 대댓글 (답글)

| 요소 | 설명 |
|------|------|
| 들여쓰기 | 부모 댓글 대비 들여쓰기 표시 |
| 답글 표시 | "@닉네임" 형식으로 대상 표시 |
| 기타 요소 | 일반 댓글과 동일 |

### 2.4 댓글 입력 영역

| 요소 | 설명 |
|------|------|
| 입력 필드 | 하단 고정, 텍스트 입력 영역 |
| 글자 수 표시 | 현재 입력 글자수 / 최대 글자수 |
| 등록 버튼 | 댓글 등록 실행 |
| 답글 모드 표시 | 답글 작성 시 대상 닉네임 표시 |

---

## 3. 기능 상세

### 3.1 댓글 조회

1. 게시글 상세 진입 시 댓글 리스트 로드
2. 부모 댓글 기준으로 그룹화
3. 대댓글은 부모 댓글 하위에 들여쓰기로 표시
4. 추가 댓글은 스크롤 또는 "더보기" 버튼으로 로드

### 3.2 댓글 작성

1. 하단 입력 필드에 댓글 내용 입력
2. 최대 1,000자 입력 가능
3. 등록 버튼 탭 시 댓글 등록 API 호출
4. 등록 성공 시 리스트에 새 댓글 추가
5. 로그인 필요 (비로그인 시 로그인 유도)

### 3.3 대댓글 (답글) 작성

1. 댓글의 "답글" 버튼 탭
2. 입력 필드에 답글 모드 활성화 표시 (예: "@닉네임에게 답글")
3. 답글 내용 입력 후 등록
4. 부모 댓글 하위에 대댓글로 등록

### 3.4 댓글 좋아요

1. 좋아요 버튼 탭 시 좋아요 토글
2. 이미 좋아요 상태면 좋아요 취소
3. 좋아요 수 실시간 반영

### 3.5 댓글 수정

1. 본인 댓글의 더보기 → 수정 선택
2. 입력 필드에 기존 내용 표시
3. 수정 후 등록
4. 수정 표시 (예: "(수정됨)" 태그)

### 3.6 댓글 삭제

1. 본인 댓글의 더보기 → 삭제 선택
2. 삭제 확인 팝업 표시
3. 확인 시 삭제 처리
4. 대댓글이 있는 경우 "삭제된 댓글입니다" 표시 [확인 필요]

### 3.7 댓글 신고

**✅ 확정 정책 (2026-01-06)**: 게시글 댓글 신고가 **5회 누적**될 경우 해당 **댓글 삭제** 처리

1. 타인 댓글의 더보기 → 신고 선택
2. 신고 사유 선택
3. 신고 접수 완료 메시지
4. **5회 신고 누적 시 자동 삭제**

> **게시글 자체 신고**: 게시글에 대한 신고는 게시글이 아닌 **유저 프로필 진입 후 유저 신고** 방식으로 진행

---

## 4. 데이터 요구사항

### 4.1 댓글

| 필드명 | 타입 | 필수 | 설명 |
|--------|------|------|------|
| commentId | String | Y | 댓글 고유 ID |
| postId | String | Y | 게시글 ID |
| parentId | String | N | 부모 댓글 ID (대댓글인 경우) |
| content | String | Y | 댓글 내용 |
| authorId | String | Y | 작성자 ID |
| authorNickname | String | Y | 작성자 닉네임 |
| authorProfileUrl | String | N | 작성자 프로필 이미지 |
| createdAt | DateTime | Y | 작성 일시 |
| updatedAt | DateTime | N | 수정 일시 |
| likeCount | int | Y | 좋아요 수 |
| isLiked | boolean | Y | 현재 사용자 좋아요 여부 |
| isAuthor | boolean | Y | 현재 사용자가 작성자인지 여부 |
| isDeleted | boolean | Y | 삭제 여부 |
| replyToNickname | String | N | 답글 대상 닉네임 |
| replies | List<Comment> | N | 대댓글 리스트 (1depth만) |

### 4.2 댓글 작성 요청

| 필드명 | 타입 | 필수 | 설명 |
|--------|------|------|------|
| postId | String | Y | 게시글 ID |
| parentId | String | N | 부모 댓글 ID (대댓글인 경우) |
| content | String | Y | 댓글 내용 (최대 1,000자) |

---

## 5. API 요구사항

### 5.1 댓글 리스트 조회

```
GET /api/community/posts/{postId}/comments
```

**Query Parameters**:
| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| page | int | N | 페이지 번호 (default: 1) |
| limit | int | N | 페이지당 개수 (default: 20) |

**Response**:
```json
{
  "success": true,
  "data": {
    "totalCount": 25,
    "comments": [
      {
        "commentId": "cmt_001",
        "postId": "post_001",
        "parentId": null,
        "content": "댓글 내용입니다",
        "authorId": "user_001",
        "authorNickname": "닉네임",
        "authorProfileUrl": "https://...",
        "createdAt": "2025-12-22T10:00:00Z",
        "updatedAt": null,
        "likeCount": 5,
        "isLiked": false,
        "isAuthor": false,
        "isDeleted": false,
        "replyToNickname": null,
        "replies": [
          {
            "commentId": "cmt_002",
            "postId": "post_001",
            "parentId": "cmt_001",
            "content": "@닉네임 대댓글입니다",
            "authorId": "user_002",
            "authorNickname": "다른닉네임",
            "authorProfileUrl": "https://...",
            "createdAt": "2025-12-22T11:00:00Z",
            "updatedAt": null,
            "likeCount": 2,
            "isLiked": true,
            "isAuthor": false,
            "isDeleted": false,
            "replyToNickname": "닉네임",
            "replies": []
          }
        ]
      }
    ],
    "hasNext": true
  }
}
```

### 5.2 댓글 등록

```
POST /api/community/posts/{postId}/comments
```

**Request Body**:
```json
{
  "parentId": null,
  "content": "댓글 내용입니다"
}
```

**Response**:
```json
{
  "success": true,
  "data": {
    "commentId": "cmt_003",
    "postId": "post_001",
    "parentId": null,
    "content": "댓글 내용입니다",
    "authorId": "user_001",
    "authorNickname": "닉네임",
    "authorProfileUrl": "https://...",
    "createdAt": "2025-12-22T12:00:00Z",
    "likeCount": 0,
    "isLiked": false,
    "isAuthor": true,
    "isDeleted": false
  }
}
```

### 5.3 댓글 수정

```
PUT /api/community/comments/{commentId}
```

**Request Body**:
```json
{
  "content": "수정된 댓글 내용입니다"
}
```

### 5.4 댓글 삭제

```
DELETE /api/community/comments/{commentId}
```

### 5.5 댓글 좋아요 토글

```
POST /api/community/comments/{commentId}/like
```

**Response**:
```json
{
  "success": true,
  "data": {
    "isLiked": true,
    "likeCount": 6
  }
}
```

### 5.6 댓글 신고

```
POST /api/community/comments/{commentId}/report
```

**Request Body**:
```json
{
  "reasonCode": "ABUSE",
  "reasonDetail": "욕설이 포함되어 있습니다"
}
```

---

## 6. 관리자 기능

### 6.1 댓글 관리

| 기능 | 설명 |
|------|------|
| 댓글 목록 조회 | 전체 댓글 리스트 (필터/검색) |
| 댓글 상세 조회 | 댓글 내용 및 정보 확인 |
| 댓글 삭제 | 부적절한 댓글 삭제 |
| 댓글 숨김 | 댓글 비공개 처리 |

### 6.2 신고 관리

| 기능 | 설명 |
|------|------|
| 신고 목록 조회 | 신고된 댓글 리스트 |
| 신고 처리 | 경고, 삭제, 무시 처리 |
| 사용자 제재 | 반복 신고 사용자 제재 조치 |

### 6.3 Admin API

```
# 댓글 관리
GET    /api/admin/community/comments
GET    /api/admin/community/comments/{commentId}
DELETE /api/admin/community/comments/{commentId}
PUT    /api/admin/community/comments/{commentId}/hide

# 신고 관리
GET    /api/admin/community/comment-reports
PUT    /api/admin/community/comment-reports/{reportId}/process
```

---

## 7. 비즈니스 규칙

### 7.1 입력 제한

| 항목 | 제한 |
|------|------|
| 댓글 내용 | 최대 1,000자 |
| 대댓글 깊이 | 1단계 (대댓글의 대댓글 불가) |

### 7.2 삭제 정책

| 상황 | 처리 방식 |
|------|----------|
| 대댓글 없는 댓글 삭제 | 완전 삭제 (리스트에서 제거) |
| 대댓글 있는 댓글 삭제 | "삭제된 댓글입니다" 표시 |
| 대댓글 삭제 | 완전 삭제 |

### 7.3 작성 제한

- 로그인 사용자만 댓글 작성 가능
- 차단된 사용자의 댓글은 표시되지 않음
- 동일 내용 연속 등록 방지 [확인 필요]

---

## 8. 신고 사유 코드

| 코드 | 설명 |
|------|------|
| SPAM | 스팸/광고 |
| ABUSE | 욕설/비방 |
| ILLEGAL | 불법 정보 |
| ADULT | 음란물 |
| FRAUD | 사기/허위정보 |
| OTHER | 기타 |

---

## 9. UI/UX 고려사항

- 댓글 로딩 시 스켈레톤 UI 표시
- 새 댓글 등록 시 리스트 상단에 추가 (스크롤 이동 옵션)
- 대댓글 영역은 접힘/펼침 가능 (댓글 많은 경우)
- 좋아요 버튼 탭 시 즉각적인 UI 피드백 (optimistic update)
- 긴 댓글은 "더보기"로 펼침 처리
- 삭제된 댓글은 회색 배경으로 구분
- 답글 모드 진입 시 취소 버튼 제공
- 댓글 입력 시 키보드가 입력 영역을 가리지 않도록 조정
