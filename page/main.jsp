<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        .layui-card-body ul {
            list-style: none;
        }

        .layui-card-body ul li {
            float: left;
            padding: 5px;
        }

        .layui-card-body ul li:hover {
            background-color: #f0f0f0;
        }

        .layui-card-body ul li table {
            width: 150px;
        }

        .layui-card-body ul li table i {
            font-size: 36px;
            color: #1aa094
        }

        .layui-card-body ul li table .number {
            font-size: 24px;
            color: red
        }

        .layui-card-body ul li table .txt {
            color: #888888;
        }
    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15" style="margin-top: 10px;">
        <div class="layui-col-md12">
            <div class="layui-card" style="height: 125px">
                <div class="layui-card-header">系统概览</div>
                <div class="layui-card-body">
                    <ul>

                        <li>
                            <table>
                                <tr>
                                    <td rowspan="2" align="center">
                                        <i class="layui-icon layui-icon-carousel"></i>
                                    </td>
                                    <td class="number" id="user">${userCnt}</td>
                                </tr>
                                <tr>
                                    <td class="txt">用户数量</td>
                                </tr>
                            </table>
                        </li>
<%--                        <li>--%>
<%--                            <table>--%>
<%--                                <tr>--%>
<%--                                    <td rowspan="2" align="center">--%>
<%--                                        <i class="layui-icon layui-icon-file"></i>--%>
<%--                                    </td>--%>
<%--                                    <td class="number" id="course">0</td>--%>
<%--                                </tr>--%>
<%--                                <tr>--%>
<%--                                    <td class="txt">病人数量</td>--%>
<%--                                </tr>--%>
<%--                            </table>--%>
<%--                        </li>--%>
                        <li>
                            <table>
                                <tr>
                                    <td rowspan="2" align="center">
                                        <i class="layui-icon layui-icon-group"></i>
                                    </td>
                                    <td class="number" id="careworker">${careworkerCnt}</td>
                                </tr>
                                <tr>
                                    <td class="txt">护工数量</td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table>
                                <tr>
                                    <td rowspan="2" align="center">
                                        <i class="layui-icon layui-icon-user"></i>
                                    </td>
                                    <td class="number" id="patient">${patientCnt}</td>
                                </tr>
                                <tr>
                                    <td class="txt">客户数量</td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table>
                                <tr>
                                    <td rowspan="2" align="center">
                                        <i class="layui-icon layui-icon-form"></i>
                                    </td>
                                    <td class="number" id="order">${orderCnt}</td>
                                </tr>
                                <tr>
                                    <td class="txt">订单数量</td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table>
                                <tr>
                                    <td rowspan="2" align="center">
                                        <i class="layui-icon layui-icon-menu-fill"></i>
                                    </td>
                                    <td class="number" id="evaluate">${evaluateCnt}</td>
                                </tr>
                                <tr>
                                    <td class="txt">评价数量</td>
                                </tr>
                            </table>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15" style="margin-top: 10px;">
        <div class="layui-col-md8">
            <div class="layui-card">
                <div class="layui-card-header">数量</div>
                <div class="layui-card-body">
                    <div style="height: 300px" id="container">
                        ddd
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">功能区</div>
                <div class="layui-card-body">
                    <div style="height: 300px">

                    </div>
                </div>
            </div>
        </div>
    </div>


<%--    <div class="layui-row layui-col-space15">--%>
<%--        <div class="layui-col-md8">--%>
<%--            <div class="layui-card">--%>
<%--                <div class="layui-card-header">课程平均成绩</div>--%>
<%--                <div class="layui-card-body">--%>
<%--                    <div style="height: 300px" id="container2">--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="layui-col-md4">--%>
<%--            <div class="layui-card">--%>
<%--                <div class="layui-card-header">功能区</div>--%>
<%--                <div class="layui-card-body">--%>
<%--                    <div style="height: 300px">--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

</div>


<script>
    layui.use(['echarts'], function () {
        var echarts = layui.echarts,$ = layui.jquery;
        $.ajax({
            url:"${basePath}sum",
            type:"POST",
            dataType:'json',
            success:function(data){
                console.log("首页 data:",data.data)
                $('#user').html(data.data.userCnt);
                $('#patient').html(data.data.patientCnt);
                $('#order').html(data.data.orderCnt);
                $('#evaluate').html(data.data.evaluateCnt);
                $('#careworker').html(data.data.careworkerCnt);
                const item = data.data;
                var echartsRecords = echarts.init(document.getElementById("container"));
                option = {
                    xAxis: {
                        type: 'category',
                        data: ['用户数量', '护工数量', '客户数量', '订单数量', '评价数量']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: [item.userCnt, item.patientCnt, item.orderCnt, item.evaluateCnt, item.careworkerCnt],
                        type: 'bar',
                        showBackground: true,
                        backgroundStyle: {
                            color: 'rgba(220, 220, 220, 0.8)'
                        }
                    }]
                };
                echartsRecords.setOption(option);

            }
        });
        //1、统计数量


        <%--//2、统计课程平均成绩--%>
        <%--var echartsRecords2 = echarts.init(document.getElementById("container2"));--%>
        <%--option2 = {--%>
        <%--    xAxis: {--%>
        <%--        type: 'category',--%>
        <%--        data: [--%>
        <%--            <c:forEach items="${scoreList}" var="score">--%>
        <%--            '${score.clazzName}-${score.courseName}',--%>
        <%--            </c:forEach>--%>
        <%--        ]--%>
        <%--    },--%>
        <%--    yAxis: {--%>
        <%--        type: 'value'--%>
        <%--    },--%>
        <%--    series: [{--%>
        <%--        data: [--%>
        <%--            <c:forEach items="${scoreList}" var="score">--%>
        <%--            ${score.avgscore},--%>
        <%--            </c:forEach>--%>
        <%--        ],--%>
        <%--        type: 'bar',--%>
        <%--        showBackground: true,--%>
        <%--        backgroundStyle: {--%>
        <%--            color: 'rgba(220, 220, 220, 0.8)'--%>
        <%--        }--%>
        <%--    }]--%>
        <%--};--%>
        <%--echartsRecords2.setOption(option2);--%>

        //echarts 窗口缩放自适应
        window.onresize = function(){
            echartsRecords.resize();
        }
    });
</script>
</body>
</html>
