<style>
.footer {
  margin-top: 50px;

  font-size: .8em;
}

.footer-src {
  display: inline-block;
  opacity: .3;
}

.footer-mtime {
  float: right;
  opacity: .3;
}

.footer-badages {
  float: right;
  margin-left: 10px;
}

.footer-badages img {
  vertical-align: middle;
}
</style>

<div class="footer">
  <div class="footer-src">
    源文件:
    <a href="https://git.thsitg.org/BJMUN/kb/tree/master/{{ file.path }}">{{ file.path }}</a>
  </div>

  <div class="footer-badages">
    <a href="https://git.thsitg.org/BJMUN/kb/commits/master"><img alt="build status" src="https://git.thsitg.org/BJMUN/kb/badges/master/build.svg" /></a>
  </div>
  <div class="footer-mtime">
    知识库版本: {{ file.mtime }}
  </div>
</div>
