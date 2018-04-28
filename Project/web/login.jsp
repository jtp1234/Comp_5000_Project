<%-- 
    Document   : login
    Created on : Apr 20, 2018, 1:25:32 AM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Login</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div>
            <%
            String message = null;
            if(request.getMethod().equals("POST")) {
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
                if(request.getParameter("formType").equals("login")) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    String userQuery = "SELECT * FROM users WHERE username = \"" + username + "\"";
                    ResultSet userResult = connection.createStatement().executeQuery(userQuery);
                    if (userResult.next()) {
                        String correctPassword = userResult.getString("password");
                        if (correctPassword.equals(password)) {
                            int userId = userResult.getInt("user_id");
                            Cookie c = new Cookie("userId", "" + userId);
                            c.setMaxAge(60*60*24);
                            c.setPath("/");
                            response.addCookie(c);
                            response.sendRedirect("index.jsp");
                        } else {
                            message = "Incorrect password!";
                        }
                    } else {
                        message = "Username does not exist!";
                    }

                } else if (request.getParameter("formType").equals("register")) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String verifyPassword = request.getParameter("verifyPassword");

                    String userQuery = "SELECT * FROM users WHERE username = \"" + username + "\"";
                    ResultSet userResult = connection.createStatement().executeQuery(userQuery);
                    if (userResult.next()) {
                        message = "User already exists!";
                    } else {
                        if (password.equals(verifyPassword)) {
                            String createUser = "INSERT INTO users (username, password) VALUES (\"" + username + "\", \"" + password + "\");"; 
                            connection.createStatement().executeUpdate(createUser);
                            message = "User created!";
                        } else {
                            message = "Passwords do not match!";
                        }
                    }

                } 
            }
            %>
            <div class="post xymargins container">
                <h1>Login</h1>
                <form method="POST">
                    <input type="hidden" name="formType" value="login"/>
                    Username: <input type="text" name="username"/><br>
                    Password: <input type="text" name="password"/><br>
                    <input type="submit"/>
                </form>
            </div>

            <div class="post xymargins container">
                <h1>Register</h1>
                <form method="POST">
                    <input type="hidden" name="formType" value="register"/>
                    Username: <input type="text" name="username"/><br>
                    Password: <input type="text" name="password"/><br>
                    Confirm Password: <input type="text" name="verifyPassword"/><br>
                    <input type="submit"/>
                </form>
                <%if (message != null) {%>
                <h1><%out.print(message);%></h1>
                <%}%>
            </div>
        </div>
    </body>
</html>
