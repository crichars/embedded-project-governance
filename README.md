# 嵌入式项目开发治理

面向 AI 辅助嵌入式固件开发的轻量治理 Skill，让 AI 先调查和复用，再按风险实施最小正确变更，并通过项目文档沉淀开发上下文。

## 为什么需要

AI 可以搜索工程、分析调用链和生成代码，但在真实嵌入式项目中，问题不只是“能不能写出代码”：

- 没有调查项目结构就开始修改；
- 已有驱动、接口或工具没有复用；
- 简单需求被扩展成不必要的抽象、任务或依赖；
- 生成代码与用户代码边界不清；
- 忽略 DMA、ISR、RTOS 任务之间的所有权；
- 没有确认 Flash/NVM 的范围、对齐、寿命和掉电恢复；
- 把编译通过或一次通信成功当成硬件验收。

这个 Skill 关注的是 AI 如何参与嵌入式项目，而不是替代 MCU SDK、HAL、IDE、烧录器或硬件测试工具。

## 核心能力

### 调查与复用

修改前先读取项目规则、事实基线、构建文件、相关代码和调用链，检查已有驱动、BSP、SDK、HAL、RTOS、工具和测试能力，优先使用项目已有入口。

### 风险与授权

根据任务影响选择轻量或完整流程。涉及公共接口、协议、持久化、启动、Flash/NVM、DMA 所有权、看门狗、安全、电源或执行器时，先确认范围、恢复方式、验证方法和实现授权。

### 最小正确变更

不增加没有证据支持的抽象、任务、队列、锁、依赖和文件；同时保留必要的边界检查、超时、错误处理、并发保护和恢复路径。

### 文档沉淀与接续

把项目事实、任务决策和验证结果保存到项目中，使后续 AI 或开发者能够恢复上下文、继续任务和复查证据。

## 工作方式

```text
调查
→ 复用与风险判断
→ 明确目标、范围、约束和验收
→ 提出最小方案
→ 获得授权
→ 实现与验证
→ 正确性审查和最小性审查
→ 沉淀结果
```

正确性审查检查必要的功能、边界、错误、并发、恢复和验证是否遗漏；最小性审查检查是否增加了重复能力、无关文件或不必要复杂度。

## 使用方式

### 简单模式

适合新手、陌生项目或信息不完整的任务：

```text
$embedded-project-governance

项目路径：C:\work\firmware
目标或现象：串口偶尔接收不到数据。
请先调查，不要修改代码。
```

AI 会先从项目和权威资料中查找可确认信息。无法自行确认、且会改变方案、风险或验收的问题，再由用户决定。

### 结构化任务模式

适合复杂或高风险任务：

```text
目标：<可观察结果>
范围：<文件、模块或边界>
当前问题：<现象或原因>
参考：<已有实现或文档>
限制：<不可修改项、资源、安全或兼容性限制>
验收：<如何观察成功>
```

不知道的内容可以写 `UNKNOWN`。结构化输入会减少探索范围，但不会跳过调查、风险判断和授权门禁。

### 从零项目

空目录也可以使用。先初始化治理文件，补充 `PROJECT.md` 中的已知事实和 `UNKNOWN` 项，再让 AI 建立第一个可验证切片。不要让 AI 在硬件信息不足时自行决定芯片配置、Flash 布局或完整架构。

## 项目文档

初始化后，项目中会包含：

- `AGENTS.md`：当前项目长期遵守的 AI 开发规则；
- `PROJECT.md`：硬件、工具链、构建方式、约束、验证环境和未知项；
- `.ai-governance/capability-map.md`：已存在并确认过的能力、入口、所有权和验证方式；
- `docs/templates/requirement.md`：需求、范围、约束和验收模板；
- `docs/templates/design.md`：设计、恢复、资源和回滚模板；
- `docs/templates/task.md`：当前任务、批准范围、风险和状态模板；
- `docs/templates/verification.md`：构建、主机、目标板验证和剩余风险模板。

这些文件不要求每次全部填写。按任务风险选择必要记录即可。它们的作用是让信息不只存在于一次聊天中，便于任务暂停后换 AI 或换开发者继续工作。

## 安装

### Codex

在 Codex 中输入：

```text
请使用 $skill-installer 从 https://github.com/crichars/embedded-project-governance 安装这个 skill。
```

安装后新开会话，使用 `$embedded-project-governance` 调用。

### Claude Code

将仓库克隆到 Claude Code 的个人 skills 目录：

```powershell
git clone https://github.com/crichars/embedded-project-governance $HOME\.claude\skills\embedded-project-governance
```

然后使用 `/embedded-project-governance` 调用。

## 初始化项目

安装后，让 AI 执行：

```text
请初始化 C:\work\my-firmware，不要覆盖已有文件。
```

也可以在 skill 目录中直接运行：

```powershell
.\scripts\init-project.ps1 -ProjectPath C:\work\my-firmware
```

脚本默认保留已有文件。只有明确确认覆盖范围后，才使用 `-Force`。脚本目前已在 Windows PowerShell 环境验证。

## 文件结构

```text
embedded-project-governance/
├─ SKILL.md
├─ agents/openai.yaml
├─ project-template/
│  ├─ AGENTS.md
│  ├─ PROJECT.md
│  ├─ .ai-governance/
│  │  └─ capability-map.md
│  └─ docs/templates/
│     ├─ requirement.md
│     ├─ design.md
│     ├─ task.md
│     └─ verification.md
├─ scripts/
│  └─ init-project.ps1
├─ README.md
└─ LICENSE
```

- `SKILL.md`：AI 使用的通用工作规则；
- `agents/openai.yaml`：Codex 界面显示信息；
- `project-template/`：复制到实际项目中的治理文件和模板；
- `scripts/init-project.ps1`：初始化治理文件，不分析硬件、不修改固件、不烧录。

## 状态与边界

任务状态按以下顺序区分：

```text
Planned → Implemented → Build Passed → Host Verified → HW Verified → Accepted
```

编译通过不等于目标板验证，没有目标证据不能称为 `HW Verified`，没有维护者接受剩余风险不能称为 `Accepted`。

本项目不替代：

- 芯片手册、勘误和工程师的硬件判断；
- IDE 构建、烧录、接线和目标板观察；
- Git、Pull Request、CI、代码审查和权限管理。

它提供的是工作流约束，不是强制安全沙箱。

## 当前验证

已完成 Codex 和 Claude Code 的基础安装与调用验证，也测试了 GitHub 全新克隆、空项目初始化、默认不覆盖、高风险 Flash/NVM 门禁和新 AI 读取项目文档恢复任务状态。

这些验证不代表所有 AI、工具链、项目和硬件场景都已经覆盖。

## 反馈与贡献

欢迎实际安装试用。使用过程中如果发现流程过重、规则不合理、复用判断不准确，或嵌入式项目中还有重要的通用风险没有覆盖，可以提交 Issue 和 PR。

觉得项目有参考价值的话，欢迎点个 Star。

感谢 Linux.do 社区支持。

## License

[MIT](LICENSE)
