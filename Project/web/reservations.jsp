<%-- 
    Document   : reservations
    Created on : Apr 20, 2018, 3:48:40 AM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Reservations</title>
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
            String dbURL = "jdbc:mysql://localhost:3306/library_catalog";
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
        }
        
        String reservationQuery = "SELECT * FROM reservations WHERE user_id = \"" + cookieValue + "\"";
        ResultSet reservationResult = connection.createStatement().executeQuery(reservationQuery);
        %>
        
        <h1>Reservations</h1>
        <ul>
            <%while(reservationResult.next()) {
                String bookQuery = "SELECT * FROM books WHERE book_id = " + reservationResult.getInt("book_id");
                ResultSet bookResult = connection.createStatement().executeQuery(bookQuery);
                bookResult.next();
                String bookName = bookResult.getString("book_name");
            %>
            <li><%out.print(bookName);%></li>
            <%}%>
        </ul>
    </body>
</html>
