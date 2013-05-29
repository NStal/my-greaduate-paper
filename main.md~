# Title: An HTML5 WebBased Base 3D rendering Game,一款基于HTML5 WebGL的3D建模工具
# 简介
keyword: WebGL html5 websocket 3D 物理引擎 跨平台游戏 threejs nodejs
这是一款利用了websocket,html5,webgl,nodejs等新技术编写的一款3D多人联机对战游戏.在很长一段时间里web仅仅使用做普通的网页浏览并没有用作别的什么更加复杂的活动,而如今随着w3c组织的活跃和各大浏览器厂商的不断创新和尝试,web平台被赋予了更多的价值可能性.随着新的HTML5的API的开放比如webgl和websocket,在浏览器上有了发展新的应用的可能性了.另一方面通过使用javascript的后端渲染技术--nodejs,我们能够更好的实现跨平的兼容,甚至前端和后端共享一份代码,而本文就为探索这种可能性做了一次尝试. 探索了跨同台的web3D游戏的制作.


# 正文
## 研究背景
随着时间和科技的发展,各种各样的平台出现了,随着时间段的推移,新的平台会出现,人们有序要对新的平台进行开发.这样会消耗大量的成本。那么为了避免这种问题,我们可以选择在虚拟机上开发程序(比如使用Java)或者选择用浏览器(Web)这种在任何设备上都能兼容运行的程序来编写我们的通用程序.

之前有许多前人探索了在Web上利用HTML5+WebSocket开发游戏的功能,比如Mozilla开发的2D平面多人RPG游戏 http://browserquest.mozilla.org/, 也有人探索了Web上基于HTML5+ WebGL的3D游戏,而本文则结合了两者的突破,开发了一款基于HTML5+WebSocket+WebGL所开发的一款多人3D对战游戏x-nolava.通过这样一种尝试探索了web开发的新的可能性,向着把不同应用推向web的工作更加的推进了一步,希望能给后面制作的人一些参考意义。

## 技术背景
### W3C介绍
1.W3C 指（World Wide Web Consortium）,中文意思是W3C理事会或万维网联盟.
2.W3C 是一个会员组织,是由 Tim Berners-Lee 创建,目前是万维网联盟的主任.
3.W3C 创建于1994年10月.
4.W3C 标准被称为 W3C 推荐（W3C Recommendations）.
5.W3C 的主要核心工作是对 web 进行标准化 .
6.W3C 创建并维护 WWW 标准.
7.W3C组织是一个非赢利组织
W3C为解决 Web 应用中不同平台、技术和开发者带来的不兼容问题，保障 Web 信息的顺利和完整流通，万维网联盟制定了一系列标准并督促 Web 应用开发者和内容提供者遵循这些标准。标准的内容包括使用语言的规范，开发中使用的导则和解释引擎的行为等等。W3C也制定了包括XML和CSS等的众多影响深远的标准规范。 但是，W3C 制定的 web 标准似乎并非强制而只是推荐标准。因此部分网站仍然不能完全实现这些标准。特别是使用早期所见即所得网页编辑软件设计的网页往往会包含大量非标准代码。

本文中所使用的技术除了nodejs其他全部都是W3C制定的标准并且后面由浏览器厂商实现的.

### html5 介绍
![html5 logo](http://www.1stwebdesigner.com/wp-content/uploads/2013/02/html5_logo.png)
HTML5与CSS3和仍处于发展。 W3C计划明年发布一个稳定的版本，但它仍然看起来像这是一个长镜头。自其发布以来，HTML5一直在不断的发展中，与W3C添加更多和更令人印象深刻的功能，因此，HTML5的发展将很快结束，这不一定是坏事，这似乎不太可能。

HTML5是HTML4.01的继任者，在1999年首次发布。互联网自1999年已经显著的发生了改变，HTML5创建是必要的。根据预先设定的标准开发新的标记语言,包括了一下的一些特性：

新特性应该基于HTML，CSS，DOM和JavaScript。
需要外部插件（如Flash），需要减少。
错误处理应该是比以前的版本更容易。
脚本具有多个标记来取代。
HTML5应该是与设备无关的。
的发展过程应该是向公众可见。
HTML5包含大量的原来本地应用才可能使用的优质API。

### WebGL
WebGL的（Web图形库）是一个JavaScript API渲染交互式3D图形和2D图形在任何兼容的Web浏览器运行库，无需使用插件。 WebGL是完全集成到所有的Web标准的浏览器允许使用GPU加速的物理和图像处理效果的网页Canvas。 WebGL的元素，可混有其他HTML元素并合成 WebGL的计划包括控制在JavaScript编写的代码和着色器执行的代码,来对电脑的图形处理单元（GPU）的页面或页面背景的其他部分的控制。 ，WebGL是设计和维护由Khronos集团非营利。

WebGL是基于OpenGL ES 2.0的3D图形，并提供了一个API。为了安全起见，GL_ARB_robustness（的OpenGL3.x的）或GL_EXT_robustness（OpenGL ES的）是必要的。它使用HTML5 canvas元素和使用文档对象模型接口访问。自动内存管理是JavaScript语言的一部分。
WebGL缺乏OpenGL 3.0的矩阵数学方法。而此功能是通过使用JavaScript代码空间的用户来完成，这经常辅以必要的代码矩阵库，如glMatrix，TDL，或MJS来实现。

### WebSocket
WebSocket是HTML5开始提供的一种浏览器与服务器间进行全双工通讯的网络技术。 WebSocket通信协定于2011年被IETF定为标准 RFC 6455，WebSocketAPI被W3C定为标准。
在WebSocket API中，浏览器和服务器只需要要做一个握手的动作，然后，浏览器和服务器之间就形成了一条快速通道。两者之间就直接可以数据互相传送。

现在，很多网站为了实现推送技术，所用的技术都是轮询。轮询是在特定的的时间间隔（如每1秒），由浏览器对服务器发出HTTP request，然后由服务器返回最新的数据给客户端的浏览器。这种传统的模式带来很明显的缺点，即浏览器需要不断的向服务器发出请求，然而HTTP request 的header是非常长的，里面包含的数据可能只是一个很小的值，这样会占用很多的带宽和服务器资源。
而比较新的技术去做轮询的效果是Comet，使用了AJAX。但这种技术虽然可达到双向通信，但依然需要发出请求，而且在Comet中，普遍采用了长链接，这也会大量消耗服务器带宽和资源。
面对这种状况，HTML5定义了WebSocket协议，能更好的节省服务器资源和带宽并达到实时通讯。

服务器与客户端之间交换的标头信息很小，大概只有2字节。（早期版本）
服务器推送 [编辑]
服务器可以主动传送数据给客户端。
握手协议 [编辑]

在实现websocket连线过程中，需要透过浏览器发出websocket连线请求，然后服务器发出回应，这个过程通常称为“握手” (handshaking)。
PS:后期的版本大多属于功能上的扩充，例如使用第7版的握手协议同样也适用于第8版的握手协议。
例子 [编辑]
为第13版且浏览器为Chrome的例子
浏览器请求

```GET / HTTP/1.1
Upgrade: websocket
Connection: Upgrade
Host: example.com
Origin: null
Sec-WebSocket-Key: sN9cRrP/n9NdMgdcy2VJFQ==
Sec-WebSocket-Version: 13```

服务器回应
``HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: fFBooB7FAkLlXgRSz0BT3v4hq5s=
Sec-WebSocket-Origin: null
Sec-WebSocket-Location: ws://example.com/```

在请求中的“Sec-WebSocket-Key”是随机的，服务器端会用这些数据来构造出一个SHA-1的信息摘要。
把“Sec-WebSocket-Key”加上一个魔幻字符串“258EAFA5-E914-47DA-95CA-C5AB0DC85B11”。使用 SHA-1 加密，之后进行 BASE-64编码，将结果做为 “Sec-WebSocket-Accept” 头的值，返回给客户端。
实现websocket的协议，浏览器扮演着一个很重要的角色。Google在它的Google Chrome支持了websocket，Chrome 5 之后的版本都支持websocket，但因为websocket还未最终版本，草案不断更新，所以不同的版本会支持不同的草案。

苹果公司的Safari浏览器也支持websocket。(iPhone4上的safari使用的WebSocket是旧版的握手协议,可以使用本页的握手协议来制做服务器端)
起初，Mozilla基金会的Mozilla Firefox会在4版本支持websocket。Opera软件公司方面在Opera 10.7和11.0的预览版本中也支持了websocket。然而，基于安全因素的考虑[1]，两家宣布将暂时移除该功能。
FireFox预计于版本6重新实现WebSockets RFC Version -07 ，但此版本实现并不向后兼容，故旧版本的服务器实现软件有可能无法顺利运行。版本6之中的WebSocket功能将会默认打开[2]。
PS: 在FireFox6的版本里，WebSocket 被更名为 MozWebSocket，但是该 class 的成员与用法皆与 WebSocket 相同。

### threejs 
Threejs 是由MRDoob 开发的一款基于Web的开源3D基础框架,主要包括了简单的数学预算比如偶拉和4元数的变换,和基本的obj模型读取工具以及场景相机等3D中最基本的元素。随着Threejs 的出现我们现在能够更快的开发出web中的3D应用了,而不用花过多的时间在构建基础框架上.
最新版本的threejs文档和安装方法可以参考 https://github.com/mrdoob/three.js/

### nodejs
 nodejs 是一款利用chrome的javascript engine V8 作为核心支持commonjs,Module2.0规范的一款javascript后台实现,nodejs的特性在于利用libuv而达到了大吞吐量异步IO的效果.使用nodejs的另外一个优点是可以在前端和后太共享代码,从而真正意义上的达到了一次开发随处部署的程序员之梦.而对于开发多人联机游戏而言,使用nodejs的话能够在前台和后台使用同样的一套物理引擎进行演算,因此能够很好的重复利用代码,也不容易出现代码不同步的bug.

### coffee-script
coffee-script 是一门类似ruby的语言,他能够编译成javascript也可以直接在后台运行(基于nodejs)另一方面语法更加简介高效,有很好的iteraion和class支持,大量的提高了开发的效率

### chrome debugger 和 source-map
[chrome的debugger的截图](http://invalid/invalid.jpg)
chrome debugger是在web可发和后台nodejs开发过程中的神器,可以用作断点追踪和性能分析.
[chrome break point的截图](http://invalid/inavlid.jpg)
[chrome profiler 的截图](http://invalid/invalid.jpg)
另一方面由于我们使用coffee-script,所以不能简单的像javascript那样调试,但是在近两个月chrome和firefox同时提供了source-map这项技术的支持,因此我们可以使用source-map把编译成的javascript代码映射到我们编写的coffee-script中去,从而达到了直接调试coffee-script的效果.

## 模块介绍
### 前端模块
#### 资源加载模块
为了游戏的体验,必要的资源必须在游戏开始之前就进行加载.为了达到这个目 的我编写了一个叫做ResourceManager的模块进行对比要资源的预先加载工作.通过Ajax基数异步加载所需要的图片和数据.值得一提的是,为了方便前端处理,图片和和3D点阵文理等信息都是通过预处理变成前端容易解析的base64格式或者json数组文件传输的,大大的提高了前端的启动速度.预处理可以处理包括

除了加载文件本身之外还会对文件进行组装工作,把文件从单独的点阵图片和着色信息封装成3D物件,方便后续直接调用.3D物件的封装主要分为3种:Sprite,Cube,NormalMesh.Sprite一般就是平面的物体,主要是用在HUD(Head Up Display)上.Cube则就是整个游戏场景.NormalMesh就是普通的模型.对于普通的模型,也会根据反光漫反射等参数对原有的模型进行一些修正以达到更好的显示效果.
#### 代码共享模块
由于后台的js模块之间使用的是commonjs模块2.0标准.这个标准是一个同步阻塞的标准,在模块引入之前会阻塞知道模块成功载入,变成非常方便.但是前端的模块载入是异步的,只能按照js引入的顺序加载才能同步.按需加载必须是异步的.这样就为前端和后台共享代码造成了一定的困扰.为了解决这个问题,我只做了一套兼容库,先按照前台的方式同步顺序同步载入,全部载入完成之后在伪造commonjs里的require方法同步返回全局对象,然后直接通过全局对象引用模块.这样只需要在浏览器端引入额外的兼容层就可以支持标准了.但是这样做也是有一个缺点的.缺点是会污染全局变量,模块与模块之间也并没有真正意义上的隔离.所以作为不到1w行的小项目,这个方案还是可行的,但是对于真正的大项目,则应该采用更加复杂的方案比如seajs[link to sea js] 这种AMD模式的异步加载库或者browserify[link to browserify]的预编译功能达到后台前台的代码共享.

#### 通讯模块
与传统的实时web构架不同,多人游戏开使用HTTP Long Pull 长连接效率不够无法有效的翔服务器发送信息,开销也非常大.这里我们使用了基于HTML5标准的websocket接口构建客户端与服务器的通讯.
同样为了能够在服务器端和客户端之间有效合理的共享代码,这里我写了一个中间层的基类叫做RPCtunnel,基于nodejs标准的eventEmitter事件发生器.然后基于RPCTunnel 通过不同的传输方式比如server端的websocket库ws,或者浏览器端的websocket构建统一的接口.抽象成对Remote Public Call的形式.那么远程的通讯就变成了直接函数调用编程非常方便.

另一方面,考虑到游戏对实时性的需求,除了部分信息同步的RPC,所有的RPC都是默认不等待返回值的.然后通过发送命令时的同步矫正来纠正传输过程中因为时间或者网络延迟所导致的问题.这样做的好处能大大的减少延时.但是也引入了新的问题.问题主要来自与这样的情况:当客户端擅自的对可能发生的状况做了不可挽回的模拟(比如舰船被集中了,并且消灭了),这样的话就到之了不可逆的状况,因此对于这种不可以相遇的模拟(prediction)必须禁止,避免玩家感受到过于大的跨度而产生不自然的印象.

而对于游戏之外的API比如用户登录,积分等同步则使用基于HTTP构建的RPC通过这种RPC虽然流量有所增加但由于不是流式的,采用这种高层协议实现RPC的优点在于不用保持活跃链接的,因此在通讯人数激增的情况小可以维持更小的持续性开销.

为了所小流量的开销,增加实时性能,对于玩家操纵的飞船采用了位封装,用单独的不重合的比特位来标志舰船的状态如下.
Ship.State = {
    left:              "1",
    right:            "10",
    up:              "100",
    down:           "1000",
    forward:       "10000",
    fire:         "100000",
    explosion:   "1000000",
}
# transfor to banari
do ()->
    for state of Ship.State
        Ship.State[state] = binaryToInt(Ship.State[state])

这样一来可以通过特定的比特的结合而合成一个非常小的数字,这个数字作为字符串在传输的过程中经过base64的压缩也会大大减小体积.

所有的动作都是可以重合的,至于重合后采用什么逻辑则是交给后台去判断了.这样用最小的位数传输了最大的信息.

在服务器收到新的指令之后会回传被修改的舰船的状态回传的包括:
{
            id:@id,
            constructor:"PhysicsObject",
            position:{x:@position.x,y:@position.y,z:@position.z},
            force:{x:@force.x,y:@force.y,z:@force.z},
            rotateAcceleration:{x:@rotateAcceleration.x,y:@rotateAcceleration.y,z:@rotateAcceleration.z},
            rotateVelocity:{x:@rotateVelocity.x,y:@rotateVelocity.y,z:@rotateVelocity.z},
            velocity:{x:@velocity.x,y:@velocity.y,z:@velocity.z},
            quaternion:{x:@quaternion.x,y:@quaternion.y,z:@quaternion.z,w:@quaternion.w},
	    state:@state
}
id 是舰船的全局唯一标志符号,从0开始递增.
constructor 是舰船的类型,可以是初始参数不同的舰船
position 是当前坐标
force 是推进力
rotateAcceleration 是旋转加速度
rotateVelocity 是旋转速度
velocity 是当前速度
quaternion 是表示舰船当前旋转量的四元数
state 之前描述的舰船的状态

通过描述这样一组舰船的元数据就能够达到更新和矫正客户端舰船数据的作用.

#### 物理引擎
##### RK4 积分算法
我可以介绍给你RK4一般的数学公式，你可以用它来整合一些功能，使用它的导数f（X，T），通常是在形式，但看到这篇文章作为我的目标受众是程序员，而不是数学家，我将解释使用代码，而不是。从我的角度来看，这样的过程是最好的代码中描述反正。

所以在我们去任何进一步的，我将定义一个对象的状态作为一个struct在C + +中，使我们方便地存储在一个地方的位置和速度值。

    结构国家
    {
         浮法X; / /位置
         浮动V; / /速度
    };
我们还需要一个结构存储的状态值的衍生工具，所以我们可以很容易地通过各处的功能。我们存储的衍生物是速度和加速度：

    结构衍生
    {
         浮动DX; / /衍生工具的位置是：速度
         浮动DV / /衍生物速度：加速
    };
拼图的最后一块，我们需要实现RK4积分功能可以提前前面的物理状态从T到T + DT使用一组衍生工具，那么一旦出现，使用这个新的状态重新计算的衍生工具。此例程是心脏的RK4积分的和C + +中实现时，它看起来像这样：

    衍生评价（常量国家与初始，浮法T，DT浮动，常量衍生＆D）
    {
         State状态;
         state.x = initial.x + d.dx * DT;
         state.v = initial.v + d.dv * DT;

         衍生输出;
         output.dx = state.v;
         output.dv =加速度（状态，t + DT）;
         返回输出;
    }
这绝对是至关重要的，你明白这种方法做。首先，它需要的对象的当前状态（位置和速度）及垫款未来DT秒（速度和加速度）的衍生工具，通过使用欧拉整合步骤。一旦这个新的位置和速度进行计算，计算新的衍生产品，在这个时间点上使用集成的状态。这些衍生工具会有所不同，最初通过衍生工具的方法，如果在时间步长是不恒定的衍生。

为了计算的衍生工具，它会将当前状态的速度进入衍生结构（这是同时进行位置和速度集成的伎俩），那么它调用的加速功能，计算出加速度的当前状态在时间t + DT。加速功能，是推动整个仿真的例子源代码这篇文章中，我把它定义为如下：

    浮法加速度（const的国家与国家，浮法吨）
    {
         常量浮动K = 10;
         常量浮动B = 1;
         ，返回K * state.x - B * state.v;
    }
这种方法计算出的弹簧和阻尼力，并返回它作为加速假设单位质量。你当然这里写的是完全依赖于模拟，但它是至关重要的，你构建你的模​​拟在这样一个方式，它可以计算的加速度或力的衍生品完全从里面这种方法的当前状态和时间，否则你的模拟可以不工作的RK4积分。

最后，我们得到的整合程序本身集成了状态提前从T到T + DT使用RK4：

    无效集成（国家与国家，T，浮浮DT）
    {
         衍生=评估（状态，t，0.0F，衍生工具（））;
         衍生物B =评估（州，T，DT * 0.5F）;
         衍生C =评估（州，T，DT * 0.5，B）;
         衍生物D =评估（州，T，DT，C）;

         常量浮动dxdt = 1.0f/6.0f *（a.dx + 2.0F *（b.dx + c.dx）+ d.dx）;
         常量浮动DVDT = 1.0f/6.0f *（a.dv + 2.0F *（b.dv + c.dv）+ d.dv）

         state.x = state.x + DXDT * DT;
         state.v = state.v + DVDT * DT;
    }
请注意，多次调用评估弥补这个例程。 RK4样品衍生四次检测曲率，而不是仅仅一次欧拉积分。重要的是要了解它是如何做这种抽样。

如果你看看上面的代码，应该很清楚是怎么回事。注意它是如何使用以前的衍生物，当计算下一个。当计算衍生物B步骤提前从T到T + DT * 0.5使用衍生，然后计算C衍生物B步骤提前使用，终于提前加强与c d的计算。当前的衍生物进入下一个计算这种反馈是什么让RK4积分其准确性。

一旦四只衍生样品进行了评估，最好使用来自泰勒级数展开的衍生工具的加权总和计算整体衍生工具。然后，可以使用这种单一的价值，推进DT的位置和速度超过我们以前在欧拉积分。

请注意，即使当使用一个复杂的集成，如RK4，这一切都归结到的东西= + *时间的变化的东西改变的东西。这是因为分化和整合，从根本上是线性的操作。现在我们只是将单个值，但放心，这一切都结束了这样的整合载体时，四元，甚至旋转动力学和矩阵。


#####缓动和速度和旋转判定判定.
首先所有的操作对实际3D物件的影响都是直接改动的force属性,然后force属性根据物体的质量生成加速度,再跟据前述的RK4算法对离散的时间进行拟合.这样打来的速度总是缓慢的变化这的,并且在最终趋近于稳定.


