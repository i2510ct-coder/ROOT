<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<title>商品詳細</title>
</head>
<body>
<h1>商品詳細ページ</h1>

<%
    String id = request.getParameter("id");
%>

<p>商品ID: <%= id %></p>

<a href="top.jsp">商品一覧へ戻る</a>

</body>
</html>
