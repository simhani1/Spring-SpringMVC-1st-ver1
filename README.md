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
![img.png](img/img_1.png)

- POST 방식만 가능하다.
- 단 히든 필드를 스프링이 조회해서 PUT, PATCH 같은 요청들을 마치 동작되는 것처럼 보여주기도 한다.
  - 실은 POST 방식으로 동작하는 것이다.

#### JSON 바디
- JSON 결과를 파싱해서 사용할 수 있는 자바 객체로 변환하려면 Jackson, Gson같은 변환 라이브러리를 추가해서 사용해야 한다.
- 스프링 부트로 Spring MVC를 선택하면 기본으로 Jackson을 제공한다. 

#### HttpServletResponse 기본 사용법
- HTTP 응답코드 지정
- 헤더 생성
- 바디 생성

- 편의 기능 제공
- content-type, 쿠키, Redirect

- response 헤더에 편의 메서드를 사용하여 여러 값들을 지정할 수 있다.
- 쿠키는 쿠키의 명칭과 값, 그리고 쿠키의 유지시간을 설정 할 수 있다.
```java
    private void cookie(HttpServletResponse response) {
//        Set-Cookie: myCookie=good; Max-Age=600;
//        response.setHeader("Set-Cookie", "myCookie=good; Max-Age=600");
        Cookie cookie = new Cookie("myCookie", "good");
        cookie.setMaxAge(600); // 쿠키 유지시간 600초
        response.addCookie(cookie);
    }
```

- 리다이렉트 정보도 저장할 수 있다.
  - 이때 웹 브라우저는 캐시에 있는 정보를 사용하기 때문에 같은 요청을 보낸 경우 변동 사항이 없으므로 304 코드를 반환한다.
  ![img.png](img/img_2.png)

#### HTTP 응답 데이터 - 단순 텍스트, HTML
- 단순 텍스트 응답
  - `writer.println("ok");`
- HTML 응답
  - html을 반환할 때는 content-type을 `text/html`로 지정해야 한다.
- HTTP API, Message Body JSON 응답
  - ObjectMapper를 사용하여 객체를 JSON 형태로 변환하여 반환시킬 수 있다.
  ```java
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Content-Type : application/json
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");

        HelloData helloData = new HelloData();
        helloData.setUsername("sim");
        helloData.setAge(26);

        // {"username" : "sim", "age" : 26}
        String result = objectMapper.writeValueAsString(helloData);
        response.getWriter().write(result);

    }
  ```

#### 서블릿과 자바 코드만으로 HTML 만들기
- 서블릿 덕분에 동적으로 원하는 HTML을 만들 수 있었다. 
- 하지만 HTML을 자바로 작성하는 것은 복잡하고 비효율적이다.
```java
w.write("<html>\n" +
        "<head>\n" +
        " <meta charset=\"UTF-8\">\n" + "</head>\n" +
        "<body>\n" +
        "성공\n" +
        "<ul>\n" +
        "    <li>id=" + member.getId() + "</li>\n" +
        "    <li>username=" + member.getUsername() + "</li>\n" +
        " <li>age=" + member.getAge() + "</li>\n" + "</ul>\n" +
        "<a href=\"/index.html\">메인</a>\n" + "</body>\n" +
        "</html>");
```

- 따라서 HMTL문서에 동적으로 변경해야 하는 부분에 자바 코드를 넣을 수 있는 방법이 생겨났다.
- 이를 템플릿 엔진이라고 하고 그 예로 JSP, Thymeleaf, Freemarker, Velocity 등이 있다.

#### JSP 사용
- 의존성 추가
```groovy
//JSP 추가 시작
implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
implementation 'javax.servlet:jstl' 
//JSP 추가 끝
```

- `<%@ page contentType="text/html;charset=UTF-8" language="java" %>`
  - JSP 문서라는 것을 나타내는 뜻
  - 무조건 이렇게 시작을 한다.
- 자바 코드를 그대로 사용할 수 있다.
  - `<%@ page import="hello.servlet.domain.member.MemberRepository" %>` import문
  - `<% ~~ %>` 자바 코드 입력 부분
  - `<%= ~~ %>` 자바 코드 출력 부분

#### 서블릿과 JSP의 한계
- 서블릿을 사용할 때는 HTML코드가 자바 코드에 섞여 지저분하고 복잡하다.
- JSP를 사용하면 HTML파일을 따로 분리시킬 수 있고 필요한 부분에 대해 자바 코드를 적용했다.
- 하지만 JSP 파일에 비즈니스 로직과 HTML이 공존한다.
- 비즈니스 로직이 노출되고 나중에는 코드의 분량이 엄청나게 증가되므로 관리하기가 어렵다.
- 이런 단점을 해결하고자 MVC 패턴이 등장한다.

#### MVC 패턴의 등장
- 비즈니스 로직은 서블릿 처럼 다른 곳에서 처리하고, JSP는 목적에 맞게 View를 그리는 일에 집중하도록 하자.

- 변경의 라이프 사이클
  - 비즈니스 로직과 UI 사이의 변경의 라이프 사이클은 서로 다르다는 점을 인식해야 한다.
  - UI와 비즈니스 로직의 수정하는 일은 각각 다르게 발생할 가능성이 높다.
  - 이렇게 사이클이 다른 두 부분을 하나의 코드로 관리하는 것은 유지보수하기 좋지 않다.

- 기능 특화
  - JSP같은 뷰 템플릿은 화면을 렌더링 하는데 최적화 되어있기 때문에 이 부분의 업무만 담당하는 것이 좋다.
  
- Model View Controller
- 컨트롤러
  - HHTP 요청을 받아 파라미터를 검증하고 비즈니스 로직을 실행한다.
  - 그리고 뷰에 전달할 결과 데이터를 조회해서 모델에 담는다.
- 모델
  - 뷰에 출력할 데이터를 담아둔다.
  - 뷰가 필요한 데이터를 모두 모델에 담아서 전달해주는 덕분에 뷰는 화며을 렌더링 하는 일에 집중할 수 있다.
- 뷰
  - 모델에 담겨있는 데이터를 사용해서 화면을 그리는 일에 집중한다.

- `dispatcher.forward()`: 다른 서블릿이나 JSP로 이동할 수 있는 기능, 서버 내부에서 다시 호출이 발생한다.

- redirect vs forward
  - 리다이렉트는 실제 클라이언트에 응답이 나갔다가, 클라이언트가 redirect 경로로 다시 요청한다.
  - 따라서 클라이언트가 인지할 수 있고 ,URL 경로도 실제로 변경된다.
  - 포워드는 서버 내부에서 일어나는 호출이기 때문에 클라이언트가 전혀 인지할 수 없다.
  - WEB-INF 아래에 있는 자원들은 외부에서 호출이 불가능하다. 이는 WAS에서의 규칙이다.

- form의 action에서의 상대경로
  - 절대경로: 해당 경로 그대로 호출
  - 상대경로: `현재 URL이 속한 계층 경로 + 상대경로`로 호출된다.

- `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>` JSP 내부에서 `<C:forEach>`를 사용하기 위해서 라이브러리가 필요하다.

