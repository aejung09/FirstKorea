<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
    String userId = request.getParameter("userid");
    
	String url_mysql = "jdbc:mysql://database-2.cotrd7tmeavd.ap-northeast-2.rds.amazonaws.com/firstkorea?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select * from categorytab where t_userId = ?";
    int count = 0;
    ResultSet rs = null;

    PreparedStatement ps = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();
		ps = conn_mysql.prepareStatement(WhereDefault);
		ps.setString(1,userId);// 
        rs = ps.executeQuery(); 
%>      
  	[ 
<%
        while (rs.next()) {
            if (count == 0) {

            }else{
%>
            , 
<%           
            }
            count++;                 
%>
			{
			"newsTabs" : "<%=rs.getString(2) %>",
            "sportTab" : "<%=rs.getString(3) %>",
            "yutubeTab" : "<%=rs.getString(4) %>",
            "priceTap" : "<%=rs.getString(5) %>",
            "famousRestaurantTab" : "<%=rs.getString(6) %>",
            "coinTab" : "<%=rs.getString(7) %>"
			
				
			}
<%		
        }
%>
		  ]
<%		
        conn_mysql.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
	
%>
