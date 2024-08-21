<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="false" %> 
<link rel="stylesheet" type="text/css" href="style.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body><center>
<h1>EMPLOYEE MANAGEMENT SYSTEM</h1>
<form action="POST"><h2><center>login</center></h2>
<hr>
<label>22rp14455-usermame</label>
<input type ="email" name="email"><br><br>

<label>password-22rp14455</label>
<input type ="password" name="password"><br><br>
<button name="submit">login</button>
<p>sign up here <a href="22rp14455signup.jsp">signup</a>
</p>
</form>
</center>
<%
            if (request.getParameter("submit") != null) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                String url = "jdbc:mysql://localhost:3306/emp_22rp14455";
                String user = "root"; 
                String pass = "";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    conn = DriverManager.getConnection(url, user, pass);
                    
             
                    String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, password); 
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                       
                        HttpSession session = request.getSession();
                        session.setAttribute("userEmail", email);
                        
                        out.println("<h3>Login Successful!</h3>");
                        out.println("<p>Welcome, " + email + "!</p>");
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        out.println("<h3>Invalid email or password!</h3>");
                    }
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>
</body>
</html>