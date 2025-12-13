# 用户登录功能 - 完整工作流示例

> 本示例展示 spec-workflow skill 的完整 5 阶段工作流程

## 📂 文件清单

```
user-login-20241106001/
├── README.md                  # 本文件 - 示例说明
├── preparation.md             # 阶段0：前置准备文档
├── design.md                  # 阶段1：设计方案文档
├── tasks.md                   # 阶段2：任务规划文档
└── execution_summary.md       # 阶段3：计划执行总结文档
```

## 📋 示例说明

### 需求背景

**需求ID**: 20241106001  
**需求标题**: 用户登录功能实现  
**需求来源**: 用户文字描述（非TAPD链接）

**核心需求**:
- 实现基于用户名/密码的登录功能
- 支持JWT令牌认证
- 提供登录状态管理
- 增加登录安全防护（失败次数限制）

### 技术栈

- **后端**: tRPC-Go
- **数据库**: MySQL 8.0
- **缓存**: Redis
- **ORM**: GORM

### 工作流程展示

#### 阶段0: 前置准备 ✅

**文档**: `preparation.md`

**关键内容**:
- ✅ 需求信息完整获取
- ✅ Wiki文档验证通过（质量评分92/100）
- ✅ 项目架构理解（tRPC-Go分层架构）
- ✅ 潜在风险识别（数据库迁移、密钥管理等）

**验证命令**:
```bash
python3 scripts/validate_wiki.py doc/iwiki.md
```

---

#### 阶段1: 设计方案 ✅

**文档**: `design.md`

**关键内容**:
- ✅ 歧义清单（第三方登录、密码强度、验证码等）
- ✅ 技术方案（JWT密钥管理、账户锁定存储、密码加密算法）
- ✅ 边界条件确认（并发登录、令牌续期等）
- ✅ 改动分析（新增5个文件，修改3个文件）

**验证命令**:
```bash
python3 scripts/validate_design.py .specs/user-login-20241106001/design.md
```

---

#### 阶段2: 任务规划 ✅

**文档**: `tasks.md`

**关键内容**:
- ✅ 任务总数：18个
- ✅ 分组执行：5个分组
- ✅ 任务粒度：10-15分钟/任务
- ✅ 依赖关系：明确分组顺序

**分组明细**:
1. 分组1：基础设施准备（4个任务，45分钟）
2. 分组2：数据层实现（3个任务，40分钟）
3. 分组3：业务逻辑层（5个任务，50分钟）
4. 分组4：API层与中间件（3个任务，45分钟）
5. 分组5：测试与文档（3个任务，40分钟）

**验证命令**:
```bash
python3 scripts/validate_tasks.py .specs/user-login-20241106001/tasks.md
```

---

#### 阶段3: 计划执行 ✅

**文档**: `execution_summary.md`

**关键内容**:
- ✅ 任务完成率：100%（18/18）
- ✅ 代码变更：新增15个文件，修改3个文件
- ✅ 测试覆盖率：87.8%（≥80%）
- ✅ 质量检查：所有 CRITICAL 项通过

**质量检查方式**:
- 使用人工质量检查清单
- 所有 CRITICAL 级别检查项已通过

---

## 🎯 示例价值

### 1. 完整性展示

- ✅ 覆盖所有4个阶段（阶段0-3）
- ✅ 每个阶段都有完整的文档产物
- ✅ 符合所有验证脚本的要求

### 2. 真实场景

- ✅ 真实的技术栈（tRPC-Go + MySQL + Redis）
- ✅ 真实的业务需求（用户登录认证）
- ✅ 真实的技术决策（JWT、bcrypt、Redis锁定）

### 3. 最佳实践

- ✅ 歧义清单强制暴露问题
- ✅ 任务分组≤7个
- ✅ 单任务粒度10-15分钟
- ✅ 测试覆盖率≥80%

### 4. 学习参考

- ✅ 新用户可直接参考本示例
- ✅ 理解每个阶段的标准产物
- ✅ 学习如何填写各章节内容

---

## 📝 使用方法

### 1. 查看完整工作流

```bash
# 阅读顺序
cat preparation.md        # 阶段0
cat design.md             # 阶段1
cat tasks.md              # 阶段2
cat execution_summary.md  # 阶段3
```

### 2. 作为模板参考

```bash
# 复制示例作为起点
cp -r examples/user-login-20241106001 .specs/your-feature-{id}/

# 根据实际需求修改内容
vim .specs/your-feature-{id}/design.md
```

### 3. 验证文档质量

```bash
# 验证设计文档
python3 scripts/validate_design.py \
  examples/user-login-20241106001/design.md

# 验证任务规划
python3 scripts/validate_tasks.py \
  examples/user-login-20241106001/tasks.md
```

---

## ⚠️ 注意事项

### 1. 这是示例，非真实项目

- ❌ 不存在实际的代码实现
- ❌ 不存在真实的Wiki文档
- ✅ 所有内容仅供参考学习

### 2. 文档版本

- **创建时间**: 2024-11-06
- **Workflow版本**: 3.2.0
- **最后更新**: 2024-11-18（补充完整示例）

---

## 📚 相关文档

- [Skill主文档](../../SKILL.md)
- [设计方案指南](../../references/phases/phase-1-design.md)
- [任务规划指南](../../references/phases/phase-2-tasks.md)
- [执行指南](../../references/phases/phase-3-execution.md)

---

## 🤝 贡献

如果发现本示例有任何问题或改进建议，请：

1. 创建Issue说明问题
2. 提交PR修复
3. 确保符合最新的验证脚本要求

---

**示例维护者**: spec-workflow skill 团队  
**最后更新**: 2024-11-18
