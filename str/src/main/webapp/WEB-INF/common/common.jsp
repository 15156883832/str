<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"  %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<!-- <script type="text/javascript" src="../static/javascript/javascript.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../static/normalFuction/functions.js"></script> 
<script type="text/javascript" src="../static/layer/2.1/layer.js"></script> 
<link rel="stylesheet" type="text/css" href="../static/layer/2.1/skin/layer.css">
<link rel="stylesheet" type="text/css" href="../static/css/style.css">
<link rel="stylesheet" type="text/css" href="../static/css/H-ui.admin.css"> -->

<!-- jquery.easyui.1.5.4 -->
<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
<link rel="stylesheet" type="text/css" href="${path}/static/css/zxf-style.css">
<link rel="stylesheet" type="text/css" href="${path}/static/css/my_style.css">
<script type="text/javascript" src="${path}/static/normalFuction/functions.js"></script> 
<link rel="stylesheet" type="text/css" href="${path}/static/jquery.easyui.1.5.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${path}/static/jquery.easyui.1.5.4/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${path}/static/jquery.easyui.1.5.4/demo/demo.css">
<script type="text/javascript" src="${path}/static/normalFuction/menuAndTab.js"></script> 

<script type="text/javascript" src="${path}/static/jquery.easyui.1.5.4/jquery.min.js"></script> 
<script type="text/javascript" src="${path}/static/jquery.easyui.1.5.4/jquery.easyui.min.js"></script> 
<script type="text/javascript" src="${path}/static/layer/2.1/layer.js"></script> 


<script type="text/javascript" src="${path}/static/jQueryHover/divhover.js"></script> 







<c:set var="root" value="${pageContext.request.contextPath}"/>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/> --%>
<c:set var="ctxPlugin" value="${pageContext.request.contextPath}/plug-in"/>
<c:set var="ctxImg" value="${pageContext.request.contextPath}"/> 