<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<%@ page import="project.DBUtill"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>관리자모드</title>
<link rel="stylesheet" type="text/css" href="layout.css"/>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
@import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
@import url(//fonts.googleapis.com/earlyaccess/kopubbatang.css);
@import url(//fonts.googleapis.com/earlyaccess/nanumbrushscript.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
@import url(//fonts.googleapis.com/earlyaccess/hanna.css);
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/nanummyeongjo.css);
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
@import url(//fonts.googleapis.com/earlyaccess/nanumgothiccoding.css);
</style>
<script language = "javascript"> // 자바 스크립트 시작
function deleteCheck()
  {
   var form = document.deleteform;
   
   if( !form.delete1.value )   // form 에 있는 name 값이 없을 때
   {
    alert( "이름을 적어주세요" ); // 경고창 띄움
    form.delete1.focus();   // form 에 있는 name 위치로 이동
    return;
   }
   form.submit();
  }
 </script>
</head>
<div class="wrap"> 
<body>
	<%
		request.setCharacterEncoding("euc-kr");
		String e1 = (String) session.getAttribute("email");
		
	%>
	<header>
		<div class="left_top"> <a href="loginafter.jsp" target="_self"> <img src="./image/logo.jpg" >  </a> 
		<span class="right"style="padding: 10px 30px;">
			<ul>
				<li style="float:left; list-style-type : none; margin:5px 10px 10px 270px; font-family:Nanum Brush Script; font-size:25px;"> <a>관리자 님 반갑습니다.</a></li>
			</ul>
			<br>
				<form name="logout" method="post" action="logout.jsp" style="margin:10px 10px 10px 90px;">
				<a href="list.jsp" targrt="_self" style="margin:0px 5px 0px 0px; font-family:Nanum Brush Script; font-size:25px;">자유게시판</a>
				<a href="memberlist.jsp" targrt="_self" style="margin:0px -10px 0px 0px; font-family:Nanum Brush Script; font-size:25px;">회원관리</a>
				<a href="boardlist.jsp" targrt="_self" style="margin:0px 10px 0px 15px; font-family:Nanum Brush Script; font-size:25px;">게시판관리</a>
				<input type="submit" value="로그아웃" style="margin:-5px 0px 0px 0px;">
				</form>
				
    	</span>
    	</div>
    </header>
	<table border=1>
		<tr>
			<td>email</td>
			<td>password</td>
			<td>phone</td> 
		</tr>
			<%
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/h1";
			String id = "root";
			String pass = "k1234";
			try {
				Connection conn = DriverManager.getConnection(url, id, pass);
				Statement stmt = conn.createStatement();
				String sql = "SELECT * from member";
				ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {
					String email = rs.getString(1);
					String password = rs.getString(2);
					String phone = rs.getString(3);
					System.out.println(email +password + phone);
		%>
		<tr>
			<td><%=email %></td>
			<td><%=password %></td>
			<td><%=phone %></td>
		</tr>
		<%
		
			}
				rs.close();
				stmt.close();
				conn.close();
} catch (SQLException e) {
}
		%>
	</table>	
	<div style="margin: 10px 10px 10px 10px">
	<table>
		<form name=deleteform method=post action="member_delete.jsp">
		<tr>
			<td>삭제할 회원</td>
			<td><input name=delete1 placeholder="이메일을 입력하세요"></td>
			<td><input type="submit" value="확인" OnClick="javascript:deleteCheck();"> </td>
	</div>
		</form>
	</table>
</div>
</body>

</html>