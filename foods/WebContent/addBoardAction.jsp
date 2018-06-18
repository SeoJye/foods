<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="MenuBoard.메뉴판" %>
<%@ page import="MenuBoard.메뉴판DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="menuBoard" class="MenuBoard.메뉴판" scope="page" />
<jsp:setProperty name="menuBoard" property="메뉴판이름" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if(menuBoard.get메뉴판이름() == null)
			{
				PrintWriter script = response.getWriter();
				script.println("alert('새로운 메뉴판 이름을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				메뉴판DAO mbsDAO = new 메뉴판DAO();
				int result = mbsDAO.addBoard(menuBoard.get메뉴판이름(), userID);
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('새로운 메뉴판 추가에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('새로운 메뉴판 추가를 완료하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>