<%--
    重置密码成功的自动跳转页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        p{
            text-align: center;
        }
        span{
            color: red;
        }
    </style>
</head>
<body>
<!--1.显示页面效果<p>-->

<h1 class="text-center">重置密码成功,<span id="time">5</span>秒之后，自动跳转到首页...</h1>

<script>
    var second = 5;
    //定义一个方法，获取span标签，修改span标签体内容，时间--
    function showTime() {
        second--;
        // 判断时间是否 <= 0,则跳转搭配首页
        if (second <= 0) {
            // 跳转到首页
            location.href = "${APP_PATH}/index.htm";
        }
        var time = document.getElementById("time");
        time.innerHTML = second + "";
    }

    // 设置定时器，1秒执行一次该方法
    setInterval(showTime,1000);
</script>
</body>
</html>
