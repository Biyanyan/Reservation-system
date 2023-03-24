
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>病人管理</title>
</head>
<body>
<div class="layuimini-container layuimini-page-anim">
    <div class="layuimini-main">
        <div style="margin: 10px">
            <form class="layui-form layui-form-pane">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">病人姓名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="patientname" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">医院</label>
                        <div class="layui-input-inline">
                            <input type="text" name="hospital" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-primary"  lay-submit lay-filter="search-btn"><i class="layui-icon"></i> 搜 索</button>
                    </div>
                </div>
            </form>
        </div>
        <script type="text/html" id="toolbar">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">
                    <i class="fa fa-plus"></i>
                    添加
                </button>
                <button class="layui-btn layui-btn-sm layui-btn-normal data-delete-btn" lay-event="update">
                    <i class="fa fa-pencil"></i>
                    修改
                </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete">
                    <i class="fa fa-remove"></i>
                    删除
                </button>
            </div>
        </script>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
    </div>
</div>

<script>
    layui.use(['form','table'],function (){

        var $ = layui.jquery,
            form = layui.form;
        var table = layui.table;

        table.render({
            elem:'#currentTableId',
            url:'${basePath}patient/query',
            method:'post',
            contentType:'application/json',
            toolbar: '#toolbar',
            defaultToolbar: ['filter', 'exports', 'print'],
            page: true,
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID'},
                {field: 'patientname',  title: '客户姓名'},
                {field: 'sex', title: '性别'},
                {field: 'height',  title: '身高'},
                {field: 'weight',  title: '体重'},
                {field: 'hospital', title: '医院'},
                {field: 'address', title: '病房'},
                {field: 'username1', title: '家属',templet:'<div>{{d.user.username1}}</div>'},
                {field: 'relationship', title: '与客户关系'},
            ]],
            response: {
                'statusName': 'code' //规定数据状态的字段名称，默认：code
                ,statusCode: 1000 //规定成功的状态码，默认：0
                ,msgName: 'msg' //规定状态信息的字段名称，默认：msg
                ,countName: 'count' //规定数据总数的字段名称，默认：count
                ,dataName: 'data' //规定数据列表的字段名称，默认：data
            },
            skin: 'line',
            done:function (e) {
                console.log("e:",e)
                return e.data
            }
        });

        // 监听搜索操作
        //1、执行表单查询
        //2、表格reload
        form.on('submit(search-btn)', function (data) {
            //执行搜索重载
            console.log(data.field);
            table.reload('currentTableId', {
                url:"${basePath}patient/query?patientname="+
                    data.field.patientname+"&hospital="+
                    data.field.hospital,
                contentType:'application/json',
                // where: data.field
            }, 'data');

            return false;


        });

        /**
         * toolbar事件监听
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {   // 监听添加操作
                var index = layer.open({
                    title: '添加客户',
                    type: 2,
                    shade: 0.2,
                    shadeClose: false,
                    area: ['50%', '50%'],
                    content: 'patient/add',
                    end:function(){
                        table.reload('currentTableId');
                    }
                });
            } else if (obj.event === 'update') {  // 监听修改操作
                var checkStatus = table.checkStatus('currentTableId');
                var data = checkStatus.data;
                if(data.length !=1){
                    layer.msg("请选择一行数据修改",{time:1000});
                    return;
                }
                var index = layer.open({
                    title: '修改客户',
                    type: 2,
                    shade: 0.2,
                    shadeClose: false,
                    area: ['50%', '50%'],
                    content: 'patient/detail/'+data[0].id,
                    end:function(){
                        table.reload('currentTableId');
                    }
                });
            }else if (obj.event === 'delete') { // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId');//表格的选中状态
                var data = checkStatus.data;
                console.log(data);
                if(data.length ==0){
                    layer.msg("请选择行数据删除",{time:1000});
                    return;
                }
                var arr = [];
                for(index in data){
                    arr.push(data[index].id);//所有id传到arr数组里
                }
                layer.confirm('真的删除行吗', function (index) {
                    $.ajax({
                        url:"${basePath}patient/delete",
                        type:"POST",
                        dataType:'json',
                        data:"ids="+arr.join(","),
                        success:function(data){
                            layer.msg(data.msg,{time:500},
                                function(){
                                    table.reload("currentTableId");
                                });
                        }
                    });
                });
            }
        });

    });
</script>

</body>

</html>
