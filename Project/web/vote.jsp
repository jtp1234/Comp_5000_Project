<%-- 
    Document   : vote
    Created on : Apr 27, 2018, 6:57:00 PM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vote</title>
    </head>
    <body>
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
        
            String postQuery = "SELECT * FROM posts WHERE post_id = " + request.getParameter("postId") + ";";
            ResultSet postResult = connection.createStatement().executeQuery(postQuery);
            postResult.next();
            int curVotes = postResult.getInt("votes");
            
            if (request.getParameter("voteUp").equals("true")) {
                curVotes++;
            } else {
                curVotes--;
            }

            String votePost = "Update posts SET votes = " + curVotes + " WHERE post_id = " + request.getParameter("postId") + ";"; 
            connection.createStatement().executeUpdate(votePost);

            response.sendRedirect("index.jsp");
        }
        %>
    </body>
</html>
