# Spec Workflow 示例项目

本目录包含完整的示例项目，用于展示 Spec Workflow 工作流程的最佳实践。

## ⚠️ 重要说明：路径差异

**示例文件路径**: `examples/{name}-{id}/`  
**实际使用路径**: `.specs/{name}-{id}/`

> **注意**: 示例项目放在 `examples/` 目录是为了便于查看和学习，实际使用时应按照规范将文件放在 `.specs/` 目录下。验证脚本会对此给出警告提示（"建议将文件放在 .specs/ 目录下"），这是正常的，无需修复。

## 📁 目录结构

```
examples/
└── user-login-20241106001/          # 用户登录功能示例
    ├── design.md                     # 技术设计文档（阶段1）
    ├── tasks.md                      # 任务规划文档（阶段2）
    └── IMPLEMENTATION.md             # 实现代码示例（可选）
```

## 🎯 示例项目说明

### user-login-20241106001

**功能描述**：用户登录功能实现，包括用户名/密码验证、JWT令牌认证、登录安全防护等。

**技术栈**：tRPC-Go + MySQL + Redis + bcrypt

**用途**：
- ✅ 新团队成员学习参考
- ✅ 校验脚本的标准测试用例
- ✅ 工作流程的完整示例
- ✅ 模板使用的最佳实践

**包含内容**：
1. **design.md** - 完整的技术设计文档
   - 需求说明、项目现状分析
   - 歧义与待确认清单（已确认）
   - 架构设计、改动分析
   - 接口与数据模型设计
   - 技术难点与对策
   - 测试策略、风险应急预案

2. **tasks.md** - 详细的任务规划
   - 17个任务，分5个分组
   - 每个任务10-15分钟
   - 完整的依赖关系图
   - 详细的验收清单

3. **IMPLEMENTATION.md**（可选）- 实现代码示例
   - 展示关键代码片段
   - 单元测试示例
   - 帮助理解设计到代码的转化

## 🔍 如何使用示例

### 作为学习参考

1. **阅读设计文档**：
   ```bash
   cat examples/user-login-20241106001/design.md
   ```
   学习如何编写规范的技术设计文档。

2. **查看任务规划**：
   ```bash
   cat examples/user-login-20241106001/tasks.md
   ```
   了解如何将设计方案拆解为可执行的任务。

3. **运行校验脚本**：
   ```bash
   # 验证设计文档
   python scripts/validate_design.py examples/user-login-20241106001/design.md
   
   # 验证任务规划
   python scripts/validate_tasks.py examples/user-login-20241106001/tasks.md
   ```

### 作为模板参考

**复制示例创建新需求**：
```bash
# 复制示例项目
cp -r examples/user-login-20241106001 .specs/my-feature-20241107001

# 修改为你的需求内容
# 编辑 .specs/my-feature-20241107001/design.md
# 编辑 .specs/my-feature-20241107001/tasks.md
```

## ✅ 验证结果

### design.md 验证通过

```
✓ 检查文件路径规范
✓ 检查文档头信息
✓ 检查必需章节
✓ 检查 mermaid 流程图
✓ 检查歧义与待确认清单
✓ 检查依赖服务调用

✅ 验证通过（有 3 个警告）
```

### tasks.md 验证通过

```
✓ 检查文件路径规范
✓ 检查文档头信息
✓ 检查任务分组
✓ 检查任务完整性 (找到 17 个任务)
✓ 检查分组依赖关系图
✓ 检查验收清单

✅ 验证通过（有 4 个警告）
```

**说明**：警告仅为建议，不影响使用。主要是因为示例项目位于 `examples/` 目录，而非 `.specs/` 目录。

## 📚 相关文档

- **工作流程**：`references/scripts-reference.md`（脚本命令参考）
- **设计模板**：`assets/templates/design.md.template`
- **任务模板**：`assets/templates/tasks.md.template`
- **校验脚本**：
  - `scripts/validate_design.py`
  - `scripts/validate_tasks.py`

## 🆕 添加新示例

如果你想贡献新的示例项目：

1. **选择典型场景**：
   - 涉及外部依赖服务调用
   - 多模块复杂改动
   - 数据迁移场景
   - 前后端联调场景

2. **创建完整文档**：
   ```bash
   mkdir examples/feature-name-YYYYMMDDXXX
   # 基于最新模板创建 design.md 和 tasks.md
   ```

3. **通过校验测试**：
   ```bash
   python scripts/validate_design.py examples/feature-name-YYYYMMDDXXX/design.md
   python scripts/validate_tasks.py examples/feature-name-YYYYMMDDXXX/tasks.md
   ```

4. **更新本 README**：
   - 在"示例项目说明"中添加新示例
   - 说明适用场景和特点

## 📝 版本记录

| 日期 | 版本 | 修改内容 | 修改人 |
|------|------|---------|--------|
| 2024-11-07 | 1.0 | 创建示例说明文档 | 开发团队 |
| 2024-11-07 | 1.1 | 更新user-login示例至最新模板 | 开发团队 |
