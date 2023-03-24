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
            <input type="hidden" name="id" value="${order.id}">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <select name="userid" lay-verify="required">
                        <option value="">请选择信息</option>
                        <c:forEach items="${users}" var="user">
                            <option value="${user.id}">${user.username1}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">护工姓名</label>
                <div class="layui-input-block">
                    <select name="workerid" lay-verify="required">
                        <option value="">请选择信息</option>
                        <c:forEach items="${careworkers}" var="careworker">
                            <option value="${careworker.id}">${careworker.workername}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">创建时间</label>
                <div class="layui-input-block">
                    <input type="text" name="createtime" lay-verify="required" class="layui-input" id="date1">
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
            console.log("訂單 data:",data)
            $.ajax({
                url:"${basePath}order/create?id="+
                    data.field.id+"&username="+
                    data.field.username+"&telephonenumber="+
                    data.field.telephonenumber+"&workername="+
                    data.field.workername+"&createtime="+
                    data.field.createtime+'&userid='+data.field.userid+'&workerid='+data.field.workerid,
                type:"POST",
                contentType:'application/json',
                dataType:'json',
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
    // layui.use('laydate',function () {
    //     var laydate=layui.laydate;
    //
    //     laydate.render({
    //         elem:"#date1"
    //     });
    // });
</script>
</body>
</html>
