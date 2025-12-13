# Spec Workflow - 规范化需求开发工作流

[![Version](https://img.shields.io/badge/version-3.2.0-blue.svg)](SKILL.md)
[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> 一个标准化、自动化的 4 阶段需求开发工作流，确保从需求到交付的质量和可追溯性。

## 📖 目录

- [核心特性](#-核心特性)
- [快速开始](#-快速开始)
- [工作流程](#-工作流程)
- [目录结构](#-目录结构)
- [使用指南](#-使用指南)
- [脚本工具](#-脚本工具)
- [文档模板](#-文档模板)
- [常见问题](#-常见问题)
- [贡献指南](#-贡献指南)

## 🎯 核心特性

### 🔄 四阶段标准流程

```
阶段 0: 前置准备 → 阶段 1: 设计方案 → 阶段 2: 任务规划 → 阶段 3: 执行+Wiki更新
    ↓                 ↓                   ↓                    ↓
preparation.md    design.md           tasks.md         execution_summary.md
                                                        + wiki 更新
```

### ✨ 关键优势

- **🚀 严格顺序执行**：按 0→1→2→3 顺序执行，不可跳阶段，脚本强制检查
- **🔍 自动化验证**：每个阶段都有对应的验证脚本，确保输出质量
- **🛡️ 双重门禁**：验证脚本 + 人工审批，缺一不可
- **📝 标准化文档**：提供完整的文档模板和示例
- **🔧 工具支持**：完善的脚本工具链，自动化检查和状态管理
- **📚 知识沉淀**：项目 Wiki 文档（1+3结构）+ 需求文档（.specs/）完整归档

## 🚀 快速开始

### 前置要求

- Python 3.8+
- 项目代码库已初始化（Git仓库）
- （可选）TAPD 需求管理系统访问权限

### 第一步：诊断当前阶段

```bash
cd <项目根目录>
python3 <SKILL_DIR>/scripts/phase_gateway.py --status
```

### 第二步：执行对应阶段

根据诊断结果，阅读对应的阶段文档并执行：

```bash
# 例如：当前在阶段 0
cat <SKILL_DIR>/references/phases/phase-0-preparation.md
```

### 第三步：验证和审批

每个阶段完成后：

1. 运行验证脚本检查输出质量
2. 验证通过后，等待人工审批
3. 使用有效审批用语（`审批通过`、`确认无误`、`同意` 等）
4. 执行审批命令进入下一阶段

## 📋 工作流程

### 阶段概览

| 阶段 | 名称          | 关键输出                      | 验证方式               | 耗时    |
| ---- | ------------- | ----------------------------- | ---------------------- | ------- |
| 0    | 前置准备      | preparation.md + wiki文档     | `validate_wiki.py`     | 20-40分 |
| 1    | 设计方案      | design.md                     | `validate_design.py`   | 30-60分 |
| 2    | 任务规划      | tasks.md                      | `validate_tasks.py`    | 20-40分 |
| 3    | 执行+Wiki更新 | execution_summary.md + wiki更新 | 质量检查清单 + `validate_wiki.py` | 视任务而定 |

### 执行原则

#### ⚡ 核心原则

| 原则         | 说明                                        |
| ------------ | ------------------------------------------- |
| **严格顺序** | 按 0→1→2→3 顺序执行，不可跳阶段，脚本强制检查 |
| **按需加载** | 只读当前阶段文档，不提前加载其他阶段内容     |
| **双重门禁** | 验证脚本 + 人工审批，缺一不可                |
| **用户主导** | 发现歧义必须暴露，不做假设性决策             |

#### 🔁 标准执行循环

每个阶段遵循统一的执行模式：

1. **检查阶段** → 验证前置条件是否满足（`--check-phase N`）
2. **执行步骤** → 根据阶段文档生成输出文档
3. **验证文档** → 使用对应的验证脚本检查质量
4. **停止等待** → 验证通过后立即停止，展示审批提示
5. **人工审批** → 用户使用有效审批用语确认
6. **执行审批脚本** → 运行 `--approve-phase` 命令进入下一阶段

**验证失败处理**：最多重试 3 次，超过则停止等待人工修复。

### 阶段详解

#### 阶段 0：前置准备

**目标**：获取需求信息，确保项目 Wiki 文档完整

**关键步骤**：
1. 获取需求（TAPD链接或文字描述）
2. 检查/生成项目 Wiki 文档（1+3结构）
3. 验证 Wiki 文档质量
4. 生成前置准备文档
5. 人工审批

**输出**：
- `preparation.md` - 前置准备文档
- `doc/README.md` - 项目概览
- `doc/architecture.md` - 架构设计
- `doc/interfaces.md` - 接口文档
- `doc/implementation.md` - 实现细节

**验证**：
```bash
python3 <SKILL_DIR>/scripts/validate_wiki.py doc/
```

#### 阶段 1：设计方案

**目标**：生成完整的技术设计方案

**关键步骤**：
1. 分析依赖服务（如需要）
2. 生成设计方案文档
3. 澄清歧义与待确认项
4. 验证设计文档
5. 人工审批

**输出**：
- `design.md` - 技术设计文档（包含 8 个必需章节）

**验证**：
```bash
python3 <SKILL_DIR>/scripts/validate_design.py .specs/{feature_name}-{requirement_id}/design.md
```

#### 阶段 2：任务规划

**目标**：将设计方案拆解为可执行的任务

**关键步骤**：
1. 拆解设计为具体任务
2. 建立任务依赖关系
3. 生成任务规划文档
4. 验证任务规划
5. 人工审批

**输出**：
- `tasks.md` - 任务规划文档（包含分组、依赖图、验收清单）

**验证**：
```bash
python3 <SKILL_DIR>/scripts/validate_tasks.py .specs/{feature_name}-{requirement_id}/tasks.md
```

#### 阶段 3：执行+Wiki更新

**目标**：执行任务并更新项目 Wiki 文档

**关键步骤**：
1. 分组执行任务（每组 3-5 个任务）
2. 执行质量检查
3. 用户确认后继续下一组
4. 最后必须包含 Wiki 更新分组
5. 生成执行总结文档
6. 人工审批

**输出**：
- `execution_summary.md` - 执行总结文档
- 更新的 Wiki 文档（doc/ 目录）

**验证**：
```bash
# 质量检查清单（人工）
# Wiki 更新验证
python3 <SKILL_DIR>/scripts/validate_wiki.py doc/
```

## 📁 目录结构

```
spec-workflow/
├── SKILL.md                    # Skill 配置和入口文档
├── README.md                   # 本文档
├── .pylintrc                   # Python 代码规范配置
│
├── assets/                     # 资源文件
│   └── templates/              # 文档模板
│       ├── README.md.template
│       ├── architecture.md.template
│       ├── interfaces.md.template
│       ├── implementation.md.template
│       ├── preparation.md.template
│       ├── design.md.template
│       ├── tasks.md.template
│       └── execution_summary.md.template
│
├── scripts/                    # 脚本工具
│   ├── path_utils.py           # 路径工具
│   ├── phase_gateway.py        # 阶段检查和审批
│   ├── validate_wiki.py        # Wiki 文档验证
│   ├── validate_design.py      # 设计文档验证
│   └── validate_tasks.py       # 任务规划验证
│
├── references/                 # 参考文档
│   ├── approval-guide.md       # 审批操作手册
│   ├── project_doc_init.md     # 项目 Wiki 生成指南
│   ├── scripts-reference.md    # 脚本命令参考
│   └── phases/                 # 各阶段详细步骤
│       ├── phase-0-preparation.md
│       ├── phase-1-design.md
│       ├── phase-2-tasks.md
│       └── phase-3-execution.md
│
└── examples/                   # 示例项目
    ├── README.md
    └── user-login-20241106001/ # 用户登录功能示例
        ├── design.md
        ├── tasks.md
        └── IMPLEMENTATION.md
```

### 项目中的文件结构

使用本工作流后，项目中会生成以下结构：

```
<项目根目录>/
├── doc/                        # 项目 Wiki 文档（1+3结构）
│   ├── README.md               # 项目概览
│   ├── architecture.md         # 架构设计
│   ├── interfaces.md           # 接口文档
│   └── implementation.md       # 实现细节
│
└── .specs/                     # 需求文档目录
    └── {feature_name}-{requirement_id}/
        ├── preparation.md      # 阶段0输出
        ├── design.md           # 阶段1输出
        ├── tasks.md            # 阶段2输出
        └── execution_summary.md # 阶段3输出
```

## 💡 使用指南

### 审批机制

#### 有效审批用语

**必须使用以下任一用语**：
- ✅ `审批通过`
- ✅ `确认无误`
- ✅ `同意`
- ✅ `批准`
- ✅ `可以`
- ✅ `没问题`

#### 无效审批用语

**以下用语不会触发审批**：
- ❌ `继续`
- ❌ `好的`
- ❌ `下一步`
- ❌ `开始`
- ❌ `OK`
- ❌ `行`

#### 审批流程

1. 验证脚本通过后，系统会展示审批提示
2. 用户输入有效审批用语
3. 系统执行审批命令：
   ```bash
   python3 <SKILL_DIR>/scripts/phase_gateway.py \
       --approve-phase {N} \
       --approval "<用户审批原文>" \
       --approver "<用户名称>"
   ```
4. 审批通过后，进入下一阶段

详细说明见：[审批操作手册](references/approval-guide.md)

### 需求来源

#### 方式 1：TAPD 链接

提供 TAPD 需求链接，系统会自动获取：
- 需求 ID（19位）
- 需求标题
- 需求描述
- 验收标准

#### 方式 2：文字描述

直接描述需求内容，包含：
- 功能需求
- 业务目标
- 验收标准
- 需求 ID 自动生成为 `YYYYMMDDXXX`

### Wiki 文档生成

#### 1+3 结构

项目 Wiki 采用 "1+3" 结构：
- **1** 个概览文档：`README.md`
- **3** 个专题文档：
  - `architecture.md` - 架构设计
  - `interfaces.md` - 接口文档
  - `implementation.md` - 实现细节

#### 生成策略

**渐进式 4 步生成**（降低失败率 75%）：
1. 生成 `README.md` → 验证 → 通过后继续
2. 生成 `architecture.md` → 验证 → 通过后继续
3. 生成 `interfaces.md` → 验证 → 通过后继续
4. 生成 `implementation.md` → 验证 → 完成

每步基于对应的模板文件生成，确保结构一致性。

详细说明见：[项目 Wiki 生成指南](references/project_doc_init.md)

## 🔧 脚本工具

### phase_gateway.py - 阶段检查和审批

**主要功能**：
- 查看工作流状态
- 检查阶段前置条件
- 执行阶段审批
- 检查环境依赖

**常用命令**：

```bash
# 查看当前状态
python3 scripts/phase_gateway.py --status

# 检查是否可进入阶段 N
python3 scripts/phase_gateway.py --check-phase {N}

# 审批阶段 N
python3 scripts/phase_gateway.py \
    --approve-phase {N} \
    --approval "<审批原文>" \
    --approver "<用户名称>"

# 检查环境依赖
python3 scripts/phase_gateway.py --check-env
```

### validate_wiki.py - Wiki 文档验证

**验证内容**：
- ✅ 4 个文档都存在（README + architecture + interfaces + implementation）
- ✅ 接口全量（interfaces.md）
- ✅ mermaid 流程图（implementation.md）
- ✅ 代码位置含行号
- ✅ 无占位符内容

**使用方式**：

```bash
# 验证整个 doc/ 目录
python3 scripts/validate_wiki.py doc/

# 验证单个文档
python3 scripts/validate_wiki.py doc/README.md
```

### validate_design.py - 设计文档验证

**验证内容**：
- ✅ 8 个必需章节完整
- ✅ mermaid 流程图存在
- ✅ 歧义与待确认清单格式正确
- ✅ 依赖服务调用说明完整
- ✅ 无占位符内容

**使用方式**：

```bash
python3 scripts/validate_design.py .specs/{feature_name}-{requirement_id}/design.md
```

### validate_tasks.py - 任务规划验证

**验证内容**：
- ✅ 任务分组结构完整
- ✅ 每个任务包含必需字段
- ✅ 分组依赖关系图（mermaid）
- ✅ 验收清单完整
- ✅ 任务时长合理（10-15分钟）

**使用方式**：

```bash
python3 scripts/validate_tasks.py .specs/{feature_name}-{requirement_id}/tasks.md
```

详细说明见：[脚本命令参考](references/scripts-reference.md)

## 📄 文档模板

### 模板列表

| 模板文件                        | 用途                  | 使用阶段 |
| ------------------------------- | --------------------- | -------- |
| `README.md.template`            | 项目概览              | 阶段 0   |
| `architecture.md.template`      | 架构设计              | 阶段 0   |
| `interfaces.md.template`        | 接口文档              | 阶段 0   |
| `implementation.md.template`    | 实现细节              | 阶段 0   |
| `preparation.md.template`       | 前置准备文档          | 阶段 0   |
| `design.md.template`            | 技术设计文档          | 阶段 1   |
| `tasks.md.template`             | 任务规划文档          | 阶段 2   |
| `execution_summary.md.template` | 执行总结文档          | 阶段 3   |

### 使用方式

所有模板都位于 `assets/templates/` 目录下。生成文档时：

1. 基于对应的模板文件
2. 替换所有占位符（`{变量名}`）
3. 填充实际内容
4. 确保无 `TODO` 或未完成标记
5. 运行验证脚本检查质量

### 示例项目

查看 `examples/user-login-20241106001/` 目录获取完整示例：
- 完整的设计文档
- 详细的任务规划
- 实现代码示例

详细说明见：[示例项目说明](examples/README.md)

## ❓ 常见问题

### Q1: 可以跳过某个阶段吗？

**不可以**。工作流强制按 0→1→2→3 顺序执行，`phase_gateway.py` 会检查前置条件。

### Q2: 验证脚本失败怎么办？

1. 查看错误信息，定位问题
2. 修复文档内容
3. 重新运行验证脚本
4. 最多重试 3 次
5. 3 次失败后停止，等待人工修复

### Q3: 审批用语为什么这么严格？

为了确保：
- 用户明确知道当前需要审批
- 避免误操作（如"继续"被误解为审批）
- 保持审批记录的严肃性和可追溯性

### Q4: 多个需求并行开发怎么办？

每个需求在 `.specs/` 目录下有独立的子目录：
```
.specs/
├── feature-a-20241106001/
│   ├── design.md
│   └── tasks.md
└── feature-b-20241106002/
    ├── design.md
    └── tasks.md
```

状态管理也是独立的，互不干扰。

### Q5: Wiki 文档已存在，还需要重新生成吗？

不需要。阶段 0 会检查 Wiki 文档是否存在：
- 存在且验证通过：直接使用
- 不存在或不完整：按 1+3 结构生成

### Q6: 设计方案需要修改怎么办？

1. 直接编辑 `design.md`
2. 重新运行 `validate_design.py`
3. 重新请求审批
4. 建议同步更新 `tasks.md`

详细说明见各阶段文档中的"阶段回退机制"章节。

### Q7: 验证脚本有哪些检查项？

每个验证脚本的详细检查项见：[脚本命令参考](references/scripts-reference.md)

### Q8: 如何查看工作流当前状态？

```bash
python3 scripts/phase_gateway.py --status
```

会显示：
- 当前阶段
- 已完成阶段
- 需求 ID
- 创建和更新时间

## 🤝 贡献指南

### 添加新示例

如果你有典型场景的完整示例，欢迎贡献：

1. 创建示例目录：`examples/feature-name-YYYYMMDDXXX/`
2. 基于最新模板创建文档
3. 通过所有验证脚本
4. 更新 `examples/README.md`

### 改进建议

欢迎提出改进建议：
- 验证规则优化
- 文档模板改进
- 工具脚本增强
- 流程优化建议

### 报告问题

遇到问题时，请提供：
- 错误信息和堆栈跟踪
- 执行的命令
- 相关文档内容（脱敏后）
- Python 版本和操作系统

## 📚 相关文档

### 核心文档

- [SKILL.md](SKILL.md) - Skill 配置和入口
- [审批操作手册](references/approval-guide.md) - 审批流程详解
- [脚本命令参考](references/scripts-reference.md) - 所有脚本命令详解
- [项目 Wiki 生成指南](references/project_doc_init.md) - Wiki 文档生成详解

### 阶段文档

- [阶段 0：前置准备](references/phases/phase-0-preparation.md)
- [阶段 1：设计方案](references/phases/phase-1-design.md)
- [阶段 2：任务规划](references/phases/phase-2-tasks.md)
- [阶段 3：执行+Wiki更新](references/phases/phase-3-execution.md)

### 示例

- [示例项目说明](examples/README.md)
- [用户登录功能示例](examples/user-login-20241106001/)

## 📝 版本历史

| 版本  | 日期       | 主要变更                                 |
| ----- | ---------- | ---------------------------------------- |
| 3.2.0 | 2025-11-28 | 当前版本，完善审批机制和验证规范         |
| 3.1.0 | 2025-11-27 | 优化阶段检查和审批流程                   |
| 3.0.0 | 2024-11-15 | 重构为 4 阶段工作流，新增 Wiki 生成      |
| 2.0.0 | 2024-11-01 | 新增验证脚本和审批机制                   |
| 1.0.0 | 2024-10-15 | 初始版本，基础工作流框架                 |

## 📄 许可证

MIT License

---

**Made with ❤️ by the Development Team**

如有问题或建议，欢迎提出 Issue 或 Pull Request！
