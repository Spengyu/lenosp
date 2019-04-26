<#--Created by IntelliJ IDEA.
User: Administrator
Date: 2017/12/7
Time: 12:40
To change this template use File | Settings | File Templates.-->

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>用户管理</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
  <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
  <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js" charset="utf-8"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
</head>

<body>
  <form class="layui-form" action="">
      <div class="layui-form-item">
          <label class="layui-form-label">老师姓名</label>
          <div class="layui-input-block">
              <input type="text" name="teacName" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
          </div>
      </div>
      <div class="layui-form-item">
          <label class="layui-form-label">年龄</label>
          <div class="layui-input-block">
              <input type="text" name="teacAge" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
          </div>
      </div>
      <div class="layui-form-item">
          <label class="layui-form-label">单选框</label>
          <div class="layui-input-block">
              <input type="radio" name="teacSex" value="1" title="男" checked="">
              <input type="radio" name="teacSex" value="2" title="女">
              <input type="radio" name="teacSex" value="0" title="禁用" disabled="">
          </div>
      </div>
      <div class="layui-form-item">
          <div class="layui-inline">
              <label class="layui-form-label">生日</label>
              <div class="layui-input-inline">
                  <input type="text" name="teacBir" class="layui-input" id="test1" placeholder="yyyy-MM-dd">
              </div>
          </div>
      </div>
      <div class="layui-form-item">
          <label class="layui-form-label">复选框</label>
          <div class="layui-input-block">
              <input type="checkbox" name="teacJineng" value="1" title="Java">
              <input type="checkbox" name="teacJineng" value="2" title="Jquery" checked="">
              <input type="checkbox" name="teacJineng" value="3" title="Js">
          </div>
      </div>
      <div style="width: 100%;height: 55px;background-color: white;border-top:1px solid #e6e6e6;
  position: fixed;bottom: 1px;margin-left:-20px;">
          <div class="layui-form-item" style=" float: right;margin-right: 30px;margin-top: 8px">

              <button  class="layui-btn layui-btn-normal" lay-filter="add" lay-submit="">
                  增加
              </button>
              <button  class="layui-btn layui-btn-primary" id="close">
                  取消
              </button>
          </div>
      </div>
  </form>
  </form>
<script>
  var flag,msg;
  layui.use(['form','layer','upload'], function(){
    $ = layui.jquery;
    var form = layui.form
        ,layer = layui.layer,
        upload = layui.upload;

   $('#close').click(function(){
     var index = parent.layer.getFrameIndex(window.name);
     parent.layer.close(index);
   });
    //监听提交
    form.on('submit(add)', function(data){
        var r=document.getElementsByName("role");
        var role=[];
        for(var i=0;i<r.length;i++){
            if(r[i].checked){
                console.info(r[i].value);
                role.push(r[i].value);
            }
        }
        data.field.role=role;
      layerAjax('add', data.field, 'teacherList');
      return false;
    });
    form.render();
  });
</script>
</body>

</html>
