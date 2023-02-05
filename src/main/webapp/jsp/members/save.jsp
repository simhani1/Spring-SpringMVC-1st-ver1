<%@ page import="hello.servlet.domain.member.Member" %>
<%@ page import="hello.servlet.domain.member.MemberRepository" %>
<%--
  Created by IntelliJ IDEA.
  User: simjonghan
  Date: 2023/02/06
  Time: 2:13 AM
  To change this template use File | Settings | File Templates.
--%>

<%--자바 코드를 넣는 부분--%>
<%
    // request, response 사용 가능하도록 지원이 된다.
    MemberRepository memberRepository = MemberRepository.getInstance();
    System.out.println("MemberSaveServlet.service");
    String username = request.getParameter("username");
    int age = Integer.parseInt(request.getParameter("age"));

    Member member = new Member(username, age);
    memberRepository.save(member);
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    성공
    <ul>
        <li>id=<%=member.getId()%></li>
        <li>username<%=member.getUsername()%></li>
        <li>age<%=member.getAge()%></li>
    </ul>
    <a href="/index.html">메인</a>
</body>
</html>
