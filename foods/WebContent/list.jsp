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
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
 <%
      String userID=null;
      if(session.getAttribute("userID")!=null){
      userID=(String)session.getAttribute("userID");
      }
      String sort = "없음";
		if(request.getParameter("sort") != null) {
			sort = request.getParameter("sort");
		}
		음식점 bbs = new 음식점DAO().get분류(sort);

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
            <li ><a href="ranking.jsp">랭킹</a></li>
            <li><a href="shareBoard.jsp">게시판</a></li>
         </ul>
         <%   
            if(userID==null){
         %>
         <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"
                  data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">접속하기<span class="caret"></span></a>
               <ul class="dropdown-menu">
                  <li><a href="login.jsp">로그인</a></li>
                  <li><a href="join.jsp">회원가입</a></li>
                  
               </ul>
            </li>
         </ul>
         <%
            } else{
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
      <h1 style="text-align: center;">음식점 이름</h1>
   </div>
   <div class="container">
      <div class="row">
         <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
         <thead>
         <tr>
            <th style="background-color:#FFD9EC; text-align:center;">음식점이름</th>
            <th style="background-color:#FFD9EC; text-align:center;">평점</th>
            <th style="background-color:#FFD9EC; text-align:center;">주문 수</th>
         </tr>
         </thead>
         <tbody>
        <%
            	음식점DAO listDAO=new 음식점DAO();
         		 ArrayList<음식점> list= listDAO.mlist(bbs.get분류());
            for(int i=0;i<list.size();i++){
         %> 
         <tr>
            <td><a href="menu.jsp?seq=<%= list.get(i).get음식점번호() %>"><%= list.get(i).get음식점이름() %></a></td>
            <td><%= list.get(i).get평점() %></td>
            <td><%= list.get(i).get주문수() %></td>
         </tr>
        <%
           }
        %>

         </tbody>
         </table>
      </div>
   </div>
   
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>