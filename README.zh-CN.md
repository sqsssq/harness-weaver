# HarnessWeaver

[English](README.md) | 中文

HarnessWeaver 是一个可复用的 Codex harness engineering 模板，用于在新项目开始前建立 PRD-first、task-based 的 AI 辅助开发流程。

它帮助项目从一开始就具备：

- 稳定的 `AGENTS.md` Codex 入口；
- PRD-first 的产品规划方式；
- 小任务拆分和执行流程；
- handoff 前验证；
- commit 前人工 review；
- harness maturity stages；
- failure patterns 和 stage gates；
- 可替换的项目领域规则。

HarnessWeaver 不是应用框架。它不会替你选择前端、后端、数据库、部署方式或 AI provider。它提供的是一套可复用的“项目操作系统”，帮助人和 Codex 更稳地做这些决策。

## 适合谁？

HarnessWeaver 面向使用 Codex 等 AI coding agents 的开发者、研究者和构建者，适合想用 PRD、小任务、验证和人工 review 建立可重复项目 workflow 的人。

## 推荐使用场景

HarnessWeaver 适合：

- AI-assisted software prototypes；
- research software projects；
- education technology demos；
- product MVPs；
- 需要 PRD-first Codex workflow 的已有仓库。

不太适合：

- 一次性脚本；
- 不需要 PRD 或任务跟踪的小仓库；
- 已经有成熟工程流程的项目。

## 快速开始

```bash
cp config/init-project.example.env init-project.env
bash scripts/init-project.sh --config init-project.env --dry-run
bash scripts/init-project.sh --config init-project.env
bash scripts/verify.sh --instance
bash scripts/verify.sh --strict-instance
```

## 如何使用

1. 把这个模板复制到新项目中。
2. 替换 `{PROJECT_NAME}`、`{DOMAIN}`、`{PRIMARY_USER}` 等占位符。
3. 填写 `docs/domain/PROJECT_RULES.md`，定义项目专属规则。
4. 编写或更新 `docs/prd/`。
5. 在 `docs/tasks/` 下创建小任务。
6. 在模板状态下运行验证：

```bash
bash scripts/verify.sh --template
```

7. 用配置文件替换常见占位符：

```bash
cp config/init-project.example.env init-project.env
# 编辑 init-project.env，然后运行：
bash scripts/init-project.sh --config init-project.env --dry-run
bash scripts/init-project.sh --config init-project.env
```

也可以直接通过命令行传入核心字段：

```bash
bash scripts/init-project.sh \
  --project-name "My Project" \
  --domain "local productivity tool" \
  --primary-user "solo operators" \
  --mvp-focus "capture and review daily notes"
```

8. 运行实例验证：

```bash
bash scripts/verify.sh --instance
```

9. 继续手动编辑剩余 `TODO`，准备进入 task execution 前运行严格实例验证：

```bash
bash scripts/verify.sh --strict-instance
```

推荐编辑顺序见 `docs/harness/06-strict-readiness.md`。
如果项目会包含 UI 或体验设计，请在产品 UI 工作前填写 `docs/design.md`。

## 推荐先改哪些文件

- `AGENTS.md`
- `docs/domain/PROJECT_RULES.md`
- `docs/prd/00-product-brief.md`
- `docs/prd/01-mvp-scope.md`
- `docs/harness/stages/`
- `docs/design.md`
- `docs/harness/06-strict-readiness.md`

## Harness 阶段

HarnessWeaver 把 harness 分成 5 个阶段。项目不需要一开始完成所有阶段。

- Stage 0: Framework Harness。开发前即可完成，用来建立文档、流程、验证入口和项目边界。
- Stage 1: Fixture or Schema Harness。有结构化内容、数据或工作流 fixture 后触发。
- Stage 2: Logic Harness。有状态转移、路径、规则或可模拟逻辑后触发。
- Stage 3: Product UI Harness。有产品 UI 后触发。
- Stage 4: Continuous Harness。有项目工具链和 CI 后触发。

详细 gate 条件见：

- `docs/harness/stages/stage-0-framework.md`
- `docs/harness/stages/stage-1-fixture-schema.md`
- `docs/harness/stages/stage-2-logic.md`
- `docs/harness/stages/stage-3-product-ui.md`
- `docs/harness/stages/stage-4-continuous.md`

## 模板原则

把通用流程和项目专属规则分开：

- `AGENTS.md`：HarnessWeaver 仓库自身维护规则；
- `templates/base/AGENTS.md`：生成给目标项目的 `AGENTS.md` 模板；
- `docs/meta/`：通用 Codex workflow；
- `docs/harness/`：通用 harness engineering 结构；
- `docs/domain/`：项目专属 guardrails；
- `docs/design.md`：项目专属设计标准；
- `docs/prd/`：项目专属产品方向；
- `config/`：可复用初始化配置示例。

模板变更记录在 `CHANGELOG.md`。已有项目如果要吸收新版 HarnessWeaver 改进，可以参考 `docs/meta/UPGRADE_GUIDE.md`。

## 可选 Codex Skill

本仓库包含一个可选 Codex skill：`skills/harness-weaver/`，用于初始化基于 HarnessWeaver 的项目。这个 skill 属于本仓库配套能力，但新项目不必须复制它。

## 验证模式

HarnessWeaver 区分模板验证和实例验证：

- `bash scripts/verify.sh --template` 允许 `{PROJECT_NAME}` 这类占位符存在。
- `bash scripts/verify.sh --instance` 如果发现占位符残留就会失败。
- `bash scripts/verify.sh --strict-instance` 如果发现占位符或未解决的 TODO 标记残留就会失败。

所有模式都会检查必需文件、源项目专属词残留、脚本可执行权限和 Markdown 路径引用。

## 什么时候适合使用

适合在这些场景使用：

- 新项目开始前；
- 想让 Codex 按 PRD-first 和 task-based 方式工作；
- 想避免项目变成过度泛化的 app；
- 想让未来的验证、fixture、UI test、CI 有清晰演进路线；
- 想把一套 AI-assisted development workflow 复用到多个项目。
