<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../NavBar/CoinShellNavBar.jsp" />

<head>
<meta charset="UTF-8">
<title>About Us | CoinShell</title>
<style type="text/css">

/* The side navigation menu */
.sidebar {
	margin: 0;
	padding: 0;
	width: 200px;
	background-color: #f1f1f1;
	position: fixed;
	height: 100%;
	overflow: auto;
}

/* Sidebar links */
.sidebar a {
	display: block;
	color: black;
	padding: 16px;
	text-decoration: none;
}

/* Active/current link */
.sidebar a.active {
	background-color: #04AA6D;
	color: white;
}

/* Links on mouse-over */
.sidebar a:hover:not(.active) {
	background-color: #555;
	color: white;
}

/* Page content. The value of the margin-left property should match the value of the sidebar's width property */
div.content {
	margin-left: 200px;
	padding: 1px 16px;
	height: 1000px;
}

/* On screens that are less than 700px wide, make the sidebar into a topbar */
@media screen and (max-width: 700px) {
	.sidebar {
		width: 100%;
		height: auto;
		position: relative;
	}
	.sidebar a {
		float: left;
	}
	div.content {
		margin-left: 0;
	}
}

/* On screens that are less than 400px, display the bar vertically, instead of horizontally */
@media screen and (max-width: 400px) {
	.sidebar a {
		text-align: center;
		float: none;
	}
}

body {
	padding-top: 82px;
}
</style>

</head>

<body>

	<!-- side bar 側邊欄位 -->
	<div class="sidebar">
		<a href="${contextRoot}/aboutUs/intro">About Our Team</a> <a
			href="${contextRoot}/account/cookie">Cookie Policy</a> <a
			href="${contextRoot}/account/privacy">Privacy Policy</a> <a href="#">Admin
			Log In</a>
	</div>

	<!--Page content-->
	<div class="container"
		style="margin-top: 30px; background-color: #fff; border-radius: 30px;">
		<div class="col-9">
			<h3>About Coinshell</h3>
			<div>Coinshell is a price-tracking website for cryptoassets in
				the rapidly growing cryptocurrency space. Its mission is to make
				crypto discoverable and efficient globally by empowering retail
				users with unbiased, high quality and accurate information for
				drawing their own informed conclusions.</div>
			<h5>Our team:</h5>
				<ul>
					<li>Chief executive officer: Pietersite Crystal</li>
					<li>Chief technology officer: Huginn Hoxton</li>
					<li>Chief information officer: Fenrir Feeder</li>
					<li>Chief financial officer: Bjarki Bear</li>
					<li>Chief security officer: Sváfnir Celine</li>
				</ul>
				<p>TODO: 這裡要加入 animated donut chart using chart.js</p>
		</div>
	</div>


</body>