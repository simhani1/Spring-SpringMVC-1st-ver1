<%--
  Created by IntelliJ IDEA.
  User: simjonghan
  Date: 2023/02/06
  Time: 2:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>  <%--jsp 라는 것을 명시해주는 라인이므로 꼭 필요--%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="/jsp/members/save.jsp" method="post">
        username: <input type="text" name="username" />
        age: <input type="text" name="age" />
        <button type="submit">전송</button>
    </form>
</body>
</html>
