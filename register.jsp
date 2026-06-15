<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Register - Delicious Foods</title><link rel="stylesheet" href="style.css"></head>
<body>
<div class="auth-modal active">
  <div class="auth-box">
    <div class="auth-left"><h2>Delicious Foods</h2><p>Pure Vegetarian Food</p><span>Fresh • Healthy • Tasty</span></div>
    <div class="auth-right">
      <form class="auth-form active-form" method="post" action="register">
        <h3>Create Account</h3>
        <input type="text" name="fullName" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="text" name="phone" placeholder="Phone Number" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        <button type="submit">Register</button>
        <p style="color:red"><%= request.getParameter("error") == null ? "" : request.getParameter("error") %></p>
        <a href="login.jsp">Already have account?</a>
      </form>
    </div>
  </div>
</div>
</body></html>
