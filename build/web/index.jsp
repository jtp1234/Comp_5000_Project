<%-- 
    Document   : index
    Created on : Apr 19, 2018, 5:22:49 PM
    Author     : John
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Library Catalog</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <h1>Hello World!</h1>
        
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
        String topicQuery = "SELECT * FROM topics";
        Statement topicStatement = connection.createStatement();
        ResultSet topicResult = topicStatement.executeQuery(topicQuery);
        %>
        
        <form method="POST">
            <select name="topic">
                <option value="*">All</option>
                <%
                while(topicResult.next()) {
                    String topicValue = topicResult.getString("topic_name");
                %>
                    <option value="<%out.print(topicValue);%>"><%out.print(topicValue);%></option>
                <%
                }    
                %>
            </select>
            <input type="submit">
        </form>
        <%
        String topic = null;
        int topicId = -1;
        if(request.getMethod().equals("POST")) {
            topic = request.getParameter("topic");
            if (!topic.equals("*")) {
                String topicIdQuery = "SELECT topic_id FROM topics WHERE topic_name = \"" + topic + "\"";
                ResultSet topicIdResult = connection.createStatement().executeQuery(topicIdQuery);
                topicIdResult.next();
                topicId = topicIdResult.getInt("topic_id");
            } else {
                topic = null;
            }
        }    
        
        String bookQuery = "SELECT * FROM books" + (topicId == -1 ? "" : " WHERE topic_id = " + topicId);
        Statement bookStatement = connection.createStatement();
        ResultSet bookResult = bookStatement.executeQuery(bookQuery);
        %>
        <table>
            <tr>
                <th>Book Name</th>
                <th>Topic</th>
                <th>Author</th>
                <th>Action</th>
            </tr>
            <%
            while(bookResult.next()) {
                String bookName = bookResult.getString("book_name");
                int bookId = bookResult.getInt("book_id");
                int bookTopicId = bookResult.getInt("topic_id");
                int bookAuthorId = bookResult.getInt("author_id");
                
                String bookTopicName, bookAuthorName;
                
                String topicNameQuery = "SELECT topic_name FROM topics WHERE topic_id = " + bookTopicId;
                ResultSet topicNameResult = connection.createStatement().executeQuery(topicNameQuery);
                topicNameResult.next();
                bookTopicName = topicNameResult.getString("topic_name");
                
                String authorNameQuery = "SELECT author_name FROM authors WHERE author_id = " + bookAuthorId;
                ResultSet authorNameResult = connection.createStatement().executeQuery(authorNameQuery);
                authorNameResult.next();
                bookAuthorName = authorNameResult.getString("author_name");
            %>
            <tr>
                <td><%out.print(bookName);%></td>
                <td><%out.print(bookTopicName);%></td>
                <td><%out.print(bookAuthorName);%></td>
                <td><a href="reserve.jsp?book=<%out.print(bookId);%>">reserve</a></td>
            </tr>
            <%
            }
            %>
        </table>
    </body>
</html>
