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
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		String[] chk = request.getParameterValues("check");

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
				<li  class="active"><a href="main.jsp">음식점</a></li>
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
						<li><a href="boardView.jsp">나만의 메뉴판</a></li>
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
						<th style="background-color: #eeeeee; text-align: center;">음식점이름</th>
						<th style="background-color: #eeeeee; text-align: center;">메뉴이름</th>
	

					<th style="background-color: #eeeeee; text-align: center;">메뉴가격</th>
					</tr>
				</thead>
				<tbody>
					<%
						메뉴DAO menDAO = new 메뉴DAO();
						음식점DAO resDAO = new 음식점DAO();
						String check = "";
						for(int i = 0; i < chk.length; i++) {
							check += chk[i];
					%>
						<tr>
							<td><%= resDAO.get음식점이름(menDAO.get음식점번호(chk[i])) %></td>
							<td><%= menDAO.get메뉴이름(chk[i]) %></td>
							<td><%= menDAO.get메뉴가격(chk[i]) %></td>
						</tr>
					<%
						
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>	
						<th colspan="2" style="background-color: #dddddd; textalign: center;">기존 메뉴판에 추가</th>
					</tr>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">메뉴판번호</th>
						<th style="background-color: #eeeeee; text-align: center;">메뉴판이름</th>
					</tr>
				</thead>
				<tbody>
					<%
						메뉴판DAO mbsDAO = new 메뉴판DAO();
						ArrayList<메뉴판> list = mbsDAO.getList();
						for(int i = 0; i < list.size(); i++) {
							if(userID != null && userID.equals(list.get(i).get고객아이디())) {
					%>
						<tr>
							<td style="textalign: center;"><%= list.get(i).get메뉴판번호() %></td>
							<td style="textalign: center;"><a href="resistBoardAction.jsp?menuID=<%= list.get(i).get메뉴판번호()%>&menuNo=<%= check%>&menuNoCount=<%= chk.length%>"><%= list.get(i).get메뉴판이름() %></a></td>
						</tr>
					<%
							}
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<form method="post" action="addBoardAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #dddddd; textalign: center;">새로운 메뉴판 추가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="새로운 메뉴판 이름" name="메뉴판이름" maxlength="20"></td>
							<td align="right"><input type="submit" class="btn btn-primary" value="추가"></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>