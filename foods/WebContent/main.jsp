<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Restaurant.음식점" %>
<%@ page import="Restaurant.음식점DAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String 분류 = null;
		if(session.getAttribute("분류") != null) {
			분류 = (String) session.getAttribute("분류");
		}
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
				<li class="active"><a href="main.jsp">메인</a></li>
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
	
	<div class="jumbotron" style="background-color:pink">
      <h1 style="text-align: center;">분류별 음식점</h1>
   </div>   
   <div class="container">
   <%
   		ArrayList<String> list = new ArrayList<String>();
  		list.add("치킨");
  		list.add("피자");
  		list.add("패스트푸드");
  		list.add("중국집");
  		list.add("한식");
  		list.add("분식");
  		list.add("족발,보쌈");
	%>
      <a  class="btn btn-primary btn-pull"  href="chickenlist.jsp" role="button" style=" font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">치킨
      </a>

      <a  class="btn btn-primary btn-pull"  href="pizzalist.jsp" role="button" style="font-size: 20px; 
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">피자
      </a>
      
      <a  class="btn btn-primary btn-pull"  href="fastlist.jsp" role="button" style="font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">패스트푸드
      </a>
      
      <a  class="btn btn-primary btn-pull"  href="chinalist.jsp" role="button" style="font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">중국집
      </a>
   </div>
   <div class="container">
      <a  class="btn btn-primary btn-pull"  href="korealist.jsp" role="button" style="font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">한식
      </a>
      
      <a  class="btn btn-primary btn-pull"  href="ddoklist.jsp" role="button" style="font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">분식
      </a>
      
      <a  class="btn btn-primary btn-pull"  href="jokbolist.jsp" role="button" style="font-size: 20px;
      WIDTH: 120pt; HEIGHT: 120pt; background-color:pink; margin:50px">족발,보쌈
      </a>

   </div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>