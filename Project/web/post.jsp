<%-- 
    Document   : post
    Created on : Apr 27, 2018, 6:11:35 PM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Post</title>
        <link rel="stylesheet" href="styles.css">
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
            if(request.getMethod().equals("POST")) {
                String userQuery = "SELECT * FROM users WHERE user_id = \"" + cookieValue + "\"";
                ResultSet userResult = connection.createStatement().executeQuery(userQuery);

                String createPost = "INSERT INTO posts (author_id, created, post_title, post_description, image_url, votes) VALUES (" + cookieValue + ", \'" + new Timestamp(System.currentTimeMillis()) + "\', \"" + request.getParameter("title") + "\", \"" + request.getParameter("description") + "\", \"" + request.getParameter("imageURL") + "\", 0);"; 
                                    connection.createStatement().executeUpdate(createPost);

                response.sendRedirect("index.jsp");
            } else {              
                %>
                <div class="post xymargins container">
                    <h1>Create Post</h1>
                    <form method="POST">
                        <input type="hidden" name="userId" value="<%out.print(cookieValue);%>"/>
                        Title: <input type="text" name="title"/><br>
                        URL of Image: <input type="text" name="imageURL"/><br>
                        <textarea name="description"></textarea><br>
                        <input type="submit"/>
                    </form>
                </div>
                <%
            }
        }
        %>
    </body>
</html>
