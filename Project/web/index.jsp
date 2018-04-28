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
        <title>MemeSeen</title>
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

        String sort = request.getParameter("sort");
        String postQuery;
        if (sort != null && sort.equals("new")) {
            postQuery = "SELECT * FROM posts ORDER BY created DESC";
        } else if(sort != null && sort.equals("popular")) {
            postQuery = "SELECT * FROM posts ORDER BY votes DESC";
        } else {
            postQuery = "SELECT * FROM posts ORDER BY post_title";
        }
        
        Statement postStatement = connection.createStatement();
        ResultSet postResult = postStatement.executeQuery(postQuery);
        %>
        <div class="container center">
            <%
            while(postResult.next()) {
                int post_id = postResult.getInt("post_id");
                int author_id = postResult.getInt("author_id");
                String title = postResult.getString("post_title");
                String description = postResult.getString("post_description");
                String imageURL = postResult.getString("image_url");
                int votes = postResult.getInt("votes");
                
                String authorUsername;
                
                String authorUsernameQuery = "SELECT username FROM users WHERE user_id = " + author_id;
                ResultSet authorUsernameResult = connection.createStatement().executeQuery(authorUsernameQuery);
                authorUsernameResult.next();
                authorUsername = authorUsernameResult.getString("username");
                
                String commentsQuery = "SELECT * FROM comments WHERE post_id = " + post_id;
                ResultSet commentsResult = connection.createStatement().executeQuery(commentsQuery);
            %>
            <div class="post xymargins">
                <img src="<%out.print(imageURL);%>" height="512" width="512"/>
                <div class="container justify">
                    <form method="POST" action="vote.jsp">
                        <input type="hidden" name="postId" value="<%out.print(post_id);%>">
                        <input type="hidden" name="voteUp" value="true">
                        <input type="submit"  value="+">
                    </form>
                    <h1><%out.print(votes);%></h1>
                    <form method="POST" action="vote.jsp">
                        <input type="hidden" name="postId" value="<%out.print(post_id);%>">
                        <input type="hidden" name="voteUp" value="false">
                        <input type="submit"  value="-">
                    </form>
                </div>
                <div class="container justify">
                    <h1 class="pull-left"><%out.print(title);%></h1>
                    <h2 class="pull-right">author: <%out.print(authorUsername);%></h2>
                </div>
                <div class="container">
                    <p><%out.print(description);%></p>
                </div>
                <div class="container">
                    <h3>Comments:</h3>
                    <%
                    while(commentsResult.next()) {
                        int comment_id = commentsResult.getInt("comment_id");
                        int commenter_id = commentsResult.getInt("author_id");
                        String comment = commentsResult.getString("comment");
                        String commenterUsername;

                        String commenterUsernameQuery = "SELECT username FROM users WHERE user_id = " + commenter_id;
                        ResultSet commenterUsernameResult = connection.createStatement().executeQuery(commenterUsernameQuery);
                        commenterUsernameResult.next();
                        commenterUsername = commenterUsernameResult.getString("username");
                    %>
                    <div class="container">
                        <p><%out.print(commenterUsername);%>: <%out.print(comment);%></p>
                    </div>
                    <%}%>
                </div>
                <div class="container xymargins">
                    <form method="POST" action="comment.jsp">
                        <input type="hidden" name="postId" value="<%out.print(post_id);%>">
                        <textarea name="comment">Enter a comment.</textarea>
                        <input type="submit">
                    </form>
                </div>
            </div>
            <%
            }
            %>
        </div>
    </body>
</html>
