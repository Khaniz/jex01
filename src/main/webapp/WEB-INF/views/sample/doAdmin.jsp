<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>do Admin</h1>

<h2><security:authentication property="principal"></security:authentication></h2>
<h2><security:authentication property="principal.mname"></security:authentication></h2>
<h2><security:authentication property="principal.mid"></security:authentication></h2>
<h2><security:authentication property="principal.mpw"></security:authentication></h2>


</body>
</html>
