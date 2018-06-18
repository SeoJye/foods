<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="MenuBoard.등록" %>
<%@ page import="MenuBoard.등록DAO" %>
<%@ page import="MenuBoard.메뉴판" %>
<%@ page import="MenuBoard.메뉴판DAO" %>
<%@ page import="Menu.메뉴" %>
<%@ page import="Menu.메뉴DAO" %>
<%@ page import="Restaurant.음식점" %>
<%@ page import="Restaurant.음식점DAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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
		메뉴판 mbs = new 메뉴판DAO().get메뉴판(menuID);
		등록 dbs = new 등록DAO().get등록(menuID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">음식점의 민족</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">음식점</a></li>
				<li><a href="ranking.jsp">랭킹</a></li>
				<li><a href="shareBoard.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) {
			%>		
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown" 
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown" 
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false"><%= userID %><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="myPageAction.jsp">마이페이지</a></li>
						<li class="active"><a href="boardView.jsp">나만의 메뉴판</a></li>
						<li><a href="orderedAction.jsp">주문내역</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #dddddd; text-align: center;"><%= mbs.get메뉴판이름().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replace(">", "&gt;").replaceAll("\n", "<br>") %></th>
					</tr>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">음식점이름</th>
						<th style="background-color: #eeeeee; text-align: center;">메뉴이름</th>
						<th style="background-color: #eeeeee; text-align: center;">메뉴가격</th>
					</tr>
				</thead>
				<tbody>
					<%
						등록DAO dbsDAO = new 등록DAO();
						메뉴DAO menDAO = new 메뉴DAO();
						음식점DAO resDAO = new 음식점DAO();
						ArrayList<등록> list = dbsDAO.getList(menuID);
						for(int i = 0; i < list.size(); i++) {
					%>
						<tr>
							<td><%= resDAO.get음식점이름(menDAO.get음식점번호(list.get(i).get메뉴번호())) %></td>
							<td><%= menDAO.get메뉴이름(list.get(i).get메뉴번호()) %></td>
							<td><%= menDAO.get메뉴가격(list.get(i).get메뉴번호()) %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<a href="boardView.jsp" class="btn btn-primary">목록</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteBoardAction.jsp?menuID=<%= menuID %>" class="btn btn-primary">삭제</a>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>