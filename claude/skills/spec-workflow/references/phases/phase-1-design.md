---
phase: 1
name: 设计方案
description: 分析依赖、生成设计文档、验证设计、请求审批
outputs: design.md + 审批通过
---

# 阶段1：设计方案

## 阶段目标

✅ 分析依赖服务调用  
✅ 生成完整设计方案（design.md）  
✅ 通过设计文档验证  
✅ 获得用户审批通过  

## 强制执行清单

下列 4 个步骤 ✅ **全部完成**后，才能进入阶段 2。

### Step 0：验证前置条件 ⭐

**强制检查点**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --check-phase 1
```

**检查内容**：阶段0完成状态、wiki验证、需求信息齐全

**⚠️ 必须通过**（exit code = 0）才能进入阶段1

📖 **详细说明**：[验证操作手册 - 前置条件检查](../scripts-reference.md#5-phase_gatewaypy---check-phase-n---前置条件检查)

---

### Step 1：依赖服务分析

根据需求判断是否涉及依赖服务调用：

**涉及依赖服务**：
- 使用 `THWiki-MCP-Server` 检索依赖服务文档
- 检索范围：yibao（医保服务）、thcomm（通用组件）
- 获取：接口规范、调用方式、注意事项
- 在设计方案中详细说明调用方式

**不涉及依赖服务**：
- 在设计方案中标注"无依赖服务调用"
- 直接进入架构设计阶段

---

### Step 2：生成设计方案

**输出要求**：
- 基于模板：`<SKILL_DIR>/assets/templates/design.md.template`
- 输入内容：需求内容 + 项目wiki（1+3结构）+ 依赖服务文档
- 输出路径：`.specs/{feature_name}-{requirement_id}/design.md`

**Wiki文档参考**：
- `doc/README.md` - 项目概览和技术栈
- `doc/architecture.md` - 架构设计和模块说明
- `doc/interfaces.md` - 接口定义和API文档
- `doc/implementation.md` - 实现细节和流程图

**必需章节**（8个）：

1. **需求说明**
   - 需求来源（TAPD链接或文字描述）
   - 功能描述
   - 用户场景
   - 验收标准

2. **项目现状分析**
   - 基于 wiki 文档分析（`doc/architecture.md` + `doc/interfaces.md` + `doc/implementation.md`）
   - 现有架构说明
   - 相关模块识别
   - 改动影响范围

3. **歧义与待确认清单** ⭐
   
   **分组结构**（必须按此顺序）：
   ```markdown
   ### 需求理解疑问
   - [ ] 待确认项1
   - [ ] 待确认项2
   
   ### 技术方案待定项
   - [ ] 待确认项3
   - [ ] 待确认项4
   
   ### 边界条件确认
   - [ ] 待确认项5
   - [ ] 待确认项6
   ```
   
   **强制要求**：
   - 所有待确认项使用 `- [ ]` 未勾选格式
   - 禁止自行标记为 `- [x]` 已确认
   - 如确实无歧义，明确标注「无」
   
   **执行约束**：
   - 生成设计文档后，立即停止并向用户展示待确认清单
   - 按分组依次澄清（需求理解 → 技术方案 → 边界条件）
   - 每组可一次性展示，等待用户回答后更新文档
   - 禁止自行猜测或假设答案
   - 所有分组澄清完毕后，才能执行验证脚本

4. **架构设计**
   - 系统架构图（mermaid）
   - 模块划分
   - 改动说明
   - 数据流向

5. **接口设计**
   - 新增 API 接口
   - 修改 API 接口
   - 数据模型定义
   - 请求/响应示例

6. **依赖服务调用**
   - 调用的依赖服务列表
   - 接口规范说明
   - 调用时序图（mermaid）
   - 或标注"无依赖服务调用"

7. **技术难点和对策**
   - 识别技术难点
   - 解决方案
   - 备选方案

8. **风险识别与应对**
   - 技术风险识别
   - 影响范围分析
   - 技术应对方案
   - 监控建议

📋 **模板参考**：
- [设计方案模板](../../assets/templates/design.md.template)
- [完整案例](../../examples/user-login-20241106001/design.md)

---

### Step 3：验证设计文档 ⭐

**强制验证**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_design.py .specs/{feature_name}-{requirement_id}/design.md
```

**验证通过**（exit code = 0）后进入 Step 4

📖 **详细说明**：[验证操作手册 - validate_design.py](../scripts-reference.md#2-validate_designpy---设计文档验证)

---

### Step 4：等待人工审批 ⭐

**⚠️ 审批约束**：必须使用有效审批用语（详见 [审批操作手册](../approval-guide.md)）

**✅ 有效**：`审批通过` `确认无误` `同意` `批准` `可以` `没问题`  
**❌ 无效**：`继续` `好的` `下一步` `开始` `OK` `行`

**执行要点**：
1. 澄清所有歧义项 + 验证通过后 → ⏸️ 停止并展示审批提示
2. 等待用户输入 → 🔍 检查是否含有效用语
3. 有效 → 执行审批命令 | 无效 → 重新提示（不得重试）

**审批提示要求**：
展示审批提示，包含：
- 文档路径（`.specs/{feature_name}-{requirement_id}/design.md`）
- 审阅要点（需求准确性、技术方案合理性、歧义澄清充分性）
- 有效审批用语说明（审批通过/确认无误/同意/批准/可以/没问题）
- 无效用语提醒（继续/好的/下一步/开始/OK/行）

**审批命令**：
```bash
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --approve-phase 1 --approval "<当前对话用户回复的审批原文>" --approver "<当前对话的用户名称>"
```

**详细流程与约束**：[审批操作手册 - 标准流程](../approval-guide.md#审批执行流程标准话术)
---

## 如需修改本阶段

### 阶段回退机制

如果阶段1完成后，发现设计方案需要调整：

**直接修改文档**：
```bash
# 1. 直接编辑设计文档
vim .specs/{feature_name}-{requirement_id}/design.md

# 2. 重新验证
cd <项目根目录> && python3 <SKILL_DIR>/scripts/validate_design.py .specs/{feature_name}-{requirement_id}/design.md

# 3. 重新请求审批（使用用户当前对话回复的原文）
cd <项目根目录> && python3 <SKILL_DIR>/scripts/phase_gateway.py --approve-phase 1 --approval "<当前对话用户回复的审批原文>" --approver "<当前对话的用户名称>"
```

**⚠️ 注意事项**：
- 已生成的 `tasks.md` 等文件不会被删除（需手动更新）
- 建议修改设计后，同步更新任务规划

**使用场景**：
- 设计方案审批后发现技术选型不合理
- 需求理解有误需要重新设计
- 新增了重要的技术难点需要补充

---

## 完成标志

✅ **全部通过后**：
- 自动显示工作流进度可视化
- 准备进入阶段 2

---

## 相关文档

- [阶段2: 任务规划](phase-2-tasks.md) - 下一阶段
- [Wiki生成规范](../project_doc_init.md)
