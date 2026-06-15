Delicious Foods Backend - Java Servlet/JSP/JDBC/MySQL

Required:
1. JDK 17 or JDK 11
2. Apache Tomcat 9 or 10
3. MySQL Server
4. MySQL Connector/J jar

Setup:
1. Create database using database/delicious_foods.sql
2. Update DB username/password in src/main/java/com/deliciousfoods/util/DBConnection.java
3. Open project in NetBeans / IntelliJ / Eclipse as a Maven Web App.
4. Run on Apache Tomcat.
5. Frontend can call these servlet URLs:
   - register
   - login
   - logout
   - create-order
   - my-orders
   - admin-login
   - admin-dashboard
   - update-order-status

Default admin:
Email: admin@deliciousfoods.com
Password: admin123
