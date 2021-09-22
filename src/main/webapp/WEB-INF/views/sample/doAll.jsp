<%--
  Created by IntelliJ IDEA.
  User: khan
  Date: 2021/09/10
  Time: 11:48 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>여기는 두 올 입니닷!</h1>

<security:authorize access="isAnonymous()">
    <a href="/customLogin">Login plz.........</a>
</security:authorize>

<security:authorize access="isAuthenticated()">
    <a href="/logout">go Home man!</a>
</security:authorize>

</body>
</html>
