# BankScope

AI 기반 통합 스마트 뱅킹 플랫폼. 고객 맞춤 금융 상품 추천, 지능형 창구 자동 배정, Gemini 챗봇 상담을 하나의 웹 시스템으로 제공한다.

---

## 기술 스택

| 영역 | 기술 |
|---|---|
| Frontend | React, Vite |
| Backend | Spring Boot, MyBatis, MySQL |
| AI Server | Python, FastAPI, Scikit-learn, SHAP, Google Gemini API |

---

## 실행 전 준비사항

- MySQL 8.0+
- Java 17+
- Node.js 18+
- Python 3.10+

---

## 실행 방법

### 1. DB 설정

MySQL에서 아래 SQL 파일을 **순서대로** 실행한다.

```
1. AI_Server/schema.sql       ← 테이블 생성
2. AI_Server/bank_dump.sql    ← 샘플 데이터 복원
```

### 2. Backend (`bank-backend`)

`application.properties.example`을 복사하여 `application.properties`로 이름을 바꾸고, 본인 환경에 맞게 값을 채운다.

```bash
cp bank-backend/src/main/resources/application.properties.example \
   bank-backend/src/main/resources/application.properties
```

주요 수정 항목:
- `spring.datasource.password` — MySQL 비밀번호
- `spring.mail.username` / `spring.mail.password` — Gmail 계정 및 앱 비밀번호 (이메일 인증 기능 사용 시)
- `solapi.api.key` / `solapi.api.secret` — Solapi API 키 (SMS 기능 사용 시)

이후 Spring Boot 서버를 실행한다.

```bash
./mvnw spring-boot:run
```

기본 포트: `http://localhost:8080`

### 3. AI Server (`AI_Server`)

`.env.example`을 복사하여 `.env`로 이름을 바꾸고, 본인 환경에 맞게 값을 채운다.

```bash
cp AI_Server/.env.example AI_Server/.env
```

주요 수정 항목:
- `GEMINI_API_KEY` — Google AI Studio에서 발급 (https://aistudio.google.com)
- `DB_PASSWORD` — MySQL 비밀번호

패키지를 설치한다 (최초 1회).

```bash
pip install -r requirements.txt
```

가상 환경을 활성화한다.

**Windows:**
```bash
.venv\Scripts\activate
```

**Mac/Linux:**
```bash
source .venv/bin/activate
```

> 터미널 입력창 앞에 `(.venv)`가 표시되면 정상이다.

서버를 실행한다.

```bash
uvicorn main:app --reload --port 8000
```

기본 포트: `http://localhost:8000`

### 4. Frontend (`bank-frontend`)

```bash
cd bank-frontend
npm install
npm run dev
```

기본 포트: `http://localhost:5173`

---

## 테스트 계정

샘플 데이터에 포함된 테스트 계정 목록은 `AI_Server/user.txt`를 참고한다.

| 구분 | 계정 예시 | 비밀번호 |
|---|---|---|
| 고객 (개인) | `test01@test.com` ~ `test15@test.com` | `Test1234!` |
| 고객 (법인) | `corp01@test.com` ~ `corp06@test.com` | `Test1234!` |
| 행원 | `banker@naver.com` 외 4명 (`AI_Server/bank_dump.sql` 참고) | `1234` |
| 관리자 | `admin@admin.com` | `1234` |

> 전체 고객 계정의 상세 정보(이름, 주민번호, 전화번호 등)는 `AI_Server/user.txt`를 참고한다.

---

## AI 모델 재학습 (선택)

`bank_model.pkl`이 이미 포함되어 있으므로 별도 학습 없이 바로 실행 가능하다.
모델을 직접 재학습하려면 가상 환경을 활성화한 뒤 AI Server에서 아래 스크립트를 실행한다.

```bash
python RF.py
```

> 학습 완료 시 `bank_model.pkl`이 갱신된다. 정확도 85% 미만이면 저장되지 않는다.
