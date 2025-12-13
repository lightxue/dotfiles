# Neovim 快捷键列表

## 基础编辑

### 文件操作
- `<leader>s` - 保存文件
- `<leader>fu` - 设置文件格式为 Unix
- `<leader>fd` - 设置文件格式为 DOS
- `<leader>fs` - 使用 sudo 保存文件

### 退出操作
- `<leader>xx` - 退出当前窗口
- `<leader>xb` - 删除当前 buffer
- `<leader>xf` - 强制退出当前窗口
- `<leader>xm` - 退出所有窗口
- `<leader>xk` - 强制退出所有窗口

### 移动
- `j` - 向下移动(gj) / 加速向下移动(accelerated-jk)
- `k` - 向上移动(gk) / 加速向上移动(accelerated-jk)
- `Y` - 复制到行尾
- `D` - 删除到行尾
- `n` - 下一个搜索结果(居中显示)
- `N` - 上一个搜索结果(居中显示)
- `J` - 合并下一行(保持光标位置)
- `<Space>` - 向下滚动半屏
- `;` - 重复 f/F 向前搜索(clever-f)
- `,` - 重复 f/F 向后搜索(clever-f)
- `<leader>w` - 跳转到单词(HopWord)

### 可视模式操作
- `J` - 向下移动选中行
- `K` - 向上移动选中行
- `<` - 减少缩进
- `>` - 增加缩进
- `<Space>` - 向下滚动半屏

### 代码折叠
- `<S-Tab>` - 切换代码折叠

### 编辑设置
- `<leader>nw` - 切换自动换行
- `<leader>hl` - 切换高亮搜索
- `<leader>cw` - 清理行尾空白字符
- `<leader>ms` - 切换鼠标模式
- `<leader>t2` - 设置缩进为 2 空格
- `<leader>t4` - 设置缩进为 4 空格
- `<leader>t8` - 设置缩进为 8 空格

## 窗口操作

### 窗口切换
- `<C-h>` - 切换到左侧窗口
- `<C-l>` - 切换到右侧窗口
- `<C-j>` - 切换到下方窗口
- `<C-k>` - 切换到上方窗口

### 窗口大小调整
- `<A-[>` - 垂直缩小窗口 5 列
- `<A-]>` - 垂直扩大窗口 5 列
- `<A-;>` - 水平缩小窗口 2 行
- `<A-'>` - 水平扩大窗口 2 行

### 窗口其他操作
- `<leader>l` - 重绘窗口

## 标签页操作
- `<leader>tn` - 新建标签页
- `<leader>to` - 只保留当前标签页
- `<leader>te` - 在新标签页中打开 Startify

## 命令行模式(Bash 快捷键)
- `<C-b>` - 光标左移
- `<C-f>` - 光标右移
- `<C-a>` - 移到行首
- `<C-e>` - 移到行尾
- `<C-d>` - 删除字符
- `<C-h>` - 退格
- `<C-p>` - 上一条命令
- `<C-n>` - 下一条命令
- `<C-t>` - 自动补全当前文件路径

## 注释
- `gcc` - 切换当前行注释
- `gbc` - 切换当前块注释
- `gc` + motion - 使用 motion 切换行注释
- `gb` + motion - 使用 motion 切换块注释
- 可视模式 `gc` - 切换选中行的注释
- 可视模式 `gb` - 切换选中块的注释

## 对齐
- 可视模式 `<Enter>` - 使用分隔符对齐

## 文件树 (Neo-tree)
- `<leader>nt` - 切换文件树显示

## 搜索查找 (Telescope)
- `<C-p>` - 打开命令面板
- `<leader>ff` - 在项目中搜索文件
- `<leader>fg` - 在项目中搜索文本
- `<leader>fm` - 按访问频率搜索文件(frecency)
- `<leader>fp` - 搜索项目
- `<leader>fb` - 搜索已打开的 buffer
- `<leader>fc` - 搜索剪贴板历史
- `<leader>fn` - 搜索通知历史
- `<leader>fh` - 搜索帮助标签
- `<leader>ft` - 搜索 Treesitter 符号
- `<leader>fj` - 使用 zoxide 切换目录
- `<leader>ut` - 显示撤销历史

## LSP (Language Server Protocol)

### 代码导航
- `gd` - 预览定义
- `gD` - 跳转到定义
- `gh` - 显示引用
- `gr` - 在文件范围内重命名
- `gR` - 在项目范围内重命名
- `K` - 显示文档
- `gs` - 显示函数签名
- `go` - 切换符号大纲

### 诊断
- `g[` - 上一个诊断
- `g]` - 下一个诊断
- `<leader>dl` - 显示行诊断
- `<leader>ed` - 显示文档诊断
- `<leader>ep` - 显示项目诊断
- `<leader>ee` - 切换问题列表(Trouble)

### 代码操作
- `ga` - 光标处的代码操作
- `<leader>ci` - 显示调用者(incoming calls)
- `<leader>co` - 显示被调用者(outgoing calls)

### LSP 管理
- `<leader>li` - 显示 LSP 信息
- `<leader>lr` - 重启 LSP
- `<leader>ii` - 格式化代码

## Git 操作

### Git 基础
- `<leader>gs` - 切换 Git 状态窗口
- `<leader>gc` - Git commit
- `<leader>gl` - Git pull
- `<leader>gp` - Git push
- `<leader>gv` - Git 历史查看
- `<leader>gd` - 切换 Git diff 视图
- `<leader>gD` - 显示 Git diff 视图(DiffView)

### Git Hunk 操作
- `]g` - 跳转到下一个 hunk
- `[g` - 跳转到上一个 hunk
- `<leader>hs` - 暂存 hunk
- `<leader>hu` - 撤销暂存 hunk
- `<leader>hr` - 重置 hunk
- `<leader>hR` - 重置整个 buffer
- `<leader>hp` - 预览 hunk
- `<leader>gb` - 切换当前行 blame 显示
- `<leader>gB` - 显示完整 blame 信息
- `ih` (operator/visual) - Git hunk 文本对象

## 终端 (ToggleTerm)
- `<leader>tt` - 切换终端
- `<leader>ts` - 切换水平终端
- `<leader>tv` - 切换垂直终端
- `<leader>tf` - 切换浮动终端
- `<leader>tr` - 运行当前文件
- 终端模式 `<Esc><Esc>` - 切换到普通模式
- 终端模式 `jk` - 切换到普通模式
- 终端模式 `<C-h/j/k/l>` - 窗口切换

## 调试 (DAP)

### 调试控制
- `<F6>` - 停止调试
- `<F7>` - 运行/继续
- `<F8>` - 切换断点
- `<F9>` - 运行到光标处
- `<F10>` - 单步跳过
- `<F11>` - 单步进入
- `<F12>` - 单步退出

### 断点管理
- `<leader>bb` - 切换断点
- `<leader>dB` - 设置条件断点

### 调试操作
- `<leader>dc` - 运行到光标处
- `<leader>dl` - 运行上次调试
- `<leader>do` - 打开 REPL

## 代码运行
- `<leader>r` - 运行当前文件(normal 模式)
- 可视模式 `<leader>r` - 运行选中代码(SnipRun)

## 语言特定

### Markdown
- `<leader>md` - 切换 Markdown 预览

### 代码格式化
- `<leader>ij` - 格式化 JSON
- `<leader>is` - 格式化 SQL

### Treesitter
- `m` (operator 模式) - 跨语法树操作

## 包管理器 (Lazy)
- `<leader>ph` - 显示插件管理器
- `<leader>ps` - 同步插件
- `<leader>pu` - 更新插件
- `<leader>pi` - 安装插件
- `<leader>pl` - 显示日志
- `<leader>pc` - 检查插件
- `<leader>pd` - 调试插件
- `<leader>pp` - 性能分析
- `<leader>pr` - 恢复插件
- `<leader>px` - 清理插件

## 其他工具
- `<leader>nn` - 打开计算器(SwissCalc)

---

**说明:**
- `<leader>` 键通常映射为空格键或反斜杠
- `<C-x>` 表示 Ctrl+x
- `<A-x>` 表示 Alt+x
- `<S-x>` 表示 Shift+x
- `n|` 表示 normal 模式
- `v|` 表示 visual 模式
- `i|` 表示 insert 模式
- `t|` 表示 terminal 模式
- `c|` 表示 command 模式
