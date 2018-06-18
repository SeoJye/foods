<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ShareBoard.게시판DAO" %>
<%@ page import="ShareBoard.게시판" %>
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
		String bbsID = "S0000";
		if(request.getParameter("bbsID") != null) {
			bbsID = request.getParameter("bbsID");
		}
		if(bbsID == "S0000") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'shareBoard.jsp'");
			script.println("</script>");
		}
		게시판 shareBoard = new 게시판DAO().get게시판(bbsID);
		if(!userID.equals(shareBoard.get고객아이디())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'shareBoard.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("제목") == null || request.getParameter("내용") == null || request.getParameter("제목").equals("") ||request.getParameter("내용").equals(""))
			{
				PrintWriter script = response.getWriter();
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				게시판DAO bbsDAO = new 게시판DAO();
				int result = bbsDAO.update(bbsID, request.getParameter("제목"), request.getParameter("내용"));
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'shareBoard.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>