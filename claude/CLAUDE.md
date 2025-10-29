## 语言要求
- Always respond in 中文
- 所有回复、文档、代码注释都使用简体中文
- 技术术语可保留英文，但需要中文解释

## 代码质量
- 代码简洁易读，变量函数命名见名知意
- 遵循项目现有代码风格，最小化改动
- 使用统一的代码格式化工具和命名规范
- 复杂业务逻辑添加中文注释，解释"为什么"
- 外部调用必须有错误处理，使用统一错误码格式
- 函数单一职责，长度不超过 80 行
- 不改变语义的前提下，行末不要有有空白字符

## 编程哲学
- Beautiful is better than ugly.
- Explicit is better than implicit.
- Simple is better than complex.
- Complex is better than complicated.
- Flat is better than nested.
- Sparse is better than dense.
- Readability counts.
- Special cases aren't special enough to break the rules.
- Although practicality beats purity.
- Errors should never pass silently.
- Unless explicitly silenced.
- In the face of ambiguity, refuse the temptation to guess.
- There should be one-- and preferably only one --obvious way to do it.
- Although that way may not be obvious at first unless you're Dutch.
- Now is better than never.
- Although never is often better than *right* now.
- If the implementation is hard to explain, it's a bad idea.
- If the implementation is easy to explain, it may be a good idea.

## 协作原则
- 开始工作前必须完全理解需求，有疑问主动澄清
- 方案需包含：实现思路、依赖拆解、文件结构、测试要点、mermaid 图
- 主动思考需求边界
- 严格按步骤执行，不跨步骤或"顺便"完成其他任务
- 每步完成后汇报进度，等待确认
- 遵守最小改动原则，参考现有业务实现风格
- 遇到争议或不确定性主动询问，不自行决定

## 开发流程
- 新功能必须写单元测试，关键逻辑覆盖率 ≥80%
- 数据库查询考虑索引优化，避免 N+1 查询
- 每步骤完成后汇报，等待确认后进入下一步

## 安全性能
- 敏感信息不硬编码，使用配置管理
- 用户输入严格校验，防止注入攻击
- 实施最小权限和基于角色的访问控制
- 敏感操作记录审计日志，API 接口限流防重放
- 合理使用缓存，设置过期时间，使用连接池
- 接口响应时间超过 500ms 要优化
- 异步处理耗时操作，事务尽可能短
- 考虑并发安全，设计接口幂等性

## 监控运维
- 日志级别：DEBUG/INFO/WARN/ERROR，包含 traceId、requestId
- 监控响应时间、错误率
- 统一响应格式，接口版本管理

## 问题处理
- 系统分析问题：复现步骤、错误日志、影响范围、根本原因
- 修复 Bug 先写测试用例重现问题
- 超过 2 次修复失败时主动添加关键日志，修复后主动清除日志
- 建立故障复盘机制，输出改进措施
