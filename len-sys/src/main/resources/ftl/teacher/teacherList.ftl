<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="${re.contextPath}/plugin/lenos/main.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js"
            charset="utf-8"></script>
</head>
<body>
<body>
<div class="layui-col-md12" style="height:40px;margin-top:3px;">
    <div class="layui-btn-group">
    <@shiro.hasPermission name="user:select">
        <button class="layui-btn layui-btn-normal" data-type="add">
            <i class="layui-icon">&#xe608;</i>新增
        </button>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="user:select">
        <button class="layui-btn layui-btn-normal" data-type="update">
            <i class="layui-icon">&#xe642;</i>编辑
        </button>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="user:del">
        <button class="layui-btn layui-btn-normal" data-type="detail">
            <i class="layui-icon">&#xe605;</i>删除
        </button>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="user:repass">
        <button class="layui-btn layui-btn-normal" data-type="changePwd">
            <i class="layui-icon">&#xe605;</i>修改密码
        </button>
    </@shiro.hasPermission>
    </div>
</div>

<table class="layui-hide" id="teacherList"  lay-filter="teacher"></table>


<script type="text/html" id="barDemo">
    <@shiro.hasPermission name="user:update">
    <a class="layui-btn layui-btn-xs  layui-btn-normal" lay-event="edit">编辑</a>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="user:del">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </@shiro.hasPermission>
</script>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            id: 'teacherList',
            elem: '#teacherList'
            ,url:'/teacher/query'
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [[
                {checkbox: true, fixed: true, width: '5%'}
                ,{field:'teacId', title: 'ID', sort: true}
                ,{field:'teacName', title: '用户名'} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                ,{field:'teacAge', title: '年龄', sort: true}
                ,{field:'teacSex', title: '性别'}
                ,{field:'teacBir', title: '生日'}
                ,{field:'teacJineng', title: '教什么', align: 'center'} //单元格内容水平居中
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,page: true
        });

        /*//监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.email
                }, function(value, index){
                    obj.update({
                        email: value
                    });
                    layer.close(index);
                });
            }
        });*/

        var $ = layui.$, active = {

        add: function () {
            add('添加用户', 'showAddTeacher', 700, 450);
        },
        update: function () {
            var checkStatus = table.checkStatus('teacherList')
                    , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg('请选择一行编辑,已选['+data.length+']行', {icon: 5});
                return false;
            }
            update('编辑用户', 'byId?id=' + data[0].teacId, 700, 450);
        },
        detail: function () {
            var checkStatus = table.checkStatus('teacherList')
                    , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg('请选择一行查看,已选['+data.length+']行', {icon: 5});
                return false;
            }
            layer.confirm('确定删除用户[<label style="color: #00AA91;">' + data[0].teacName + '</label>]?',function (index) {
                $.ajax({
                    type: 'post',
                    url: '/teacher/delTeacher',
                    data: {'id': data[0].teacId},
                    dataType: 'json',
                    success: function (data) {
                        if (data != null) {
                            layer.msg(data.msg, {
                                time: 2000,
                            }, function () {
                                location.reload();
                            });
                        } else {
                            layer.msg("后台操作异常！");
                        }
                    },
                    error: function () {
                        layer.msg("系统异常！");
                    }
                });
            });
        },
        changePwd:function(){
            var checkStatus = table.checkStatus('teacherList')
                    , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg('请选择一个用户,已选['+data.length+']行', {icon: 5});
                return false;
            }
            rePwd('修改密码','goRePass?id='+data[0].id,500,350);
        }
        };

        //监听工具条/
        table.on('toolbar(teacher)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                detail('编辑用户', 'updateUser?id=' + data.id, 700, 450);
            } else if (obj.event === 'del') {
                alert("13422");
                layer.confirm('确定删除用户[<label style="color: #00AA91;">' + data[0].teacName + '</label>]?', {
                    btn: ['逻辑删除', '物理删除']
                }, function () {
                    toolDelByFlag(data.id,'userList',true);
                }, function () {
                    toolDelByFlag(data.id,'userList',false);
                });
            } else if (obj.event === 'edit') {
                update('编辑用户', 'updateUser?id=' + data.id, 700, 450);
            }
        });


        $('.layui-col-md12 .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.select .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

    });
    function rePwd(title,url,w,h){
        if (title == null || title == '') {
            title = false;
        };
        if (url == null || url == '') {
            url = "404.html";
        };
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        };
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        };
        layer.open({
            id: 'user-rePwd',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url,
        });
    }
    function detail(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        };
        if (url == null || url == '') {
            url = "error/404";
        };
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        };
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        };
        layer.open({
            id: 'user-detail',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url + '&detail=true',
            // btn:['关闭']
        });
    }
    /**
     * 更新用户
     */
    function update(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        if (url == null || url == '') {
            url = "404.html";
        }
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        layer.open({
            id: 'user-update',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url + '&detail=false'
        });
    }

    /*弹出层*/
    /*
     参数解释：
     title   标题
     url     请求的url
     id      需要操作的数据id
     w       弹出层宽度（缺省调默认值）
     h       弹出层高度（缺省调默认值）
     */
    function add(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        ;
        if (url == null || url == '') {
            url = "404.html";
        }
        ;
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        ;
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        ;
        layer.open({
            id: 'user-add',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url
        });
    }
</script>
</html>