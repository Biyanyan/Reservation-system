<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <input type="hidden" name="id" value="${careworker.id}">
            <div class="layui-form-item">
                <label class="layui-form-label">护工姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="workername" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">年龄</label>
                <div class="layui-input-block">
                    <input type="text" name="workerage" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="text" name="sex" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">生日</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">身高</label>
                <div class="layui-input-block">
                    <input type="text" name="height" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">体重</label>
                <div class="layui-input-block">
                    <input type="text" name="weight" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">工龄</label>
                <div class="layui-input-block">
                    <input type="text" name="workingage" lay-verify="required" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">籍贯</label>
                <div class="layui-input-block">
                    <input type="text" name="nativeplace" lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系方式</label>
                <div class="layui-input-block">
                    <input type="text" name="telephonenumber" lay-verify="required" class="layui-input">
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
                url:"${basePath}careworker/create?id="+
                    data.field.id+"&workername="+
                    data.field.workername+"&workerage="+
                    data.field.workerage+"&sex="+
                    data.field.sex+"&birthday="+
                    data.field.birthday+"&height="+
                    data.field.height+"&weight="+
                    data.field.weight+"&workingage="+
                    data.field.workingage+"&nativeplace="+
                    data.field.nativeplace+"&telephonenumber="+
                    data.field.telephonenumber,
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
