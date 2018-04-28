<%-- 
    Document   : header
    Created on : Apr 19, 2018, 8:20:46 PM
    Author     : John
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav>
   
    <%
    Cookie[] cookies = request.getCookies();
    String cookieName = "userId";
    String cookieValue = null;
    for (Cookie cookie : cookies) {
        if (cookieName.equals(cookie.getName())) {
            cookieValue = cookie.getValue();
        }
    }

    %>
    <ul class="navlist">
        <li><a class="active" href="index.jsp">MemeSeen</a></li>
        <li><a href="index.jsp?sort=new">New</a></li>
        <li><a href="index.jsp?sort=popular">Popular</a></li>
        <%if (cookieValue == null) {%>
        <li class="pull-right"><a href="login.jsp">Login</a></li>
        <%} else {%>
        <li class="pull-right"><a href="post.jsp">Create Post</a></li>
        <li class="pull-right"><a href="logout.jsp">Logout</a></li>
        <%}%>
    </ul>
</nav>