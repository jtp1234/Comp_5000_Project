<%-- 
    Document   : comment
    Created on : Apr 27, 2018, 5:33:54 PM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comment</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection connection = null;
        try {
            String dbURL = "jdbc:mysql://localhost:3306/memeseen_database";
            String username = "root";
            String password = "admin";
            connection = DriverManager.getConnection(dbURL, username, password);
        } catch(SQLException e) {
            for (Throwable t : e) {
                t.printStackTrace();
            }
        }
        Cookie[] cookies = request.getCookies();
        String cookieName = "userId";
        String cookieValue = null;
        for (Cookie cookie : cookies) {
            if (cookieName.equals(cookie.getName())) {
                cookieValue = cookie.getValue();
            }
        }
        
        if (cookieValue == null) {
            response.sendRedirect("login.jsp");
        } else {
        
            String userQuery = "SELECT * FROM users WHERE user_id = \"" + cookieValue + "\"";
            ResultSet userResult = connection.createStatement().executeQuery(userQuery);

            String createUser = "INSERT INTO comments (post_id, author_id, created, comment) VALUES (" + request.getParameter("postId") + ", " + cookieValue + ", \'" + new Timestamp(System.currentTimeMillis()) + "\', \"" + request.getParameter("comment") + "\");"; 
                                connection.createStatement().executeUpdate(createUser);

            response.sendRedirect("index.jsp");
        }
        %>
    </body>
</html>
