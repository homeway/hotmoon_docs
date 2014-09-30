Cowboy框架
==========

建立cowboy项目
-------------
###官方指南创建项目的方法
创建应用目录

    mkdir hello_erlang
	cd hello_erlang

下载`erlang.mk`

    wget https://raw.githubusercontent.com/ninenines/erlang.mk/master/erlang.mk
	
使用erlang.mk创建应用结构和发布

    $make -f erlang.mk bootstrap bootstrap-rel

可以执行make操作，生成目录和依赖文件

    $make
	...

这会生成一个初步的Makefile，增加下面一样到Makefile文件：

	DEPS = cowboy

添加应用依赖cowboy到`src/hello_erlang.app.src`，这会要求应用启动前必须先启动cowboy，添加后的app配置如下（顺便修改了应用描述和版本信息）：

    {application, hello_erlang,
	    [ {description, "Hello Erlang!"},
		  {vsn, "0.1.0"},
		  {modules, []},
	      {registered, []},
		  {applications,
		    [ kernel,
			  stdlib,
			  cowboy
			]},
	      {mod, {hello_erlang_app, []}},
		  {env, []}
		]}.

编辑`src/hello_erlang_app.erl`文件，增加路由分派：

    start(_Type, _Args) ->
	    Dispatch = cowboy_router:compile([{'_',[
		    {"/", hello_handler, []}
		]}]),
		cowboy:start_http(my_http_listener, 100, [{port, 8080}],
		    [{env, [{dispatch, Dispatch}]}]
		),
	    hello_erlang_sup:start_link().

使用`erlang.mk`模板添加路由处理函数：

    $ make new t=cowboy_http n=hello_handler

这会生成一个`src/hello_handler.erl`的路由处理文件，可以像下面这样修改其中的handle函数：

    handle(Req, State=#state{}) ->
	%% 可能是文档没有跟上版本升级，cowboy官网误写为 Req2 = cowboy_....
	    {ok, Req2} = cowboy_req:reply(200,
		    [{<<"content-type">>, <<"text/plain">>}],
			<<"Hello Erlang!">>,
			Req),
		{ok, Req2, State}.


再次执行make操作，并启动控制台

    $make
	...
	$ ./_rel/hello_erlang_release/bin/hello_erlang_release console
	...
	(hello_erlang@127.0.0.1)1>	

现在可以用(http://localhost:8080)访问了。

###使用shell和rebar管理cowboy项目
官方管理cowboy项目的问题是，每次修改必须重新执行`make`并重启`./_rel/hello_erlang_release/bin/hello_erlang_release console`，不利于随时编译、随时观察结果。另外，要与Emacs的`erlang shell`集成也非常不变。

但官方提供的`erlang.mk`还是很有用的，不仅提供了一些常用的cowboy生成模板，还提供了完善的cowboy应用发布管理。

顺便提一下使用emacs的理由：

1. 学习emacs是终身收益的投资，世界顶级的程序员都在使用它
2. erlang官方维护着一系列专为emacs下开发erlang的实用扩展和模板

####使用rebar
注意应使用rebar2.5.0，而不是最新的rebar2.5.1（与OTP17无法兼容）。

    $ git clone https://github.com/rebar/rebar.git
	$ cd rebar
	$ fetch origin 2.5.0:2.5.0
	$ git checkout 2.5.0
	$ make
	...
	$ rebar -V
	rebar 2.5.0 17 20140929_142140 git 2.5.0

现在得到了一个2.5.0版本的rebar！

`rebar`是一个常用的工具，建议将`rebar`放入`/usr/bin`。

####管理依赖包的本地副本
如果按照cowboy官网的做法，那么每一次创建cowboy项目时都必须从远程服务器拉回依赖包。下面参考Armstrong的做法来管理依赖包。

第1步，建立一个名为`~/erlang/erlang_imports`的目录。
第2步，在`~/erlang/erlang_imports/rebar.config`中管理所有项目的依赖项：

    {deps, [
	       {cowboy, ".*", {git, "https://github.com/ninenines/cowboy", "1.0.0"}}
		   ]}.

第3步，当`rebar.config`有更新时，在其相同目录下执行`rebar get-deps compile`

这会在`deps`目录中生成依赖文件，并编译成各自的`deps/*/ebin`文件。

第4步，把下面这些代码加入到启动文件`~/.erlang`里：

    %% 设置rebar管理的依赖项ebin位置
	Home = os:getenv("HOME").
	Dir = Home ++ "/erlang/erlang_imports/deps",
	{ok, L} = file:list_dir(Dir).
	lists:foreach(fun(I) ->
	    Path = Dir ++ "/" ++ I ++ "/ebin",
		code:add_path(Path)
	  end, L).

####现建立cowboy项目目录和文件结构
首先建立应用目录

    $ mkdir hello_erlang
	$ cd hello_erlang

然后可以执行`rebar create-app appid=hello_erlang`，或`make -f erlang.mk bootstrap`，两种方法都会生成`src`目录结构。
区别在于，使用`erlang.mk`生成的文件结构中，会多一行配置：

    {mod, { myrest4_app, []}},

若使用`rebar`生成项目，以后使用`make -f erlang.mk`则需要手工增加这一行，否则`erlang.mk`会报错。

####增加cowboy应用依赖
由于在`.erlang`启动文件中已经自动添加了本地依赖副本的所有`deps/*/ebin`目录，因此不需要额外配置项目本地的`rebar.config`。

很关键的一点是，依赖项管理必须使用稳定版本。如cowboy应使用`1.0.0`版本，而不能使用`master`，否则会有不确定的运行时错误发生。

应在`src/hello_erlang.app.src`中增加`cowboy`的运行时依赖：

    {application, hello_erlang_app,
    [
     {description, "This is a cowboy application with pure rebar"},
     {vsn, "0.1.0"},
	 {registered, []},
	 {applications, [
	     kernel,
	     stdlib,
	     cowboy
	   ]},
	 {mod, { hello_erlang_app, []}},
	 {env, [{http_port, 8080}]}
	]}.

####增加路由分配函数
由于cowboy官方提供的`erlang.mk`文件有一些模板可用，因此仍可使用。
以下步骤与cowboy官方创建处理函数时相同：

编辑`src/hello_erlang_app.erl`文件，增加路由分派：

    start(_Type, _Args) ->
	    Dispatch = cowboy_router:compile([{'_',[
		    {"/", hello_handler, []}
		]}]),
		cowboy:start_http(my_http_listener, 100, [{port, 8080}],
		    [{env, [{dispatch, Dispatch}]}]
		),
	    hello_erlang_sup:start_link().

使用`erlang.mk`模板添加路由处理函数：

    $ make new t=cowboy_http n=hello_handler

这会生成一个`src/hello_handler.erl`的路由处理文件，可以像下面这样修改其中的handle函数：

    handle(Req, State=#state{}) ->
	    {ok, Req2} = cowboy_req:reply(200,
		    [{<<"content-type">>, <<"text/plain">>}],
			<<"Hello Erlang!">>,
			Req),
		{ok, Req2, State}.

####增加一个应用启动管理的函数
没有cowboy在`erlang.mk`中提供的应用启动管理参数，我们需要手工启动所有的OTP应用。

建立一个`src/myapp.erl`的启动文件：

    -module(myapp).
	-export([start/0]).
	start() ->
	  ok = application:start(crypto),
	  ok = application:start(ranch),
	  ok = application:start(cowlib),
	  ok = application:start(cowboy),
	  ok = application:start(hello_erlang).

####编译和运行
使用rebar编译：

    $ rebar compile

通过shell启动：

    $ erl -pa ebin -s myapp

查看应用列表：

    1> application:which_applications().

在emacs中，首先执行`C-c C-z`，启动或显示`erlang shell`，然后执行：

    1> code:add_path("../ebin").
	true
	2> myapp:start().
	ok

OTP应用启动后，可在emacs中随时使用`C-c C-k`编译erl源文件，因为目录结构是将`src`和`ebin`部署在根目录下，因此会自动将`src`中的源文件编译到`ebin`中。
