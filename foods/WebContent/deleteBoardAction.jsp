<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="MenuBoard.메뉴판DAO" %>
<%@ page import="MenuBoard.메뉴판" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		} 
		String menuID = "Z0000";
		if(request.getParameter("menuID") != null) {
			menuID = request.getParameter("menuID");
		}
		if(menuID == "Z0000") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 메뉴판입니다.')");
			script.println("location.href = 'boardView.jsp'");
			script.println("</script>");
		}
		메뉴판 menuBoard = new 메뉴판DAO().get메뉴판(menuID);
		if(!userID.equals(menuBoard.get고객아이디())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else {
				메뉴판DAO mbsDAO = new 메뉴판DAO();
				int result = mbsDAO.deleteBoard(menuID);
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'boardView.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>