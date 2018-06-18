<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="MenuBoard.등록DAO" %>
<%@ page import="MenuBoard.등록" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
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
		String menuNo = "M0000";
		if(request.getParameter("menuNo") != null) {
			menuNo = request.getParameter("menuNo");
		}
		String menuID = "Z0000";
		if(request.getParameter("menuID") != null) {
			menuID = request.getParameter("menuID");
		}
		int menuNoCount = 0;
		if(request.getParameter("menuNoCount") != null) {
			menuNoCount = Integer.parseInt(request.getParameter("menuNoCount"));
		}
		
		ArrayList<String> menuNoList = new ArrayList<String>();
		
		for(int i=0; i<menuNoCount; i++) {
			menuNoList.add(menuNo.substring((i*5), ((i*5)+5)));
		}
		
		if(menuID == "Z0000") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴판번호가 없어서 메뉴판에 등록할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(menuNo == "M0000") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴번호가 없어서 메뉴판에 등록할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(menuNoCount == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴갯수가 없어서메뉴판에 등록할 수 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			등록DAO resistDAO = new 등록DAO();
			int result = 0;
			for(int j = 0; j < menuNoCount; j++) {
			result = resistDAO.resistMenu(menuID, menuNoList.get(j));
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('메뉴를 등록하는 데 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴를 등록하는 데 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메뉴를 성공적으로 등록하였습니다.')");
			script.println("location.href = 'boardView.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>