<%-- 
    Document   : logout
    Created on : Apr 20, 2018, 3:39:14 AM
    Author     : John
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
        Cookie deleteCookie = new Cookie("userId", null);
        deleteCookie.setMaxAge(0);
        deleteCookie.setPath("/");
        response.addCookie(deleteCookie);

        response.sendRedirect("login.jsp");
        %>
    </body>
</html>
