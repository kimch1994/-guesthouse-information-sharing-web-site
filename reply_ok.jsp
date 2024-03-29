<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="project.DBUtill" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String memo = request.getParameter("memo");
		int idx = Integer.parseInt(request.getParameter("idx"));

		try {
			int ref = 0;
			int indent = 0;
			int step = 0;

			Connection conn = DBUtill.getMySQLConnection();
			Statement stmt = conn.createStatement();

			String sql = "SELECT REF, INDENT, STEP FROM board WHERE NUM=" + idx;
			ResultSet rs = stmt.executeQuery(sql);

			if (rs.next()) {
				ref = rs.getInt(1);
				indent = rs.getInt(2);
				step = rs.getInt(3);
			}

			sql = "UPDATE board SET STEP=STEP+1 where REF=" + ref + " and STEP>" + step;
			stmt.executeUpdate(sql);

			sql = "INSERT INTO board(USERNAME, PASSWORD, TITLE, MEMO, REF, INDENT, STEP) "
					+ "values(?,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, password);
			pstmt.setString(3, title);
			pstmt.setString(4, memo);
			pstmt.setInt(5, ref);
			pstmt.setInt(6, indent + 1);
			pstmt.setInt(7, step + 1);

			pstmt.execute();
			rs.close();
			stmt.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {

		}
	%>
	<script language=javascript>
		self.window.alert("입력한 글을 저장하였습니다.");
		location.href = "list.jsp";
	</script>

</body>
</html>