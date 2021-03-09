<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("utf-8");
	String Id = request.getParameter("id");
	String Pw = request.getParameter("pw");

//------

	String url_mysql = "jdbc:mysql://database-2.cotrd7tmeavd.ap-northeast-2.rds.amazonaws.com/firstkorea?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "SELECT userPw FROM userinfo WHERE userId=?";
    int count = 0;

    PreparedStatement ps = null;

    String dbPW = ""; // db에서 꺼낸 비밀번호를 담을 변수
    int x = -1;

    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ps = conn_mysql.prepareStatement(WhereDefault);

        ps.setString(1, Id);

        ResultSet rs = ps.executeQuery(); // &quot;

        if (rs.next()) // 입려된 아이디에 해당하는 비번 있을경우
            {
                dbPW = rs.getString(1); // 비번을 변수에 넣는다.
               
 
                if (dbPW.equals(Pw)) {
                    x = 1; // 넘겨받은 비번과 꺼내온 비번 비교. 같으면 인증성공
                    
                }
                else{                 
                    x = 0; // DB의 비밀번호와 입력받은 비밀번호 다름, 인증실패
                     
                }
            } else {
                x = -1; // 해당 아이디가 없을 경우
                  
            }



%>
  	[ 

			{
			"result" : "<%=x %>"		
			}

		  ]
<%		
        conn_mysql.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
	
%>
