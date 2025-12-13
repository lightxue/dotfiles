---
name: spec-workflow
description: 当用户需要开发需求、创建技术方案/设计文档、规划任务、或遵循规范化开发流程时使用此技能。触发关键词包括"开发需求"、"技术方案"、"设计文档"、"任务规划"、"TAPD链接"、"需求开发流程"、"执行需求"等。引导用户完成4阶段标准化开发流程（准备→设计→规划→执行），包含自动化质量检查、人工审批门禁和wiki文档更新。
version: 3.2.0
author: codyyang
categories:
  - workflow
  - development
  - project-management
---

# Spec Workflow - 规范化需求开发工作流

## 🎯 核心职责

引导用户完成 **0→1→2→3** 四阶段规范化开发流程。

---

## 🚀 启动流程

```bash
# 1. 诊断当前阶段
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --status

# 2. 根据诊断结果读取对应阶段文档并执行
<SKILL_DIR>/references/phases/phase-{N}-*.md
```

---

## ⚡ 核心执行原则

| 原则         | 说明                                        |
| ------------ | ------------------------------------------- |
| **严格顺序** | 按 0→1→2→3 顺序执行,不可跳阶段,脚本强制检查 |
| **按需加载** | 只读当前阶段文档,不提前加载其他阶段内容     |
| **双重门禁** | 验证脚本 + 人工审批,缺一不可                |
| **用户主导** | 发现歧义必须暴露,不做假设性决策             |

---

## 🔁 标准执行循环

每个阶段遵循统一的执行模式：

1. **检查阶段** → 验证前置条件是否满足（`--check-phase N`）
2. **执行步骤** → 根据阶段文档生成输出文档
3. **验证文档** → 使用对应的验证脚本检查质量
4. **停止等待** → 验证通过后立即停止，展示审批提示
5. **人工审批** → 用户使用有效审批用语确认
6. **执行审批脚本** → 运行`--approve-phase`命令进入下一阶段

**验证失败处理**：最多重试 3 次，超过则停止等待人工修复。

---

## ⚠️ 审批门禁

每个阶段验证通过后，必须获得人工审批才能进入下一阶段。

**有效审批用语**：`审批通过` `确认无误` `同意` `批准` `可以` `没问题`  
**无效表达**：`继续` `好的` `下一步` `开始` `OK` `行`

**审批提示要求**：验证通过后展示审批提示，包含：

- 验证通过确认
- 交付物路径
- 有效审批用语列表
- 无效用语提醒

**收到审批后执行审批脚本**：

```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py \
    --approve-phase {N} \
    --approval "<当前对话用户回复的审批原文>" \
    --approver "<当前对话的用户名称>"
```

详细审批流程和完整话术清单见：`references/approval-guide.md`

---

## 📊 四阶段导航

| 阶段 | 名称      | 文档路径                 | 关键输出                         |
| ---- | --------- | ------------------------ | -------------------------------- |
| 0    | 前置准备  | `phase-0-preparation.md` | preparation.md                   |
| 1    | 设计方案  | `phase-1-design.md`      | design.md                        |
| 2    | 任务规划  | `phase-2-tasks.md`       | tasks.md                         |
| 3    | 执行+Wiki | `phase-3-execution.md`   | execution_summary.md + wiki 更新 |

**文档位置**: `<SKILL_DIR>/references/phases/`  
**产物目录**: `.specs/{feature_name}-{requirement_id}/`

---

## 🔧 工具命令速查

```bash
# 状态诊断
python3 <SKILL_DIR>/scripts/phase_gateway.py --status

# 检查阶段前置条件
python3 <SKILL_DIR>/scripts/phase_gateway.py --check-phase {N}

# 执行审批
python3 <SKILL_DIR>/scripts/phase_gateway.py \
    --approve-phase {N} \
    --approval "<当前对话用户回复的审批原文>" \
    --approver "<当前对话的用户名称>"

# 验证文档
python3 <SKILL_DIR>/scripts/validate_tasks.py <文档路径>
```

详细命令参考: `references/scripts-reference.md`  
审批流程详解: `references/approval-guide.md`

---

## 📚 如何使用此技能

### 执行流程

1. 运行阶段诊断脚本：`scripts/phase_gateway.py --status`
2. 根据当前阶段，读取对应的详细步骤文档：`references/phases/phase-{N}-*.md`
3. 按照步骤文档执行，生成输出文档到 `.specs/{feature-name}-{requirement-id}/`
4. 使用对应的验证脚本验证输出（如 `scripts/validate_design.py`）
5. 验证通过后，参考 `references/approval-guide.md` 完成审批
6. 进入下一阶段

### 关键资源引用

- **阶段步骤文档**：`references/phases/` - 每个阶段的详细操作指南
- **模板文件**：`assets/templates/` - 各阶段输出文档的模板
- **验证脚本**：`scripts/validate_*.py` - 自动化质量检查
- **流程控制**：`scripts/phase_gateway.py` - 阶段检查和审批管理
- **命令参考**：`references/scripts-reference.md` - 所有脚本的详细用法
- **审批指南**：`references/approval-guide.md` - 统一的审批流程规范
- **Wiki 生成**：`references/project_doc_init.md` - 项目 wiki 文档生成指南

### 特殊要求

- **需求获取**：优先使用 `tapd_mcp_http` 工具获取 TAPD 需求详情
- **Wiki 先行**：设计前必读项目 wiki 文档（见`project_doc_init.md`）
- **分组执行**：阶段 3 采用"分组 → 检查 → 确认"循环，最后必含 wiki 更新分组
- **重试限制**：验证失败最多 3 次，超过则停止等待人工修复
