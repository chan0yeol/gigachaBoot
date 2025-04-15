# 📌 그룹웨어 기반의 전자결재 및 예약관리 시스템
### MVC프로젝트
  https://github.com/gigachanyeol/gigacha
## 📝 프로젝트 개요

사내에서 사용할 수 있는 웹 시스템을 개발하여 구성원들의 결재 업무를 전자화하고, 예약 관리 및 보고서 작성 기능을 통합함으로써 업무 효율성을 향상시킬 수 있는 **확장 가능한 그룹웨어 플랫폼**을 구현하였습니다.

- **주요 목적**: 개인정보를 보호하면서도 간편하게 전자결재를 사용할 수 있는 시스템 제공
- **기술 목표**:
  - Spring Framework 기반 서버로 REST API 구축
  - 클라이언트에서 비동기 처리로 빠른 응답 제공
  - Jenkins + Docker + GitHub 기반의 CI/CD 자동화 파이프라인 구축

---

## 👥 개발 기간 및 인원

| 항목 | 내용 |
| --- | --- |
| 개발 기간 | 2025.02.12 ~ 2025.04.04 (8주) |
| 팀원 수 | 4명 |

### 개발 일정

| 기간 | 작업 내용 |
| ---- | ---------- |
| 2.12 ~ 2.26 | 개발 준비 (요구사항 분석 / 설계) |
| 2.26 ~ 3.02 | 모듈화 및 헤더/사이드바 UI 작업 |
| 3.03 ~ 3.24 | 기능 및 서비스 구현, UI/UX 개발 |
| 3.24 ~ 3.29 | 단위 테스트 |
| 3.30 ~ 4.03 | 통합 테스트 및 최종 배포 |

---

## ⚙ 개발 환경

| 항목 | 내용 |
| ---- | ---- |
| Language | Java, HTML, JavaScript, CSS |
| Framework | Spring Framework 5.x |
| ORM | MyBatis 3.x |
| Build | Maven |
| Test | JUnit4 |
| Database | Oracle 19c/21c ATP |
| WAS | Tomcat 9.x |
| 형상관리 | GitHub |
| CI/CD | Git Webhook + Jenkins + Docker |
| OS | Windows 11, Ubuntu 22.04 |
| Tools | Eclipse, VSCode, DBeaver, ERDCloud, Postman |

---

## 🧱 시스템 아키텍처

![Image](https://github.com/user-attachments/assets/9f94cba4-89b0-40d0-ac77-4d71c33138f5)

- Spring MVC 구조 기반: `Interceptor`, `DispatcherServlet`, `@Service`, `@Repository` 활용
- JSP + REST API 기반 클라이언트 구성
- WebSocket으로 실시간 알림 처리
- Oracle Cloud ATP DB + MyBatis 연동
- GitHub → Jenkins → Docker 자동 배포 파이프라인

---

## 📚 주요 라이브러리 및 API

- Spring WebSocket, AJAX, Handlebars.js, CKEditor, FullCalendar
- jsPDF, html2canvas, DataTables, Chart.js, SheetJS
- SignaturePad, DatePicker, SweetAlert2, jQuery, Bootstrap 5
- Gson, Lombok, Commons IO, JSTL

---

## 🗂 논리 ERD (전자결재 시스템)

Oracle ATP 기반의 테이블 구성 ()

![Image](https://github.com/user-attachments/assets/eea0fff1-ce9c-49d1-b79f-e772f4b5018e)

---
## 🗂 물리 ERD (전자결재 시스템)

물리 ERD는 담당 ERD만 첨부하였습니다.

![Image](https://github.com/user-attachments/assets/8669fb63-a9bb-4398-9351-adcb9e391fdc)

---

## 🧑‍💻 프로젝트 담당 역할

### 📌 데이터베이스 설계 및 작성

- Oracle Cloud ATP에서 DB 스키마 설계 및 쿼리 최적화
- ERD 기반 공용 테이블 작성 및 관계 설정

### 📌 CI/CD 구축 및 배포

- 스마트폰 리눅스 환경에 Jenkins 설치
- GitHub Webhook + Maven 빌드 + Docker 이미지 생성
- Oracle Cloud 인스턴스에 자동 배포

### 📌 CI/CD 아키텍처

![Image](https://github.com/user-attachments/assets/3370f976-6ff1-4825-a6ac-594624449628)

1. GitHub Commit & Push
2. Jenkins Webhook 트리거
3. Maven 빌드 → Docker 이미지 생성
4. DockerHub Push → 서버 Pull & 컨테이너 재기동

---

## 🧩 구현 기능 상세

### 📂 공통 모듈화

- CKEditor, jsTree, DataTables, SweetAlert2 등 JS 라이브러리 공통 관리
- Header, Sidebar 컴포넌트 UI 통일

### 📑 전자결재 시스템

- 에디터 기반 문서 양식 작성 및 수정
- 결재선 자동완성 및 설정
- 문서 승인 / 반려 / 긴급 결재 처리
- WebSocket 실시간 알림 (긴급결재, 승인, 반려)
- 동적 쿼리 처리 (MyBatis Dynamic SQL)
- Fetch API 기반 비동기 처리

---

## 🔔 WebSocket 실시간 알림

**이벤트 흐름도**

1. 클라이언트에서 문서 승인/반려 등 이벤트 발생
2. 서버 처리 → `HttpSession ↔ WebSocketSession` 매핑
3. 알림 대상 사용자에게 메시지 전송
4. 클라이언트 토스트 팝업으로 실시간 반영

![Image](https://github.com/user-attachments/assets/a4c80afe-1b79-448a-a93a-66b371611163)

**설정 예시 (XML 기반)**

```xml
<websocket:handlers>
  <websocket:mapping path="/ws/notification.do" handler="websocketHandler" />
  <websocket:handshake-interceptors>
    <bean class="HttpSessionHandshakeInterceptor"/>
  </websocket:handshake-interceptors>
</websocket:handlers>
```
