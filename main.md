# Title: An HTML5 WebBased Base 3D rendering Game,一款基于HTML5 WebGL的3D游戏.
# 简介
keyword: WebGL html5 websocket 3D 物理引擎 跨平台游戏 threejs nodejs
这是一款利用了websocket,html5,webgl,nodejs等新技术编写的一款3D多人联机对战游戏.在很长一段时间里web仅仅使用做普通的网页浏览并没有用作别的什么更加复杂的活动,而如今随着w3c组织的活跃和各大浏览器厂商的不断创新和尝试,web平台被赋予了更多的价值可能性.随着新的HTML5的API的开放比如webgl和websocket,在浏览器上有了发展新的应用的可能性了.另一方面通过使用javascript的后端渲染技术--nodejs,我们能够更好的实现跨平的兼容,甚至前端和后端共享一份代码,而这里就为探索这种可能性做了一次尝试. 探索了跨同台的web3D游戏的制作.

This is A game using websicket html5 webgl and nodejs techs that construct a new online 3D multi-player battle game.In a long time web is only used for normal webpage displaying and no complicated tasks was asigned to it.But when time pasts,orgnizations like w3c and the browser venders has try and try to do mo inovations, and the web platforms has been assigned to more possibilities.With the come out of the new HTML5 APIs such as webgl and websocket,we have much more chance to build new apps.On the other hand using javascript (ndoejs) as an backend render techs, we can achieves better cross platform comtapability, and Event share some of the codes.And here we explore the possibility of cross platform web game making.
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
后期的版本大多属于功能上的扩充，例如使用第7版的握手协议同样也适用于第8版的握手协议。
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

    strcuct
    {
         float X; / /位置
         float V; / /速度
    };
我们还需要一个结构存储的状态值的衍生工具，所以我们可以很容易地通过各处的功能。我们存储的衍生物是速度和加速度：

    struct Derivative
    {
         float DX; / /衍生工具的位置是：速度
         float DV / /衍生物速度：加速
    };
拼图的最后一块，我们需要实现RK4积分功能可以提前前面的物理状态从T到T + DT使用一组衍生工具，那么一旦出现，使用这个新的状态重新计算的衍生工具。此例程是心脏的RK4积分的和C + +中实现时，它看起来像这样：
								Derivative evaluate(const State &initial, float t, float dt, const Derivative &d){
         State state;
         state.x = initial.x + d.dx*dt;
         state.v = initial.v + d.dv*dt;

         Derivative output;
         output.dx = state.v;
         output.dv = acceleration(state, t+dt);
         return output;
}

这绝对是至关重要的，你明白这种方法做。首先，它需要的对象的当前状态（位置和速度）及垫款未来DT秒（速度和加速度）的衍生工具，通过使用欧拉整合步骤。一旦这个新的位置和速度进行计算，计算新的衍生产品，在这个时间点上使用集成的状态。这些衍生工具会有所不同，最初通过衍生工具的方法，如果在时间步长是不恒定的衍生。

为了计算的衍生工具，它会将当前状态的速度进入衍生结构（这是同时进行位置和速度集成的伎俩），那么它调用的加速功能，计算出加速度的当前状态在时间t + DT。加速功能，是推动整个仿真的例子源代码这篇文章中，我把它定义为如下：

float acceleration(const State &state, float t)
    {
         const float k = 10;
         const float b = 1;
         return -k * state.x - b*state.v;
    }
这种方法计算出的弹簧和阻尼力，并返回它作为加速假设单位质量。你当然这里写的是完全依赖于模拟，但它是至关重要的，你构建你的模​​拟在这样一个方式，它可以计算的加速度或力的衍生品完全从里面这种方法的当前状态和时间，否则你的模拟可以不工作的RK4积分。

最后，我们得到的整合程序本身集成了状态提前从T到T + DT使用RK4：
    void integrate(State &state, float t, float dt)
    {
         Derivative a = evaluate(state, t, 0.0f, Derivative());
         Derivative b = evaluate(state, t, dt*0.5f, a);
         Derivative c = evaluate(state, t, dt*0.5f, b);
         Derivative d = evaluate(state, t, dt, c);

         const float dxdt = 1.0f/6.0f * (a.dx + 2.0f*(b.dx + c.dx) + d.dx);
         const float dvdt = 1.0f/6.0f * (a.dv + 2.0f*(b.dv + c.dv) + d.dv)

         state.x = state.x + dxdt * dt;
         state.v = state.v + dvdt * dt;
    }
请注意，多次调用评估弥补这个例程。 RK4样品衍生四次检测曲率，而不是仅仅一次欧拉积分。重要的是要了解它是如何做这种抽样。

如果你看看上面的代码，应该很清楚是怎么回事。注意它是如何使用以前的衍生物，当计算下一个。当计算衍生物B步骤提前从T到T + DT * 0.5使用衍生，然后计算C衍生物B步骤提前使用，终于提前加强与c d的计算。当前的衍生物进入下一个计算这种反馈是什么让RK4积分其准确性。

一旦四只衍生样品进行了评估，最好使用来自泰勒级数展开的衍生工具的加权总和计算整体衍生工具。然后，可以使用这种单一的价值，推进DT的位置和速度超过我们以前在欧拉积分。

请注意，即使当使用一个复杂的集成，如RK4，这一切都归结到的东西= + *时间的变化的东西改变的东西。这是因为分化和整合，从根本上是线性的操作。现在我们只是将单个值，但放心，这一切都结束了这样的整合载体时，四元，甚至旋转动力学和矩阵。


#####缓动和速度和旋转判定和碰撞检测.
首先所有的操作对实际3D物件的影响都是直接改动的force属性,然后force属性根据物体的质量生成加速度,再跟据前述的RK4算法对离散的时间进行拟合.这样打来的速度总是缓慢的变化这的,并且在最终趋近于稳定.

碰撞检测并不是采用的最完美遍历所有object的方式.首先我们会针对每个可以参与碰撞检测的物件建立一个表单,当需要判定碰撞的时候针对这个表单里面的物件进行判断.传统的三维碰撞检测的判断需要对物体的每个面进行判断,但是为了能够容忍大量的飞船在三维空间中同时存在而导致的效率急剧下降,我们参用了简化版本的三维碰撞检测,首先我们需要判断两个碰撞的物体是否远大于他们的最大三维尺寸加上他们的速度,如果确实是大于那么就不需要做更加复杂深入的判断.当他慢确实在相应的距离里的时候,我们针对两个物体的运动速度取其合,并且在最后得到的速度方向上做射线,计算涉嫌和目标点的距离,最后判断目标点的距离和射线其实点的距离到底有多大的差距,当差距在一个速度单位之内的情况下我们认为他们家下来的一个单位时间里会相交,也就是说会碰撞,否则我们认为他们不会碰撞.

如果我们认定他们会发生碰撞那么碰撞点就取目标物体到射线上的垂直投影,认为这个投影点映射到真实的三维空间里去的点就是他们在真是三维空间里的相交点.然后针对所有需要做碰撞的物体如果是量两之间那么可以通便单次运算从而避免复杂的重复计算.

通过采用这种大大优化过了的碰撞检测方式我们可以最大程度的将运算避免,从而总体上提高了碰撞检测的效果,并且依然保证了肉眼可以验证的运算效率.可以在20ms内对将近1000个物体进行碰撞检测而丝毫没有什么问题.


### 渲染引擎简介
#### webgl + threejs.
#### scene 和 camera 和 
一个三维的场景大体上来说有两个最基本的元素构成他们就是scene和camera.scene决定了整体的渲染方式,比如是否有雾气,能见度是多少.而camera则决定了最终我们如何从三维场景中投影到二维场景.主要的参数有FOV,far,near,其中far和near分别定义了离camera最远和最近的可视距离.FOV的全称是field of view.定义了三维场景中的景物投影到平面二维成像时的成像方式,FOV过小就会呈现出鱼眼镜头的感觉.一般设置在35-45之间会有比较好的效果.

#### cubemap world
为了营造我们的飞船在宇宙空间中飞行的效果,我们用一个非常大的正方体当作宇宙空间,然后把飞船放在里面,在这个非常大的正方体内壁贴上宇宙世界的纹理,这种技术就叫做cubemap.通过把立方体的大小设置成非常大的方式,我们就能够让人产生飞船怎么飞也不会飞到宇宙的边缘的错觉从而达到了模拟玩家在宇宙中飞行的目的.

#### Reflection
为了营造更好的飞船的视觉效果,我为飞船加上了镜面反射的特效,通过调整光线对飞船材质的满反射和镜面发射的成效比,达到了非常好的视觉特效营造了一种高端大气的科技感觉.Reflection是在原有的点阵和法向量和颜色矩阵的基础之上增加了一个反射矩阵和反射贴图.

反射贴图的选取有两种方式,第一种是没每一桢的时候都从目标的视角再次渲染一边整个场景,然后渲染的结果就作为额外的贴图根据反射比例粘贴到目标物体的表面上去。第二种就是使用县城整个世界的cubemap world作为额外的贴图粘贴到物体上面去,在大型的场景下,两种方式做带来的视觉上的变化并不是非常的明显但是性能上的差距则是天壤之别,前者由于无法预先计算而且根据物体的数量的变化所需要进行的重复计算非常非常的多,随着物体的增加效率会下降的非常非常的严重因此我们还是选用后面的一种方式作为我们游戏中的主要反射的选方式.

#### 让摄像机追踪我们的主要物体.
首先让根据我们需要追踪的主要物体的旋转角度(也就是四元数quaternion),将我们所需要追踪的物体和摄像机之间的默认距离作为向量(l,0,0)根据quaternion进行进行旋转然后加上主要物体原来的坐标值,最后生成的就是我们的主要相机的位置,然后针对主要相机的位置做矩阵旋转,这里我们直接调用Threejs中封装好了的lookat方法,计算出让相机和目标位置所构成的直线与相机方向相同所需要的矩阵旋转值.之后每一桢都会设置他.

#### HUD 和3D到2D的矩阵投影.
平视显示器（Head Up Display），以下简称HUD，是目前普遍运用在航空器上的飞行辅助仪器。平视的意思是指飞行员不需要低头就能够看到他需要的重要资讯。平视显示器最早出现在军用飞机上，降低飞行员需要低头查看仪表的频率，避免注意力中断以及丧失对状态意识(Situation Awareness）的掌握。因为HUD的方便性以及能够提高飞行安全，民航机也纷纷跟进安装。部分汽车业者也以类似的装置作为行销的手段吸引顾客，不过使用上并不广泛。

HUD是利用光学反射的原理，将重要的飞行相关资讯投射在一片玻璃上面。这片玻璃位于座舱前端，文字和影像被投射在镀膜镜片(析光镜)并平衡反射进飞行员的眼睛。飞行员透过HUD往前方看的时候，能够轻易的将外界的景象与HUD显示的资料融合在一起。由于反射进眼睛中的影像永远与飞机的中轴平衡，所以飞行员的身高不会对俯仰角或目视瞄准造成偏差。HUD设计的用意是让飞行员不需要低头查看仪表的显示与资料，始终保持抬头的姿态，降低低头与抬头之间忽略外界环境的快速变化以及眼睛焦距需要不断调整产生的延迟与不适。
HUD投射的资料主要与飞行安全有重要关系，譬如飞行高度，飞行速度，航向，垂直速率变化，飞机倾斜角度等等。使用于战斗环境时，还会加上目标资料，武器，目视瞄准器与发射的相关资料，预估命中点等等。这些显示的资料能够根据不同状况而变换。

通过在游戏中引入HUD设备,我们可以大大的提高游戏的体验让游戏具有更好的可玩性.
(图片网址)[http://hiphotos.baidu.com/twjblog/pic/item/69e2f8ab38a856997dd92ac7.jpg]

#### Shader Pass 和 Compose  Renderer
通过撰写Shader程序我们可以很好的利用GPU加速的方式给游戏提高效率.而为了实现一些复杂的视觉特效我们使用多重Shader也就是Shader Pass和Compose Renderer来实现对buffer的多次渲染来大道特殊的效果.

这里我们写了一个高斯模糊的特效.因为直接做5阶级的高斯模糊的算法复杂度过高导致无法在事实渲染的过程中对整个画面做完整的高斯模糊.这个时候我们在图形纵向的5个单位上做一次高斯模糊,其算法作为一个ShaderPass,然后再在另一个维度上做5个单位的高斯模糊,作为另外一个ShaderPass,然后通过Compose Renderer再回合到普通的webgl 画布上去,从而最终实现了完整的高斯模糊特效.


# 结论和总结
通过使用最新的HTML5技术和webgl,websocket等标准,我们利用一些类似nodejs和threejs等强大的第三方工具完整的实现了一个3Dweb的联机对战游戏.为探索了给予Web的3D建模方式,制作出了一款基于Web的3D建模工具.


# 致谢
感谢大学四年来对我不离不弃的同学们,帮助我度过了大学中的一个有一个难关,让我突破了一个又一个的技术难点,我从一个什么都不懂的学生成长为如今的优秀毕业生,并且能够完整的写出一片可以运行的游戏,这在我刚入大学的时候是不可以想象的.但如今我却确确实实的在这里,我不得不表示对那些给予我帮助的同学们以由衷的感谢.另外感谢大学四年来教我所有课程的所有老师,是你们给了我知识,是你们让我变得与众不同,如果没有你们想必我是不可能写出这篇论文的,没有你们我更时不可能座位一个优秀的学生而毕业的.然后我要感谢我的父母,是你们这么多年辛勤的把我养育大,在我论文书写不顺利的时候鼓励我,然我有了写下去的激情和动力,是你们为我做了一次又一次的饭,让我感受到了人生的美好.最后,我要感谢我这篇论文的指导老师胡卫军,是在您的指导下我才能够顺利的完成论文,实现重要的技术突破,从而作为一名学生毕业.如今,我要感谢你们,真的感谢你们,因为你们我才能够实现一个学生的目标.谢谢!

# 参考文献
[1] John Congote EAFIT University, Medellín, Colombia Alvaro Segura Vicomtech Research Cente, Donostia - San Sebastian, Spain Luis Kabongo Vicomtech Research Center, Donostia - San Sebastian, Spain.Web3D '11 Proceedings of the 16th International Conference on 3D Web Technology Pages 137-146 

[2] Benjamin P. DeLilloRochester Institute of Technology SIGGRAPH '10 ACM SIGGRAPH 2010 Posters Article No. 135 

[3] Bijin Chen ; Sch. of Comput. Sci. & Eng., South China of Univ., Guangzhou, China ; Zhiqi Xu;A framework for browser-based Multiplayer Online Games using WebGL and WebSocket.Multimedia Technology (ICMT), 2011 International Conference on.Page(s): 471 - 474.

[4] Tilkov, S. ; Vinoski, S.node.js: Using JavaScript to Build High-Performance Network Programs.Internet Computing, IEEE  (Volume:14 ,  Issue: 6 ) Date of Publication: Nov.-Dec. 2010

[5] mrdoob JavaScript 3D library https://github.com/mrdoob/three.js/

[6] W3C http://www.w3.org/TR/2009/WD-websockets-20091222/

[7] 欧阳慧琴,陈福民 物理引擎与图形渲染引擎绑定的研究与实现 同济大学计算机中心,上海,200092
测试