<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

    request.setCharacterEncoding("utf-8");
	String searchText = request.getParameter("searchText");


	String url_mysql = "jdbc:mysql://database-2.cotrd7tmeavd.ap-northeast-2.rds.amazonaws.com/firstkorea?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select storeSeqNo, storeName, storeScore, storeCategory, priceRange, storeAddress, storeImage, (log(1 + ((select count(*) from foodstore) - (select count(*) from foodstore where storeReview like '%" + searchText + "%') + 0.5) / ((select count(*) from foodstore where storeReview like '%" + searchText + "%') + 0.5))) * (char_length(storeReview)-char_length(replace(storeReview,'" + searchText + "',''))) * (1.2 + 1) / (char_length(storeReview)-char_length(replace(storeReview,'" + searchText + "','')) + 1.2 * (1 - 0.75 + (0.75 * char_length(storeReview)) / (select avg(char_length(storeReview)) from foodstore ))) as bm25result from foodstore order by bm25result desc limit 5";
    int count = 0;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(WhereDefault); // &quot;
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
			"storeSeqNo" : "<%=rs.getString(1) %>",
			"storeName" : "<%=rs.getString(2) %>",
			"storeScore" : "<%=rs.getString(3) %>", 
			"storeCategory" : "<%=rs.getString(4) %>",
            "priceRange" : "<%=rs.getString(5) %>",
            "storeAddress" : "<%=rs.getString(6) %>",
            "storeImage" : "<%=rs.getString(7) %>"		
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
