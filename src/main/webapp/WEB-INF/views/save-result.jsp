<%@ page import="hello.servlet.domain.member.Member" %><%--
  Created by IntelliJ IDEA.
  User: simjonghan
  Date: 2023/02/06
  Time: 3:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    성공
    <ul>
<%--    캐스팅을 해야 하고 코드가 너무 복잡하다.
        <li>id=<%=((Member) request.getAttribute("member")).getId()%></li>
        <li>username<%=((Member) request.getAttribute("member")).getUsername()%></li>
        <li>age<%=((Member) request.getAttribute("member")).getAge()%></li>
--%>
        <%--    getProperty 방법으로 알아서 getXXX를 호출해서 값을 대입해준다.   --%>
        <li>id=${member.id}</li>
        <li>username=${member.username}</li>
        <li>age=${member.age}</li>
    </ul>
    <a href="/index.html">메인</a>
</body>
</html>
