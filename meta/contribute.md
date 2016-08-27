# 如何向知识库贡献内容

BJMUN 知识库本身是一个开放的平台，但是向其提交内容需要一定的姿势技巧。

## 工作原理

如果你已经对 Markdown、Gitbook、Git 有所了解，请前往[流程](#流程)一节。

BJMUN 知识库中的所有内容都是由 Markdown 标记语言写成的。不同于 Word、Pages 等所见即所得编辑器，Markdown 是通过在纯文本文件中添加标记符号 (Markup Symbols) 以完成对内容样式的更改和富文本内容的添加。另一点不同是 Markdown 语言写成的文件通常不会被直接展示给读者，而是通过其他软件转换成 PDF、网页或者其他形式的标记语言文档，如LaTeX，然后在被利用。现在开源社区公认的 Markdown 标准是 CommonMark，其官网为[commonmark.org](commonmark.org)。

学习 Markdown 可以使用 commonmark.org 提供的[教程](http://commonmark.org/help/tutorial/)或者[参考](http://commonmark.org/help/)。有志者也可以翻阅[标准文档](http://spec.commonmark.org/)。

BJMUN 知识库所用的转换软件叫做 [Gitbook](https://www.gitbook.com/)。Gitbook 将一个有特定结构的，包含数个 Markdown 文档的目录作为一个 Book，并且可以把 Book 转换成一个网站。 Gitbook 同时对 Markdown 做了一些扩展。

BJMUN 知识库的全部源文件都被公开的存储于我们自己搭建的 Git 服务器上: [https://git.thsitg.org/BJMUN/kb](https://git.thsitg.org/BJMUN/kb)。Git 是一个`版本控制系统`，由业界大佬 Linus 开发，最初的目的是用于管理 Linux 内核的源代码，被我们用上纯属偶然。在 Git 服务器上，一个包含项目的单元被称为仓库，仓库所有者和仓库名组成了这个仓库的唯一 ID，如 `BJMUN/kb`，也就是它网址的后缀。Git 同时也包含一个客户端工具，使用它可以在本地修改知识库的内容，并且能提供对项目更细节的管理，但是大多数的修改都可以在 Git 的网页版上进行。提一句，我们使用的 Git 服务器是 Gitlab，Gitbook 名字里包含 Git 是因为 gitbook.com 提供对另一个提供 Git 服务的网站，Github，有着额外的一些支持。

> Git 这个词的意思是饭桶，IDK 为什么当时 Linus 要起这么个名字。

## 流程

首先，你需要注册或登陆我们的 [Git 服务器](https://git.thsitg.org/)。

随后需要进行的操作是前往 [BJMUN/kb仓库](https://git.thsitg.org/BJMUN/kb)，点击大标题下方的 Fork 按钮。Fork 的含义是将这个仓库复制一份，归属 Forker 所有。由于只有 BJMUN 组织的成员才能直接修改 BJMUN/kb 仓库，所以在做出修改前，首先需要 Fork 出一个自己的仓库。Fork 结束之后，你会被带到新仓库。注意网页的网址和顶栏的内容，你可以发现这个仓库的所有者是你。点击顶栏小狐狸下方的 Repository 可以进入到文件树中。

Gitbook 要求的项目结构如下：
- 根目录下，SUMMARY.md 为网站索引
- 根目录下，README.md 为网站主页
- 其他目录根据索引建立

package.json、book.json 和所有以句点开头的文件都是和项目构建有关的，不需要更改。更改以后可能会对网站的自动更新造成影响。

打开文件后，可以点击 Edit 进行修改。点击上方的 Preview 标签卡可以查看显示效果。修改完成后，在 Commit message 填入修改内容的简介，点击 Commit Change 提交修改。 Commit message 的例子有:

- 修正 README.md 中的一个错别字
- 在 console-lite/takeoff.md 中添加关于如何发射火箭的说明
- 由于与话题无关，删除 meta/dog.md 中关于喂猫的讨论

Commit message 对内容和修改的行为没有任何影响，所以直接保留为 Update 文件名 也可以，但是为了审核方便，推荐填入简介。

Commit 结束后你可能会注意到仓库主页上，会出现一个 Failed 或者 Passed，这是指你做出的更改是否被 Gitbook 成功的转换为网页了，这个转换过程被称为构建。点击它可以将你带到一个类似控制台的网页，显示的就是 Gitbook 的输出信息。如果你的修改构建状态是 Failed，请检查是否有语法错误或者缺失的文件。如果你的构建状态是 Passwd， 那么在这一步虽然你的更改还没有被反映到知识库中，但是你已经可以下载你作出更改之后的网站了，方法是点击这个页面上唯一一个带着灰色圆角边框的 build，然后点击右侧的 Download。构建得到的网站只能在 Git 服务器中保留二十分钟，如果需要长时间保留，请点击 Download 左侧的 Keep。你也可以点击右侧的 Brwose直接在线查看构建得到的结果。

在进行一个或者多个 Commit 过后，点击顶栏小狐狸下方的 Merge Request，在打开的页面中点击 New merge Request 按钮。Merge Request 如其名字所述，指请求上游仓库 (在这个例子中，BJMUN/kb) 合并在下游仓库中做出的修改。在 New Merge Request 表单中，需要在 Select source branch 下拉菜单中选择你做出更改的分支。如果你不知道分支是什么，那么选 master。其他的下拉栏都应该被自动填齐了，如果没有，请在左边选择你的仓库，右边选择 BJMUN/kb 仓库和 master 分支。随后点击 Compare branches and continue，进入下一步。

在下一步中你可以修改 Merge Request 的细节，比如显示的标题，说明等等。推荐的设置为：
- 标题 Title 中填入这一系列更改的主旨，如`将 Console Client 文档更新至 100.86 版本`。如果没有主旨，那么保留默认标题即可。
- 说明 Description 可以更细节的说明做出的修改。如果之前的 Commit message 足够直观，那么可以这里可以省略。
- 指派 Assignee 留空，除非你对 BJMUN 组织的某个成员有特殊的感情
- 里程碑 Milestone 留空
- 标签 Labels 留空

在提交按钮下方可以看到作出更改的列表，包括提交、构建和更改的文件。检查无误后点击 Submit merge request 提价，之后只需要等待 BJMUN 组织成员的回应即可。最后，如果 Merge request 被合并，那么提交的更改就会被反映到知识库中。

当然，如果你有权限，也可以直接修改 BJMUN/kb 仓库。

## 样式

普遍而言，知识库的内容没有特定的格式规则，但是为了方便阅读和维护，我们有以下推荐：

- 每个页面中仅包含一个一级标题，出现在源文件第一行
- 随后的标题使用需要连续。连续指如果某个标题比它之前出现的标题要小，最多只能小一级
- 除非用于强调，不修改文字的背景色、显示颜色、字号、字距或者行高。

除此之外，由于 Git 服务器已经提供了文件细节信息，如参与者、修改日期等等，所以我们不需要在文件中加入文件头。

虽然 Gitbook 接受嵌套在 Markdown 内部的 HTML，但是我们推荐使用 Markdown 格式化内容，一为了保证样式一致，二为了保证可维护性。这条规则有两个例外：
- Markdown 不包含的功能，例如`<ruby>`标签。
- `<style>`标签所包含的仅适合此页的 CSS 样式。

注意，Gitbook 将所有包裹在 HTML 标签内的内容都当作 HTML，所以不能在 HTML 内再次嵌套 Markdown 标记。所以为了对内容做出进一步的格式化，推荐使用以下模式的 CSS 选择器:

```html
<style>
.smaller-indicator {
  display: none;
}

.smaller-indicator + table {
  font-size: 0.8em;
}

<span class="smaller-indicator"></span>

| 这个 | 表格 |
|------|------|
| 字号 |小一点|

```

## 许可证

有一点需要注意：在默认情况下，你所作出的更改是在 CC 4.0 BY-SA 下发布的，向 BJMUN/kb 仓库发送 Merge request 代表你同意这一点。这个许可证不强制内容的非商业使用，如果你不希望你的作品被他人用作商业用途，请在修改中强调使用 CC 4.0 BY-SA-NC 许可证。当然，如果你希望使用其他的许可证发表你的更改，如 CC0、WTFPL 或者用于开源代码的许可证，也请强调说明。
