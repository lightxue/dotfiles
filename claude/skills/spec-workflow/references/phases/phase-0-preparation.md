---
phase: 0
name: 前置准备
description: 获取需求、检查/生成wiki文档、验证wiki质量、生成前置准备文档
outputs: preparation.md + 审批通过
---

# 阶段0：前置准备

## 阶段目标

✅ 获取需求信息（TAPD或文字描述）  
✅ 确保项目wiki文档存在且质量合格  
✅ 理解项目架构和现状  
✅ 生成前置准备文档并通过审批  

## 强制执行清单

下列 5 个步骤 ✅ **全部完成**后，才能进入阶段 1。

### Step 0：验证工作空间状态 ⭐

**强制检查点**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --check-phase 0
```

**检查内容**：工作空间、依赖、脚本工具

**⚠️ 必须通过**（exit code = 0）才能开始阶段0

📖 **详细说明**：[验证操作手册 - 前置条件检查](../scripts-reference.md#5-phase_gatewaypy---check-phase-n---前置条件检查)

---

### Step 1：获取需求信息

根据用户输入类型处理：

#### 方式1：TAPD链接

使用 `tapd_mcp_http` 工具获取需求详情：
- 调用 `stories_get` 获取需求详情
- 提取：需求ID、标题、描述、验收标准
- requirement_id = TAPD需求ID（19位）

#### 方式2：文字描述

解析用户文字描述：
- 提取：功能需求、业务目标、验收标准
- requirement_id = YYYYMMDDXXX（日期+序号）

**输出确认**：
- 需求描述已明确
- 包含功能目标
- 包含用户场景
- 包含验收标准

---

### Step 2：检查/生成wiki文档

**检查位置**：
```bash
# 检查1+3文档结构是否存在
ls -la doc/README.md doc/architecture.md doc/interfaces.md doc/implementation.md 2>/dev/null && echo "✅ Wiki文档结构完整" || echo "❌ Wiki文档不存在或不完整"
```

**分支处理**：

#### 情况1：wiki文档已存在（1+3结构）

**操作要求**：
1. 读取 `doc/` 目录下的4个wiki文档：
   - `README.md` - 项目概览和导航
   - `architecture.md` - 架构设计和模块说明
   - `interfaces.md` - 接口定义和API文档
   - `implementation.md` - 实现细节和流程图

2. 理解项目现状：
   - 技术栈和依赖
   - 核心模块和职责
   - 接口定义和数据模型
   - 业务流程和实现细节

3. 确认wiki质量后进入Step 3验证

#### 情况2：wiki文档不存在 ⭐

**📋 详细执行规范**：[project_doc_init.md](../project_doc_init.md) ⭐

**快速摘要**：

**生成策略**：渐进式4步生成（降低失败率75%）
- 每步生成1个文档 → 独立验证 → 通过后继续
- 模板位置：`assets/templates/*.md.template`

**执行流程**：

**Step 2.1**：生成 README.md
- 基于模板：`<SKILL_DIR>/assets/templates/README.md.template`
- 输出路径：`doc/README.md`
- 验证：`python3 <SKILL_DIR>/scripts/validate_wiki.py doc/README.md`
- ⏸️ 验证通过后继续

**Step 2.2**：生成 architecture.md
- 基于模板：`<SKILL_DIR>/assets/templates/architecture.md.template`
- 输出路径：`doc/architecture.md`
- 验证：`python3 <SKILL_DIR>/scripts/validate_wiki.py doc/architecture.md`
- ⏸️ 验证通过后继续

**Step 2.3**：生成 interfaces.md
- 基于模板：`<SKILL_DIR>/assets/templates/interfaces.md.template`
- 输出路径：`doc/interfaces.md`
- 验证：`python3 <SKILL_DIR>/scripts/validate_wiki.py doc/interfaces.md`
- ⏸️ 验证通过后继续

**Step 2.4**：生成 implementation.md
- 基于模板：`<SKILL_DIR>/assets/templates/implementation.md.template`
- 输出路径：`doc/implementation.md`
- 验证：`python3 <SKILL_DIR>/scripts/validate_wiki.py doc/implementation.md`
- ⏸️ 验证通过后进入 Step 3

**关键要求**：
- ✅ 每个文档基于 `<SKILL_DIR>/assets/templates/` 下的对应模板生成（严格遵循章节结构）
- ✅ 每步独立验证（确保单文档质量）
- ✅ 分析重点、生成内容、质量标准详见 [project_doc_init.md](../project_doc_init.md)
- ✅ 禁止占位符或TODO，必须完整生成所有必需内容

**模板文件清单**：
- `README.md.template` - 项目概览模板
- `architecture.md.template` - 架构设计模板
- `interfaces.md.template` - 接口文档模板
- `implementation.md.template` - 实现细节模板

**⚠️ 详细的分析重点、生成内容要求、验证依据见**：[project_doc_init.md](../project_doc_init.md)

**📍 完成Step 2后，进入Step 3进行统一整体验证**

---

### Step 3：验证wiki文档 ⭐

**强制验证**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_wiki.py doc/
```

**验证内容**：
- ✅ 4个文档都存在（README + architecture + interfaces + implementation）
- ✅ 接口全量（interfaces.md）
- ✅ mermaid 流程图（implementation.md）
- ✅ 代码位置含行号
- ✅ 无占位符内容

**验证通过**（exit code = 0）后进入 Step 4

📖 **详细说明**：[验证操作手册 - validate_wiki.py](../scripts-reference.md#1-validate_wikipy---wiki文档验证)

---

### Step 4：生成前置准备文档 ⭐

**📋 模板文件**：`assets/templates/preparation.md.template` ⭐

**输出要求**：
- 基于模板：`<SKILL_DIR>/assets/templates/preparation.md.template`
- 输出路径：`.specs/{feature_name}-{requirement_id}/preparation.md`
- 替换所有占位符为实际内容

**文档内容**：
1. **需求信息**：
   - 需求ID、标题、描述、验收标准
   - 需求来源（TAPD链接或文字描述）

2. **Wiki文档验证**：
   - Wiki文件路径和质量检查结果
   - 粘贴 `validate_wiki.py` 的完整输出

3. **项目架构理解**：
   - 技术栈总结
   - 项目目录结构
   - 核心模块说明
   - 关键API接口
   - 数据模型概览

4. **需求与项目现状关联分析**：
   - 需求涉及的模块
   - 潜在风险点识别

5. **开发环境准备**：
   - 开发工具检查
   - 本地环境验证
   - 代码仓库状态

6. **前置准备完成确认**：
   - 检查清单（所有项必须勾选）
   - 阶段输出确认

**⚠️ 质量要求**：
- 所有占位符必须替换为实际内容
- Wiki验证结果必须完整粘贴
- 项目架构理解必须基于Wiki文档
- 不能有 `{占位符}` 或 `TODO` 等未完成标记

---

### Step 5：等待人工审批 ⭐

**⚠️ 审批约束**：必须使用有效审批用语（详见 [审批操作手册](../approval-guide.md)）

**✅ 有效**：`审批通过` `确认无误` `同意` `批准` `可以` `没问题`  
**❌ 无效**：`继续` `好的` `下一步` `开始` `OK` `行`

**执行要点**：
1. 生成文档后 → ⏸️ 停止并展示审批提示
2. 等待用户输入 → 🔍 检查是否含有效用语
3. 有效 → 执行审批命令 | 无效 → 重新提示（不得重试）

**审批提示要求**：
展示审批提示，包含：
- 文档路径（`.specs/{feature_name}-{requirement_id}/preparation.md`）
- 审阅要点（需求准确性、wiki质量、架构理解）
- 有效审批用语说明（审批通过/确认无误/同意/批准/可以/没问题）
- 无效用语提醒（继续/好的/下一步/开始/OK/行）

**审批命令**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --approve-phase 0 --approval "<当前对话用户回复的审批原文>" --approver "<当前对话的用户名称>"
```

**详细流程与约束**：[审批操作手册 - 标准流程](../approval-guide.md#审批执行流程标准话术)
---

## 阶段完成输出

审批通过后，输出以下状态：

```markdown
## 📋 阶段 0 已完成

**项目名称**: {feature_name}
**需求 ID**: {requirement_id}
**需求来源**: {TAPD 链接 或 用户文字描述}
**文档目录**: .specs/{feature_name}-{requirement_id}/

### 已完成的工作

- ✅ 需求信息已获取
- ✅ 项目 wiki 文档已检查/生成
- ✅ Wiki 文档验证通过
- ✅ 前置准备文档已生成（preparation.md）
- ✅ 阶段0审批已通过

### 阶段输出

- ✅ 前置准备文档：.specs/{feature_name}-{requirement_id}/preparation.md
- ✅ Wiki文档：doc/目录下4个文档
  - doc/README.md
  - doc/architecture.md
  - doc/interfaces.md
  - doc/implementation.md
- ✅ 阶段状态：completed

### 下一步

**准备进入**: 阶段 1 - 设计方案

**关键任务**：
1. 验证前置条件（强制检查点）
2. 分析依赖服务
3. 生成设计方案（design.md）
4. 验证设计文档
5. 等待人工审批
5. 请求审批

**预计时间**: 30-60 分钟

📋 详细步骤请查看：[阶段1: 设计方案](phase-1-design.md)
```

---

## 强制约束

🚫 **禁止进入阶段1的情况**：任何步骤未完成

**严格要求**：
- 禁止跳过任何步骤
- 禁止"先做阶段1，后补阶段0"
- 必须按顺序完成所有步骤

---

## 相关文档

- [Wiki生成规范](../project_doc_init.md) - 详细的8步分析流程
- [阶段1: 设计方案](phase-1-design.md) - 下一阶段

