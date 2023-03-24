<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${basePath}lib/layui-src/css/layui.css" media="all">
    <link rel="stylesheet" href="${basePath}lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${basePath}css/style.css" media="all">
<body>
<div class="layuimini-container layuimini-page-anim">
    <div class="layuimini-main width_60">
        <form class="layui-form">
            <input type="hidden" name="id" value="${evaluate.id}">
            <div class="layui-form-item">
                <label class="layui-form-label">订单编号</label>
                <div class="layui-input-block">
                    <select name="orderid" lay-verify="required">
                        <option value="">请选择信息</option>
                        <c:forEach items="${orders}" var="order">
                            <option value="${order.id}"
                                    <c:if test="${evaluate.orderid == order.id}">selected</c:if>
                            >${order.id}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">评价</label>
                <div class="layui-input-block">
                    <input type="text" name="evaluate" value="${evaluate.evaluate}" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-primary layui-btn-sm data-add-btn">
                        <i class="fa fa-refresh"></i>
                        重置
                    </button>
                    <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-submit lay-filter="save">
                        <i class="fa fa-save"></i>
                        保存
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${basePath}lib/layui-src/layui.js" charset="utf-8"></script>
<script src="${basePath}js/lay-config.js?v=2.0.0" charset="utf-8"></script>
<script>
    layui.use(['form','jquery'], function () {
        var form = layui.form,$ = layui.jquery;
        //获取窗口索引
        var index = parent.layer.getFrameIndex(window.name);
        //监听提交
        form.on('submit(save)', function (data) {
            $.ajax({
                url:"${basePath}evaluate/update?id="+
                    data.field.id+"&orderid="+
                    data.field.orderid+"&evaluate="+
                    data.field.evaluate,
                type:"POST",
                contentType:'application/json',
                dataType:'json',
                data:JSON.stringify(data.field),
                success:function(data){
                    layer.msg(data.msg,{time:500},
                        function(){
                            parent.layer.close(index);
                        });
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
