//加载公共部分方法
function loading(pageSign, userName){
    var path = $('#ctx').val();
    head(userName, path);
    navigationBar(path);
    permission(pageSign);
    footer();
}

//头部
function head(userName, path){
	var html = "";
	html += '<div class="navbar-container ace-save-state" id="navbar-container">';
	html += '	<div class="navbar-header pull-left">';
	html += '		<a href="'+path+'/index" class="navbar-brand">';
	html += '			<small>';
	html += '				<i class="fa fa-leaf"></i>';
	html += '				Ace 后台管理系统';
	html += '			</small>';
	html += '		</a>';
	html += '	</div>';
	html += '	<div class="navbar-buttons navbar-header pull-right" role="navigation">';
	html += '		<ul class="nav ace-nav">';
	html += '			<li class="light-blue dropdown-modal">';
	html += '				<a data-toggle="dropdown" href="#" class="dropdown-toggle">';
	html += '					<img class="nav-user-photo" src="'+path+'/static/common/assets/images/avatars/user.jpg" alt="Jason Photo" />';
	html += '					<span class="user-info">';
	html += '						<small>Welcome</small>';
	html += '						'+userName+'';
	html += '					</span>';
	html += '					<i class="ace-icon fa fa-caret-down"></i>';
	html += '				</a>';
	html += '				<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">';
	html += '					<li>';
	html += '						<a href="#">';
	html += '							<i class="ace-icon fa fa-cog"></i>';
	html += '							&nbsp;&nbsp;系统设置';
	html += '						</a>';
	html += '					</li>';
	html += '					<li>';
	html += '						<a href="'+path+'/userCenter">';
	html += '							<i class="ace-icon fa fa-user"></i>';
	html += '							&nbsp;&nbsp;个人中心';
	html += '						</a>';
	html += '					</li>';
	html += '					<li class="divider"></li>';
	html += '					<li>';
	html += '						<a href="'+path+'/logout">';
	html += '							<i class="ace-icon fa fa-power-off"></i>';
	html += '							&nbsp;&nbsp;退出登录';
	html += '						</a>';
	html += '					</li>';
	html += '				</ul>';
	html += '			</li>';
	html += '		</ul>';
	html += '	</div>';
	html += '</div>';
	
   $("#navbar").html(html); 
}

//左导航栏
function navigationBar(path){
	var html = "";

    html += '<div class="sidebar-shortcuts" id="sidebar-shortcuts">';
    html += '    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">';
    html += '		<button class="btn btn-success"><i class="ace-icon fa fa-signal"></i></button>';
    html += '		<button class="btn btn-info"><i class="ace-icon fa fa-pencil"></i></button>';
    html += '		<button class="btn btn-warning"><i class="ace-icon fa fa-users"></i></button>';
    html += '		<button class="btn btn-danger"><i class="ace-icon fa fa-cogs"></i></button>';
    html += '    </div>';
        //<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
		//	<span class="btn btn-success"></span><span class="btn btn-info"></span><span class="btn btn-warning"></span><span class="btn btn-danger"></span>
    	//</div>
    html += '</div>';
	
	html += '<script type="text/javascript">';
	html += '	try{ace.settings.loadState(\'sidebar\')}catch(e){}';
	html += '</script>';
	
	//主页
	html += '<ul class="nav nav-list">';
    html += '	<li class="" id="index">';
	html += '		<a href="'+path+'/index">';
	html += '			<i class="menu-icon fa fa-tachometer"></i>';
	html += '			<span class="menu-text"> 主页 </span>';
    html += '    		<input type="hidden" id="currentUserLevel" value=""/>';
    html += '    		<input type="hidden" id="currentUserId" value=""/>';
	html += '		</a>';	
	html += '		<b class="arrow"></b>';
	html += '	</li>';
	
	//用户
    html += '	<li class="" id="user">';
	html += '		<a href="#" class="dropdown-toggle">';
	html += '			<i class="menu-icon fa fa-pencil-square-o"></i>';
	html += '			<span class="menu-text">';
	html += '				用户管理';
	html += '			</span>';	
	html += '			<b class="arrow fa fa-angle-down"></b>';
	html += '		</a>';	
	html += '		<b class="arrow"></b>';	
	html += '		<ul class="submenu">';
    html += '			<li class="" id="userCenter"><a href="'+path+'/userCenter"><i class="menu-icon fa fa-caret-right"></i>个人中心</a><b class="arrow"></b></li>';
    html += '			<li class="" id="userList"><a href="'+path+'/userList"><i class="menu-icon fa fa-caret-right"></i>用户列表</a><b class="arrow"></b></li>';
	html += '		</ul>';
	html += '	</li>';
	
	//app
	html += '	<li class="" id="app">';
	html += '		<a href="#" class="dropdown-toggle">';
	html += '			<i class="menu-icon fa fa-tag"></i>';
	html += '			<span class="menu-text">';
	html += '				APP管理';
	html += '			</span>';	
	html += '			<b class="arrow fa fa-angle-down"></b>';
	html += '		</a>';	
	html += '		<b class="arrow"></b>';	
	html += '		<ul class="submenu">';			
	html += '			<li class="" id="appList"><a href="'+path+'/appList"><i class="menu-icon fa fa-caret-right"></i>APP</a><b class="arrow"></b></li>';
	html += '			<li class="" id="appSlot"><a href="'+path+'/appSlotList"><i class="menu-icon fa fa-caret-right"></i>广告位</a><b class="arrow"></b></li>';
	html += '			<li class="" id="appStatisticsManage"><a href="'+path+'/appStatisticsManage"><i class="menu-icon fa fa-caret-right"></i>收益统计(管理)</a><b class="arrow"></b></li>';
	html += '			<li class="" id="appStatisticsUser"><a href="'+path+'/appStatisticsUser"><i class="menu-icon fa fa-caret-right"></i>收益统计</a><b class="arrow"></b></li>';
    html += '			<li class="" id="appReport"><a href="'+path+'/appReportList"><i class="menu-icon fa fa-caret-right"></i>上报统计</a><b class="arrow"></b></li>';
    html += '			<li class="" id="appUpstream"><a href="'+path+'/appUpstreamList"><i class="menu-icon fa fa-caret-right"></i>上游设置</a><b class="arrow"></b></li>';
    html += '			<li class="" id="httpRequest"><a href="'+path+'/httpRequest"><i class="menu-icon fa fa-caret-right"></i>广告请求</a><b class="arrow"></b></li>';
    html += '			<li class="" id="appUploadUCExcel"><a href="'+path+'/appUploadUCExcel"><i class="menu-icon fa fa-caret-right"></i>上传UCExcel</a><b class="arrow"></b></li>';
    html += '			<li class="" id="appUploadExcel"><a href="'+path+'/appUploadExcel"><i class="menu-icon fa fa-caret-right"></i>上传Excel(旧)</a><b class="arrow"></b></li>';
    html += '			<li class="" id="appUploadOtherExcel"><a href="'+path+'/appUploadOtherExcel"><i class="menu-icon fa fa-caret-right"></i>上传Excel(新)</a><b class="arrow"></b></li>';
	html += '		</ul>';
	html += '	</li>';
	
	//web
	html += '	<li class="" id="web">';
	html += '		<a href="#" class="dropdown-toggle">';
	html += '			<i class="menu-icon fa fa-desktop"></i>';
	html += '			<span class="menu-text">';
	html += '				WEB管理';
	html += '			</span>';	
	html += '			<b class="arrow fa fa-angle-down"></b>';
	html += '		</a>';	
	html += '		<b class="arrow"></b>';	
	html += '		<ul class="submenu">';			
	html += '			<li class="" id="webList"><a href="'+path+'/webList"><i class="menu-icon fa fa-caret-right"></i>WEB</a><b class="arrow"></b></li>';
	html += '			<li class="" id="webAdspace"><a href="'+path+'/webAdspaceList"><i class="menu-icon fa fa-caret-right"></i>广告位</a><b class="arrow"></b></li>';
	html += '			<li class="" id="webStatistics"><a href="'+path+'/webStatistics"><i class="menu-icon fa fa-caret-right"></i>收益统计</a><b class="arrow"></b></li>';
	html += '			<li class="" id="webUpstreamTypeList"><a href="'+path+'/webUpstreamTypeList"><i class="menu-icon fa fa-caret-right"></i>上游信息</a><b class="arrow"></b></li>';
	html += '			<li class="" id="webReadExcel"><a href="'+path+'/webReadExcel"><i class="menu-icon fa fa-caret-right"></i>上传Excel</a><b class="arrow"></b></li>';
	html += '			<li class="" id="webUploadExcel"><a href="'+path+'/webUploadExcel"><i class="menu-icon fa fa-caret-right"></i>上传Excel(新)</a><b class="arrow"></b></li>';
	html += '		</ul>';
	html += '	</li>';

    //微信分享
    html += '	<li class="" id="article">';
    html += '		<a href="#" class="dropdown-toggle">';
    html += '			<i class="menu-icon fa fa-bookmark"></i>';
    html += '			<span class="menu-text">';
    html += '				文章分享';
    html += '			</span>';
    html += '			<b class="arrow fa fa-angle-down"></b>';
    html += '		</a>';
    html += '		<b class="arrow"></b>';
    html += '		<ul class="submenu">';
    html += '			<li class="" id="articleList"><a href="'+path+'/articleList"><i class="menu-icon fa fa-caret-right"></i>广告位</a><b class="arrow"></b></li>';
    html += '			<li class="" id="articleStatisticsList"><a href="'+path+'/articleStatisticsList"><i class="menu-icon fa fa-caret-right"></i>收益统计</a><b class="arrow"></b></li>';
    html += '		</ul>';
    html += '	</li>';

    //优酷
    html += '	<li class="" id="yk">';
    html += '		<a href="#" class="dropdown-toggle">';
    html += '			<i class="menu-icon fa fa-coffee"></i>';
    html += '			<span class="menu-text">';
    html += '				优酷管理';
    html += '			</span>';
    html += '			<b class="arrow fa fa-angle-down"></b>';
    html += '		</a>';
    html += '		<b class="arrow"></b>';
    html += '		<ul class="submenu">';
    html += '			<li class="" id="ykAdvertiser"><a href="'+path+'/ykAdvertiser"><i class="menu-icon fa fa-caret-right"></i>广告主信息</a><b class="arrow"></b></li>';
    html += '			<li class="" id="ykAd"><a href="'+path+'/ykAd"><i class="menu-icon fa fa-caret-right"></i>广告素材</a><b class="arrow"></b></li>';
    html += '		</ul>';
    html += '	</li>';

	//临时
	html += '	<li class="" id="temporary">';
	html += '		<a href="#" class="dropdown-toggle">';
	html += '			<i class="menu-icon fa fa-list"></i>';
	html += '			<span class="menu-text">';
	html += '				临时统计';
	html += '			</span>';	
	html += '			<b class="arrow fa fa-angle-down"></b>';
	html += '		</a>';	
	html += '		<b class="arrow"></b>';	
	html += '		<ul class="submenu">';			
	html += '			<li class="" id="temporaryAdd"><a href="'+path+'/temporaryAdd"><i class="menu-icon fa fa-caret-right"></i>添加</a><b class="arrow"></b></li>';
	html += '			<li class="" id="temporaryList"><a href="'+path+'/temporaryList"><i class="menu-icon fa fa-caret-right"></i>展示</a><b class="arrow"></b></li>';
	html += '			<li class="" id="copyAdd"><a href="'+path+'/copyAdd"><i class="menu-icon fa fa-caret-right"></i>标准合作添加</a><b class="arrow"></b></li>';
	html += '			<li class="" id="copyList"><a href="'+path+'/copyList"><i class="menu-icon fa fa-caret-right"></i>标准合作展示</a><b class="arrow"></b></li>';
	html += '		</ul>';
	html += '	</li>';
	
	html += '</ul>';
	
	html += '<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">';
	html += '	<i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>';
	html += '</div>';
	

    
	$("#sidebar").html(html);
}

//页面底部
function footer(){
	var html = "";

    html += '<div class="footer-inner">';
    html += '    <div class="footer-content">';
    html += '    <span class="bigger-120">';
    html += '    <span class="blue bolder">Ace</span>';
    html += '		Application &copy; 2019-2020';
    html += '	 </span>';
    html += '		&nbsp; &nbsp;';
    html += '	 <span class="action-buttons">';
    html += '        <a href="#"><i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i></a>';
    html += '   	 <a href="#"><i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i></a>';
    html += '  		 <a href="#"><i class="ace-icon fa fa-rss-square orange bigger-150"></i></a>';
    html += '  	 </span>';
    html += ' 	 </div>';
    html += '</div>';

    $("#footer").html(html);
}

//展示效果和权限
function permission(pageSign){
    var currentUserLevel = $('#currentUserLevel').val();
    if(currentUserLevel == 3){
        $('#userList').hide();
        $('#appDivided').hide();
        $('#appReport').hide();
        $('#appStatisticsManage').hide();
        $('#appUpstream').hide();
        $('#webDivided').hide();
        $('#temporary').hide();
        $('#yk').hide();
        $('#httpRequest').hide();
        $('#webUpstreamTypeList').hide();
        $('#webReadExcel').hide();
        $('#appUploadUCExcel').hide();
        $('#appUploadExcel').hide();
        $('#appUploadOtherExcel').hide();
        $('#webUploadExcel').hide();

	}

    if (pageSign == "index"){
        $('#index').addClass('active');
    }else if (pageSign == "userCenter"){
        $('#user').addClass('active open');
        $('#userCenter').addClass('active');
    }else if (pageSign == "userList"){
        $('#user').addClass('active open');
        $('#userList').addClass('active');

    //app页面
    }else if (pageSign == "appList"){
        $('#app').addClass('active open');
        $('#appList').addClass('active');
    }else if (pageSign == "appDetail"){
        $('#app').addClass('active open');
        $('#appList').addClass('active');
    }else if (pageSign == "appSlotList"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');
    }else if (pageSign == "appSlotAdd"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');
    }else if (pageSign == "appSlotUpstreamList"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');
    }else if (pageSign == "appSlotAddUpstream"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');
    }else if (pageSign == "appAssign"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');
    }else if (pageSign == "appStatisticsAdd"){
        $('#app').addClass('active open');
        $('#appStatistics').addClass('active');
    }else if (pageSign == "appStatisticsManage"){
        $('#app').addClass('active open');
        $('#appStatisticsManage').addClass('active');
    }else if (pageSign == "appStatisticsUser"){
        $('#app').addClass('active open');
        $('#appStatisticsUser').addClass('active');
    }else if (pageSign == "appDivided"){
        $('#app').addClass('active open');
        $('#appDivided').addClass('active');
    }else if (pageSign == "appReportList"){
        $('#app').addClass('active open');
        $('#appReport').addClass('active');
    }else if (pageSign == "appUpstreamList"){
        $('#app').addClass('active open');
        $('#appUpstream').addClass('active');
    }else if (pageSign == "appUpstreamAdd"){
        $('#app').addClass('active open');
        $('#appUpstream').addClass('active');
    }else if (pageSign == "appUpstreamIdList"){
        $('#app').addClass('active open');
        $('#appUpstream').addClass('active');
    }else if (pageSign == "appUpstreamIdEdit"){
        $('#app').addClass('active open');
        $('#appUpstream').addClass('active');
    }else if (pageSign == "httpRequest"){
        $('#app').addClass('active open');
        $('#httpRequest').addClass('active');
    }else if (pageSign == "appUploadUCExcel"){
        $('#app').addClass('active open');
        $('#appUploadUCExcel').addClass('active');
    }else if (pageSign == "appUploadExcel"){
        $('#app').addClass('active open');
        $('#appUploadExcel').addClass('active');
    }else if (pageSign == "appUploadOtherExcel"){
        $('#app').addClass('active open');
        $('#appUploadOtherExcel').addClass('active');
    }else if (pageSign == "appSlotReport"){
        $('#app').addClass('active open');
        $('#appSlot').addClass('active');

	//web页面
    }else if (pageSign == "webList"){
        $('#web').addClass('active open');
        $('#webList').addClass('active');
    }else if (pageSign == "webDetail"){
        $('#web').addClass('active open');
        $('#webList').addClass('active');
    }else if (pageSign == "webAdspaceList"){
        $('#web').addClass('active open');
        $('#webAdspace').addClass('active');
    }else if (pageSign == "webAdspaceAdd"){
        $('#web').addClass('active open');
        $('#webAdspace').addClass('active');
    }else if (pageSign == "webStatisticsAdd"){
        $('#web').addClass('active open');
        $('#webStatistics').addClass('active');
    }else if (pageSign == "webStatisticsUser"){
        $('#web').addClass('active open');
        $('#webStatistics').addClass('active');
    }else if (pageSign == "webStatisticsManage"){
        $('#web').addClass('active open');
        $('#webStatistics').addClass('active');
    }else if (pageSign == "webUpstreamTypeList"){
        $('#web').addClass('active open');
        $('#webUpstreamTypeList').addClass('active');
    }else if (pageSign == "webDivided"){
        $('#web').addClass('active open');
        $('#webDivided').addClass('active');
    }else if (pageSign == "webReadExcel"){
        $('#web').addClass('active open');
        $('#webReadExcel').addClass('active');
    }else if (pageSign == "webUploadExcel"){
        $('#web').addClass('active open');
        $('#webUploadExcel').addClass('active');

    //文章分享
    }else if (pageSign == "articleList"){
        $('#article').addClass('active open');
        $('#articleList').addClass('active');
    }else if (pageSign == "articleStatisticsList"){
        $('#article').addClass('active open');
        $('#articleStatisticsList').addClass('active');

    //优酷
    }else if (pageSign == "ykAdvertiser"){
        $('#yk').addClass('active open');
        $('#ykAdvertiser').addClass('active');
    }else if (pageSign == "ykAd"){
        $('#yk').addClass('active open');
        $('#ykAd').addClass('active');

    //临时
    }else if (pageSign == "temporaryAdd"){
        $('#temporary').addClass('active open');
        $('#temporaryAdd').addClass('active');
    }else if (pageSign == "temporaryList"){
        $('#temporary').addClass('active open');
        $('#temporaryList').addClass('active');
    }else if (pageSign == "copyAdd"){
        $('#temporary').addClass('active open');
        $('#copyAdd').addClass('active');
    }else if (pageSign == "copyList"){
        $('#temporary').addClass('active open');
        $('#copyList').addClass('active');
    }
}

