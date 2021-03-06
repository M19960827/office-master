<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>滴答办公系统-班级列表</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="media/layui/css/layui.css" media="all">
<script src="media/js/jquery.min.js"></script>
</head>
<body>
	<div class="layui-container">
		<table id="tbdata" lay-filter="tbop"></table>
		<script type="text/html" id="barop">
    		<a class="layui-btn layui-btn-mini" lay-event="edit">编辑</a>
    		<a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
		</script>
	</div>
	<script src="media/layui/layui.js"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
	layui.use('table', function(){
		  var table = layui.table;
		  
		  //第一个实例
		  table.render({
		    elem: '#tbdata'
		    ,url: '/grade/gradepage.do' //数据接口
		    ,page: true //开启分页
		    ,cols: [[ //表头
		      {field: 'id', title: '序号', sort: true, fixed: 'left'}
		      ,{field: 'name', title: '班级名称'} 
		      ,{field: 'course', title: '学科名称'}
		      ,{field: 'count', title: '班级人数', sort: true}
		      ,{field: 'week', title: '周数', sort: true}
		      ,{field: 'location', title: '位置'}
		      ,{field: 'createdate', title: '开班日期', sort: true}
		      ,{field:'right', title: '操作',toolbar:"#barop"}
		    ]]
			  ,page: true   //开启分页
			  ,limit:5   //默认十条数据一页
			  ,limits:[5,10,15,20]  //数据分页条
			  ,id: 'testReload'
		  });

		  //监听工具条
		  table.on('tool(tbop)', function(obj){
		        var data = obj.data;
		        if(obj.event === 'del'){
		            layer.confirm('是否确认删除班级?', function(index){
		                $.ajax({
		                    url: "/grade/gradedel.do",
		                    type: "POST",
		                    data:"id="+data.id,
		                    success: function(data){
		                        if(data.code==1){
		                            obj.del();//删除表格中的对应行数据
		                            layer.close(index);
		                            layer.msg("删除成功", {icon: 6});
									window.location.href = "gradepage.jsp";
		                        }else{
		                            layer.msg("删除失败", {icon: 5});
		                        }
		                    }
		                });
		            });
		        } else if(obj.event === 'edit'){//编辑 修改
		        	/*//get传递参数有中文，必须编码
		        	//JSON.stringify 将对象转换为字符串
		        	console.log(JSON.stringify(data));
		           location.href="gradeupdate.html?d="+ encodeURI(JSON.stringify(data));
		        }
		});
	});*///get传递参数有中文，必须编码
					//JSON.stringify 将对象转换为字符串
					// location.href="gradeupdate.html?d="+ encodeURI(JSON.stringify(data));
					//点击编辑 》》》弹出框的设置 及ajax
					layer.open({
						area: ['500px', '400px'],
						title: '班级修改',
						type: 2,
						fixed:false,
						maxmin:true,
						content: "gradeupdate.html?d="+ encodeURI(JSON.stringify(data)),//这里content是一个普通的String
						btn: ['确认', '取消'],
						yes: function(index, layero){
							var body = layer.getChildFrame('body', index);
							// var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
							$.ajax({
								url: "/grade/gradeedit.do",
								data: body.find("form").serialize(),
								success: function (obj) {
									if (obj.code == 1) {
										layer.msg("编辑成功");
										table.reload("tbdata");
										window.location.href = "gradepage.jsp";
									} else {
										layer.msg("编辑失败");
									}
								}
							})
							layer.close(index);
						},cancel: function(){
						}
					});
				}
		  });
	});

</script>
</body>
</html>