<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>Thêm loại xe</title>
    <style>
        .error_message{
            color: red;
            font-size: 17px;
            font-weight: 600;
        }
    </style>
    <%--css--%>
    <jsp:include page="Style.jsp"></jsp:include>
</head>

<body class="nav-md">
<div class="container body">
    <div class="main_container">
        <%--side_bar--%>
        <jsp:include page="Navbar.jsp"></jsp:include>
        <%--/side_bar--%>

        <%--top-navigation--%>
        <jsp:include page="Topnav.jsp"></jsp:include>
        <%--/top-navigation--%>

        <%--page-content--%>
        <div class="right_col" role="main" style="min-height: 100%;">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <h3>Thông tin loại xe</h3>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 ">
                        <div class="x_panel">
                            <div class="x_title">

                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <br>
                                <form:form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left"
                                           novalidate="" modelAttribute="loaiXe" method="post" action="/admin/LoaiXe/DanhSachLoaiXe/addLoaiXe">
                                    <div class="item form-group">
                                        <label class="col-form-label col-md-3 col-sm-3 label-align" for="last-name">Mã loại xe
                                        </label>
                                        <div class="col-md-6 col-sm-6 ">
                                            <form:hidden path="maLX"/>
                                            <p id="last-name" class="form-control">${loaiXe.maLX}</p>
                                        </div>
                                    </div>
                                    <div class="item form-group">
                                        <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Tên loại xe
                                            <span class="required">*</span>
                                        </label>
                                        <div class="col-md-6 col-sm-6 ">
                                            <form:input type="text" path="tenLX" id="first-name" class="form-control"/>
                                            <p class="error_message">${message_tenlx}</p>
                                        </div>
                                    </div>

                                    <div class="ln_solid"></div>
                                    <div class="item form-group">
                                        <div class="col-md-6 col-sm-6 offset-md-3">
                                            <a href="/admin/LoaiXe/DanhSachLoaiXe" class="btn btn-primary">Trở về</a>
                                            <button type="submit" class="btn btn-success">Lưu</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--!page-content--%>
        <%--footer--%>
        <jsp:include page="Footer.jsp"></jsp:include>
        <%--!footer--%>
        <jsp:include page="Scripts.jsp"/>
</body>

</html>
