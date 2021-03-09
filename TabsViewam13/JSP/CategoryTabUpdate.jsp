<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>        
<%
	request.setCharacterEncoding("utf-8");
	String news = request.getParameter("newsTabs");
	String sport = request.getParameter("sportTab");
	String youtube = request.getParameter("yutubeTab");
	String price = request.getParameter("priceTap");
	String famousRestaurant = request.getParameter("famousRestaurantTab");
	String coin = request.getParameter("coinTab");
	String userid = request.getParameter("userid");
		
//------
	String url_mysql = "jdbc:mysql://database-2.cotrd7tmeavd.ap-northeast-2.rds.amazonaws.com/firstkorea?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
	String id_mysql = "root";
	String pw_mysql = "qwer1234";

	PreparedStatement ps = null;
	try{
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn_mysql = DriverManager.getConnection(url_mysql,id_mysql,pw_mysql);
	    Statement stmt_mysql = conn_mysql.createStatement();
	
	    String A = "update categorytab set newsTab = ?, sportTab = ?, yutubeTab = ?, priceTap = ?, famousRestaurantTab = ?, coinTab = ?  where t_userId = ?";
	   
	
	    ps = conn_mysql.prepareStatement(A);
	    ps.setString(1, news);
	    ps.setString(2, sport);
	    ps.setString(3, youtube);
        ps.setString(4, price);
        ps.setString(5, famousRestaurant);
        ps.setString(6, coin);
        ps.setString(7, userid);
	   
	    
	    ps.executeUpdate();
	
	    conn_mysql.close();
	} 
	
	catch (Exception e){
	    e.printStackTrace();
	}

%>

