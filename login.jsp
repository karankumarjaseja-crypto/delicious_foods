<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Login - Delicious Foods</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="auth-modal active">
  <div class="auth-box">
    <div class="auth-left"><h2>Delicious Foods</h2><p>Pure Vegetarian Food</p><span>Fresh • Healthy • Tasty</span></div>
    <div class="auth-right">
      <form class="auth-form active-form" method="post" action="login">
        <h3>Login</h3>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
        <p style="color:red"><%= request.getParameter("error") == null ? "" : request.getParameter("error") %></p>
        <p style="color:green"><%= request.getParameter("success") == null ? "" : request.getParameter("success") %></p>
        <a href="register.jsp">Create account</a>
      </form>
    </div>
  </div>
</div>
</body></html>
