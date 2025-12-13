---
type: reference
description: Spec Workflow 脚本命令完整参考手册（含验证规范）
version: 3.3.0
updated: 2025-11-27
changes: "v3.3.0: 语气调整，删除'AI'相关表述，符合Skill最佳实践"
---

# Spec 工作流 - 脚本命令参考手册

## 文档定位

本文档是 Spec Workflow 的**脚本命令速查表与验证规范**，提供所有验证、审批脚本的详细用法和执行标准。

### 使用场景

- 🔍 执行具体阶段时，查找对应的脚本命令
- ✅ 了解验证通过标准和失败处理流程
- 🔀 多需求并行时，查找状态隔离的配置方式
- 🐛 调试时，查找脚本的详细参数和输出格式
- 📋 快速定位"阶段X用哪个脚本"

### 与其他文档的关系

| 文档 | 定位 | 何时阅读 |
|------|------|------------|
| [skill.md](../skill.md) | 工作流高层入口 | 首次使用或查看概览 |
| [phases/*.md](./phases/) | 各阶段详细步骤 | 执行具体阶段时按需读取 |
| **本文档** | **脚本命令参考+验证规范** | **需要执行脚本或了解验证标准时查阅** |

---

## 🎯 验证核心原则

1. **质量门禁**：验证脚本是进入审批的前提条件
2. **自动化检查**：通过脚本自动检查文档规范和内容完整性
3. **明确标准**：通过标准清晰，失败原因可追溯
4. **失败即停**：验证失败必须修复后重试，禁止跳过

## ✅ 验证通过判断标准

**所有验证脚本的通过标准**（需同时满足）：

| 标准项 | 说明 | 示例 |
|-------|------|------|
| Exit Code | 返回值为 0 | `echo $?` 输出 0 |
| 成功标记 | 输出包含 "✅" | `✅ 验证通过` |
| 无严重错误 | 无 CRITICAL/ERROR 级别 | 仅允许 WARNING |

**验证执行流程**（标准话术）：
```
步骤1: 运行验证脚本
步骤2: 检查退出码 (exit code)
       ↓ 0
步骤3: ✅ 验证通过 → 进入审批流程
       ↓ 非0
步骤4: ❌ 验证失败 → 分析错误 → 修复问题
步骤5: 重新运行验证脚本（最多重试3次）
步骤6: 3次失败后 → ⏸️ 停止并等待用户指示
```

---

## 阶段导航表

快速定位每个阶段对应的脚本命令：

| 阶段 | 名称 | 详细步骤文档 | 验证脚本 | 使用频率 |
|------|------|--------------|----------|----------|
| 0 | 前置准备 | [phase-0-preparation.md](phases/phase-0-preparation.md) | `validate_wiki.py` | ⭐⭐⭐⭐ |
| 1 | 设计方案 | [phase-1-design.md](phases/phase-1-design.md) | `validate_design.py` | ⭐⭐⭐⭐⭐ |
| 2 | 任务规划 | [phase-2-tasks.md](phases/phase-2-tasks.md) | `validate_tasks.py` | ⭐⭐⭐⭐⭐ |
| 3 | 计划执行+wiki更新 | [phase-3-execution.md](phases/phase-3-execution.md) | 人工质量检查清单 + `validate_wiki.py` | ⭐⭐⭐⭐⭐ |

---

## 1. 阶段检查点脚本

### 查看工作流状态

```bash
# 查看完整工作流状态
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --status
```

**关键输出字段**：
- `current_phase` - 当前所在阶段（0-4）
- `completed_phases` - 已完成阶段列表
- `created_at` - 工作流创建时间
- `last_updated` - 最后更新时间

### 检查阶段前置条件

```bash
# 检查是否可以进入阶段 N（0-4）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --check-phase <N>

# 示例：检查是否可以进入阶段1
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --check-phase 1
```

**返回值**：
- `exit code 0` - ✅ 检查通过，可进入该阶段
- `exit code 1` - ❌ 检查失败，前置条件未满足

### 审批阶段

```bash
# 所有阶段（0, 1, 2, 3, 4）统一需要审批
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --approve-phase <N> --approval "<当前对话用户回复的审批原文>" --approver "<当前对话的用户名称>"

# 示例
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --approve-phase 1 --approval "确认无误" --approver "张三"
```

📖 **审批参数详解**：参见[审批操作手册 - 审批执行流程](approval-guide.md#审批执行流程标准话术)

### 重置工作流

```bash
# 重置整个工作流状态（谨慎使用）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --reset
```

**⚠️ 警告**：此操作会删除所有阶段进度，仅在需要完全重新开始时使用。

---

## 2. 文档验证脚本

### validate_design.py - 验证设计方案（阶段1）

```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_design.py .specs/{name}-{id}/design.md

# 示例
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_design.py .specs/user-login-20241110001/design.md
```

**验证内容**：
- ✅ 8个必需章节是否完整
- ✅ 歧义清单是否存在且非空
- ✅ 架构图是否包含
- ✅ 文件路径和行号引用格式

### validate_tasks.py - 验证任务规划（阶段2/阶段3）

```bash
# 阶段2（规划阶段）- 验收清单未勾选仅警告
python3 scripts/validate_tasks.py .specs/{name}-{id}/tasks.md --phase planning

# 阶段3（执行完成）- 验收清单未勾选升级为错误（强制要求）
python3 scripts/validate_tasks.py .specs/{name}-{id}/tasks.md --phase execution

# 示例
python3 scripts/validate_tasks.py .specs/user-login-20241110001/tasks.md --phase execution
```

**参数说明**：
- `--phase planning`（默认）：阶段2规划阶段,验收清单未勾选项仅警告
- `--phase execution`（阶段3必须）：阶段3执行完成,验收清单必须全部勾选才能通过

**验证内容**：
- ✅ 任务分组是否合理（每组2-4个任务）
- ✅ 验收标准是否明确
- ✅ 预估工时是否填写
- ✅ 质量检查清单是否完整
- ✅ **阶段3：验收清单是否全部勾选（强制）**

**阶段3验收清单要求**：
```markdown
# 错误示例（阶段3会报错）
- [ ] 所有分组执行完成  ← 未勾选

# 正确示例
- [x] 所有分组执行完成  ← 已勾选
```

### validate_wiki.py - 验证Wiki文档（阶段0、阶段3）

**文档结构**：1+3文档结构（README + architecture + interfaces + implementation）

```bash
# 验证整个文档目录（推荐）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/

# 验证单个文档（渐进式生成时使用）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/README.md
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/architecture.md
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/interfaces.md
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/implementation.md

# JSON输出（用于自动化）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/ --json
```

**验证内容**（目录验证模式）：
- ✅ 4个文档是否都存在（README + architecture + interfaces + implementation）
- ✅ 每个文档的必需章节是否完整
- ✅ 接口文档是否包含完整接口列表和代码位置
- ✅ 流程图是否包含代码位置标注
- ✅ Mermaid 图表语法是否正确
- ✅ 无占位符或TODO标记

**验证内容**（单文档验证模式）：
- ✅ 文档的必需章节是否完整
- ✅ 代码位置标注格式是否正确
- ✅ Mermaid 图表（如需要）语法是否正确
- ✅ 无占位符或TODO标记

**必需章节清单**：
- `README.md`：快速导航、项目结构、核心模块
- `architecture.md`：整体架构、模块划分、数据模型、技术选型
- `interfaces.md`：接口总览、核心接口详细定义
- `implementation.md`：核心业务流程、关键实现点

📖 **详细规范**：参见 [project_doc_init.md](project_doc_init.md) - Wiki生成规范

---

## 3. 脚本输出格式规范

### Exit Code规范

| Exit Code | 说明 |
|-----------|------|
| 0 | ✅ 成功（验证通过/审批通过） |
| 1 | ❌ 失败（验证失败/审批拒绝/前置条件未满足） |
| 2 | ⚠️ 参数错误 |
| 3 | ⚠️ 文件不存在 |

### 输出格式

**验证脚本**（`validate_*.py`）：
```
✅ 所有检查通过！
或
❌ 发现以下错误（必须修复）：
  1. 错误描述
💡 修复建议：...
```

**JSON模式**（可选）：
```bash
python3 scripts/validate_*.py <file> --json
# 输出: {"success": true/false, "errors": [...], "warnings": [...]}
```

---

## 4. 调试技巧

### 查看详细日志

```bash
# 启用详细日志模式（如果脚本支持）
python3 scripts/phase_gateway.py --status --verbose
```

### 常见问题排查

| 问题 | 排查步骤 |
|------|----------|
| 验证脚本一直失败 | 查看错误信息，按提示修复文档 |
| 审批被拒绝 | 检查是否使用了有效审批用语 |
| 阶段检查失败 | 运行 `--status` 查看缺失步骤 |

---

## 相关文档

- [skill.md](../skill.md) - 工作流框架和入口
- [Wiki生成规范](./project_doc_init.md) - 8步分析流程
- [阶段0-3文档](./phases/) - 各阶段详细步骤
- [审批规范](./approval-guide.md) - 审批用语和流程
- [阶段0: 前置准备](phases/phase-0-preparation.md)
- [阶段1: 设计方案](phases/phase-1-design.md)
- [阶段2: 任务规划](phases/phase-2-tasks.md)
- [阶段3: 计划执行](phases/phase-3-execution.md)（包含wiki更新）
