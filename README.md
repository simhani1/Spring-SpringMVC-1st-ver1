<div align="center">
    <h2>스프링MVC 1편</h2>
</div>

#### http 요청 로그 남기기
- `logging.level.org.apache.coyote.http11=debug` application.properties에 추가
- 단 성능저하를 일으킬 수 있으므로 운영 서버에는 적용시키지 않는 것을 추천

#### HttpServletRequest 개요
- HTTP 요청 메시지를 대신해서 파싱해준다.
- 그 결과를 `HttpServletRequest`객체에 담아서 제공해준다.

- start line
  - HTTP 메서드
  - URL
  - 쿼리 스트링
  - 스키마, 프로토콜
- 헤더
  - 헤더 조회
- 바디
  - form 파라미터 형식 조회
  - mwssage body 데이터 직접 조회

- 임시 저장소 기능
  - 저장: `request.setAttribute(name, value)`
  - 조회: `request.getAttribute(name)`
- 세션 관리 기능
  - `request.getSession(create: true)`

#### HTTP 요청 데이터 개요
- GET : 쿼리 파라미터
- POST : HTML Form
- HTTP message body : 데이터 형식은 주로 JSON을 사용

- 복수 파라미터에서 단일 파라미터 조회
  - `username=sim&username=kim` 인 경우 `request.getParameter()`는 하나의 파라미터만 조회가 가능하므로 `request.getParameterValues()` 를 사용해야 한다.

#### POST HTML Form
- application/x-www-form-urlencoded 형식은 쿼리 파라미터 형식과 동일하다.
- 따라서 쿼리 파리미터 조회 메서드를 그대로 사용하면 된다.
- 즉 `request.getParameter()` 메서드는 GET URL 쿼리 파라미터 형식, POST HTML Form 형식 둘 다 지원하는 것이다.

[img.png](img/img.png)

