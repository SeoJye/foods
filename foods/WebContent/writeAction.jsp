<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ShareBoard.게시판DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="shareBoard" class="ShareBoard.게시판" scope="page" />
<jsp:setProperty name="shareBoard" property="제목" />
<jsp:setProperty name="shareBoard" property="내용" />
<jsp:setProperty name="shareBoard" property="메뉴판번호" />
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
			if(shareBoard.get제목() == null || shareBoard.get내용() == null)
			{
				PrintWriter script = response.getWriter();
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				게시판DAO bbsDAO = new 게시판DAO();
				int result = bbsDAO.write(shareBoard.get제목(), userID, shareBoard.get내용(), shareBoard.get메뉴판번호());
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
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