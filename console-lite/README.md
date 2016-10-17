<style>

#down-block .loading-hint {
  display: none;
  text-align: center;
  padding: 20px;
  opacity: 0.3;
}

#down-block .down-content {
  display: block;
}

#down-block.loading .loading-hint {
  display: block;
}

#down-block.loading .down-content {
  display: none;
}

.down-sec {
  padding: 20px;
  text-align: center;
  background: white;
  border-radius: 4px;
}

.down-btn {
  padding: 20px;
  font-size: 16px;
  background: #EEE;

  transition: opacity .2s ease;
  opacity: .8;

  border-radius: 2px;

  outline: 0;
  border: 0;
  margin: 10px;

  box-shadow: rgba(0,0,0,.12) 0 2px 3px;
}

.down-btn.primary {
  background: #B3E5FC;
  color: #0288D1;
}

.down-btn:hover {
  opacity: 1;
}
</style>

<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>

$.get('https://store.bjmun.org/console-lite')
.done(function(data) {
  var $data = $(data);

  var fontbucket = {};
  var nofontbucket = {};
  var maxVersion;

  $data
  .children('ListBucketResult')
  .children('Contents').each(function(i) {
    var name = $(this).children('Key').html();
    var size = $(this).children('Size').html();
    var info = name.match(/^Console-Lite-v(\d+)\.(\d+)\.(\d+)-([^-]*)-([^-\.]*)(-nofont)?(.*)$/);
    if(!info) return;
    var ver1 = info[1];
    var ver2 = info[2];
    var ver3 = info[3];
    var platform = info[4];
    var arch = info[5];
    var nofont = info[6];

    var desc = {
      version: [ver1, ver2, ver3],
      name: name,
      size: size,
    };

    var bucket = nofont ? nofontbucket : fontbucket;
    var limiter = platform + '-' + arch;

    var original = bucket[limiter];
    if(!original || ver1 > original.version[0] || ver2 > original.version[1] || ver3 > original.version[2]) {
      bucket[limiter] = desc;
    }

    if(!maxVersion || ver1 > maxVersion[0] || ver2 > maxVersion[1] || ver3 > maxVersion[2]) {
      maxVersion = desc.version;
    }
  });

  console.log(fontbucket);
  console.log(nofontbucket);

  [
    { key: 'darwin-x64', name: 'Mac OS X 64位' },
    { key: 'darwin-x32', name: 'Mac OS X 32位' },
    { key: 'win32-x64', name: 'Windows 64位' },
    { key: 'win32-ia32', name: 'Windows 32位' },
    { key: 'linux-x64', name: 'Linux 64位' },
    { key: 'linux-ia32', name: 'Linux 32位' },
  ].forEach(function(e) {
    if(e.key in fontbucket) {
      var btn = $('<button>').addClass('down-btn').addClass('primary').text(e.name + ' (' + Math.round(fontbucket[e.key].size / 1024 / 10.24) / 100 + 'MB)');
      $('<a>')
      .attr('href', 'https://store.bjmun.org/console-lite/' + fontbucket[e.key].name).append(btn).appendTo('.down-sec.down-default');
    }

    if(e.key in nofontbucket) {
      var btn = $('<button>').addClass('down-btn').text(e.name + ' (' + Math.round(nofontbucket[e.key].size / 1024 / 10.24) / 100 + 'MB)');
      $('<a>')
      .attr('href', 'https://store.bjmun.org/console-lite/' + nofontbucket[e.key].name).append(btn).appendTo('.down-sec.down-nofont');
    }
  });

  $('#down-ver').text('v' + maxVersion[0] + '.' + maxVersion[1] + '.' + maxVersion[2]);
  $('#down-block').removeClass('loading');
})
.fail(function(err) {
  console.error(err);
  $("#down-block .loading-hint").html('加载出错，请刷新页面重试');
})
</script>

# Console Lite 使用手册 

![启动界面](initial-screen.png)

Console Lite，/kˈɑnsoʊl/ /lˈaɪt/，翻译成中文是`控制台缩水版` (并不)，是一个模拟联合国会议软件。

Console Lite 拥有以下<small>十分厉害的</small>的功能：

- 支持多人协作，可以自动发现局域网内其他的实例并且连接
- 跨平台，支持 Mac OS X、Windows 以及大多数 Linux 发行版
- 拥有优雅的操作方法
- 占据震撼人心的硬盘空间 (例如：Windows 64位版本 300M)

## 下载

安装 Console Lite 十分简单，下载后开包即用。

<div id="down-block" class="loading">
  <div class="loading-hint">加载下载链接中...</div>
  <div class="down-content">
  当前发布的版本为 <span id="down-ver"></span>。

  <div class="down-sec down-default">
  </div>

  如果你的下载带宽不够，可以下载不带字体的版本，可能会导致体验弱化。

  <div class="down-sec down-nofont">
  </div>
  </div>
</div>

启动 Console Lite 后，请继续阅读[起飞](takeoff.md)

### 对于 macOS Serria 用户的提示

如果你正在使用 macOS Serria，Console Lite 可能不能在任意路径下执行，在启动本地会话时会提示错误。此时你需要将 Console Lite 的应用文件移动到 Finder 窗口左侧的`应用程序`，或 `/Application` 中。此后，从 Launchpad 启动 Console Lite，即可正常使用。

## 开放源代码

Console Lite 的全部源代码在 MIT 协议下开放，源码在 [Github](https://github.com/CircuitCoder/Console-Lite) 上。

{% include '../footer.md' %}
