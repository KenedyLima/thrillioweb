<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>thrill.io</title>
</head>
<body style="font-family: Arial; font-size: 20px;">
	<div
		style="height: 65px; align: center; background: #DB5227; font-family: Arial; color: white;"">
		<br> <b> <a href=""
			style="font-family: garamond; font-size: 34px; margin: 0 0 0 10px; color: white; text-decoration: none;">thrill.io</a></b>
		<div
			style="height: 25px; background: #DB5227; font-family: Arial; color: white;">
			<b> <a href="<%=request.getContextPath()%>/browse"
				style="font-size: 16px; color: white; margin-left: 1150px; text-decoration: none;">Browse</a>
				<a href="<%=request.getContextPath()%>/auth/logout"
				style="font-size: 16px; color: white; margin-left: 10px; text-decoration: none;">Logout</a>
			</b>
		</div>
	</div>
	<br>
	<br>
	<a href="<%=request.getContextPath()%>/bookmarks"
		style="font-size: 16px; color: gray; margin-left: 1150px; text-decoration: none;">All</a>
	<a href="<%=request.getContextPath()%>/bookmarks/movies"
		style="font-size: 16px; color: gray; margin-left: 1150px; text-decoration: none;">Movies</a>
	<a href="<%=request.getContextPath()%>/bookmarks/weblinks"
		style="font-size: 16px; color: gray; margin-left: 1150px; text-decoration: none;">Weblinks</a>
	<a href="<%=request.getContextPath()%>/bookmarks/books"
		style="font-size: 16px; color: gray; margin-left: 1150px; text-decoration: none;">Books</a>

	<div
		style="font-size: 24px; color: #333333; padding: 15px 0px 0px; border-bottom: #333333 1px solid; clear: both;">Saved
		Items</div>
	<br>
	<br>

	<c:if test="${!empty(movies)}">
		<h1>Movies</h1>
		<table>
			<c:forEach var="movie" items="${movies}">
				<tr>
					<td>${movie.title}</td>
				</tr>

				<tr>
					<td>${movie.genre}</td>
				</tr>
				<tr>
					<td>${movie.releaseYear}</td>
				</tr>
				<tr>
					<td>${movie.imdbRating}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

	<c:if test="${!empty(books)}">
		<h1>Books</h1>
		<table>
			<c:forEach var="book" items="${books}">
				<tr>
					<td><img src="${book.imageUrl}" width="175" height="200">
					</td>

					<td style="color: gray;">By <span style="color: #B13100;">${book.authors[0]}</span>
						<br> <br> Rating: <span style="color: #B13100;">${book.amazonRating}</span>
						<br> <br> Publication Year: <span
						style="color: #B13100;">${book.publicationYear}</span> <br> <br>
						<a
						href="<%=request.getContextPath()%>/bookmark/delete?bid=${book.id}"
						style="font-size: 18px; color: red; font-weight: bold; text-decoration: none">Delete</a>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>

			</c:forEach>

		</table>
	</c:if>

</body>
</html>