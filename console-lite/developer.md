# 开发指南

这里会叙述 Console Lite 的基本架构和你在阅读我(Liu)写的代码时可能需要的Pit Fall。

## 架构

Console Lite 的基本架构类似 IM：高度中心化，真正干活的只有后端的存储层和前端的逻辑层，基本上由上至下可以表示为：

- 前端显示(controller/view/**/*.js)
- 前端逻辑(controller/action.js)
- 前端连接(controller/connection/*.js)
- 后端连接(server/socket.js)
- 后端存储(server/backend/*.js)

投影窗口的所有事件都是从控制窗口转发的，不直接连接后端。

使用的技术是:
- 共享
  - 运行时: Electron (可执行无限大)
  - 连接: Socket.io (WebSocket)
- 前端
  - 语言: HTML5 CSS3 Javascript(ES6 <- V8真是猛，我就是骨粉)
  - 框架: Vue 1.0
- 后端
  - 框架: 没有框架
  - DB: LevelDB

一些额外用到的库:
- NodeJieba (拼音排序和补全)

## 阅读代码

整个项目分为三部分：
- 控制窗口 Controller: /controller
- 投影窗口 Projector: /projector
- 后端 Server: /server

大多数的代码都应该是自解释的，在这里我解释一些有意或无意的设计(失误)造成的逻辑混乱：

### 投票的 Target

在投票里，目标 target 可能有如下值:
- 0 无目标
- 正数 目标票数
- -1 文件二分之三

这么设计的原因是我之前把文件二分之三这茬忘了，就这样，嘻嘻。

### 投票的 vote

在投票矩阵中，vote 可能有如下值：
- 1 赞同
- 0 未投票/过
- -1 弃权
- -2 反对

这样规定的原意是在排序和画进度条的时候吧弃权放到中间，但是后来发现目标可能会跟随弃权的票数而改变，在文件二分之三中，目标更类似于赞同和反对中间的二分之三。为了在进度条中反映这一点，把弃权放到了反对的后面。说到底还是把文件二分之三忘了。

### 十万个连接层

抽象有什么错！说不定以后有 App 呢？你就忍忍吧，至少我把名字都起成一样的了。

### 事件传递

你可能注意到，控制端的更新是跟随服务端 Pingback 的事件更新的，即使事件的来源是自身，目的是保证与服务端同步。考虑如下场景：

```
A 发送了一个请求
B 发送了一个请求
B 接收到了 A 请求的 pingback
B 接收到了自己请求的 pingback
```

如果这个请求的顺序是很重要的，例如在计时器中，A 请求更新计时器，B 请求开始计时器，那么 B 处计时器的状态在接受 A pingback 之后会变为停止。

这个特性造成了一个副作用，在发言名单中凸显很明显，就是闪烁。在发言名单中拖动重拍席位后，拖动的席位会飞回原来的位置然后飞回来。解决方法是加了一个延迟再允许上游更新被显示。

### getFile 的 pingback 事件

和其他所有事件都不同，getFile 事件的返回事件后缀带有文件 ID，主要是考虑到文件较大，传输时间较长，为了区分多个请求而加的。其他的请求不加是基于对操作者手速的蔑视。毕竟这是局域网，数据库还是带缓存的 k-v 数据库。

### rebuildNative

事情是这样的： Electron 提供的 ABI 版本很飘逸，现在是 49，超过了 Node.js 最新版本的 ABI 48。项目所用的一个依赖 Leveldown 会自动根据 Node 版本下载已经编译好的二进制。这就麻烦了，和 Electron 不配套，所以需要根据 Electron 提供的头文件重新编译一次。另一个意义在于当 Node 真的到 49了，鬼知道 V8 版本和现在的 electron 一样不一样，到时候如果 ABI 检查通过但是 ABI 不兼容麻烦就大了。

## 下载

跟随 https://github.com/CircuitCoder/Console-Lite 的指引即可。

提一句，如果 Electron 的下载速度太慢，请使用淘宝的镜像。以 Linux 为例，在`npm install`前：

```bash
export ELECTRON_MIRROR https://npm.taobao.org/mirrors/electron/
```

{% include '../footer.md' %}
