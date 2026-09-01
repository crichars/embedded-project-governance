# 嵌入式项目开发模板

一个面向 AI 辅助嵌入式固件开发的轻量、可复用工作流。

## 它解决什么问题

AI 辅助嵌入式开发时，常见问题包括：

- 一个简单需求被扩展成过大的架构；
- AI 猜测芯片、板卡、引脚或 Flash 信息；
- 直接修改 IDE 生成文件；
- 把编译通过当成硬件功能完成；
- 忽略超时、边界、并发所有权和失败恢复；
- 任务结束后没有可复现的验证证据。

这个模板帮助 AI 在修改前调查项目，优先复用已有能力，根据风险选择流程深度，在获得授权后实施最小变更，并根据真实构建、主机和目标板结果完成收尾。

它不替代芯片规格、硬件判断、IDE 操作、烧录或目标板验证。

## 两种使用方式

同一个工作流支持简单模式和结构化任务模式（Structured Issue）。两种模式最后都遵循：

```text
调查 → 最小方案 → 明确授权 → 实现 → 实际验证 → 记录结果
```

### 简单模式：适合新手和快速开始

你只需要提供：

```text
项目路径：C:\work\firmware
目标或现象：我想增加串口接收，但当前配置不清楚。
请先调查，不要修改代码。
```

AI 会自行检查工程结构、构建方式、已有驱动、生成代码边界和可从资料确认的事实。你不需要预先知道所有约束；只有无法从项目发现、且会改变方案、风险或验收的问题才需要你确认。

### 结构化任务模式（Structured Issue）：适合复杂和高风险任务

```text
目标（Goal）：<可观察结果>
范围（Scope）：<文件、模块或边界>
当前问题（Problem）：<现象或原因>
参考（Reference）：<可复用的实现或文档>
限制（Constraints）：<不可修改项、资源、安全或兼容性限制>
验收（Acceptance）：<如何观察成功>
```

缺少的字段可以写为 `UNKNOWN`。结构化输入会减少探索范围，但不会跳过调查、风险判断和授权门禁。

当任务涉及公共接口、协议、持久化、并发、生成配置、Flash/NVM、启动或其他硬件风险时，建议使用这种模式。

## 什么时候使用

适合：

- 新项目接入和平台 bring-up；
- UART、SPI、I2C、CAN、Ethernet 等外设开发；
- Boot、Flash/NVM、OTA、看门狗和启动流程；
- DMA、ISR、RTOS 任务和共享缓冲区；
- 协议、公共接口和兼容性修改；
- 故障修复、异常恢复和目标硬件验收。

不适合：

- 纯粹的一次性脚本或与嵌入式无关的任务；
- 只需要简单文本编辑的工作；
- 期望 skill 自动替代硬件规格、烧录器或工程师判断的场景。

## 安装 skill

推荐直接让 Codex 安装 GitHub 仓库：

```text
请使用 $skill-installer 从 https://github.com/crichars/embedded-project-governance 安装这个 skill。
```

也可以在 PowerShell 中手动安装到用户级 skills 目录：

```powershell
git clone https://github.com/crichars/embedded-project-governance "$HOME\.agents\skills\embedded-project-governance"
```

Codex 会自动发现新安装的 skill；如果没有出现，重启 Codex。使用时可以输入 `$embedded-project-governance` 显式调用，也可以直接描述符合其适用范围的嵌入式开发任务。

安装 skill 后，在具体工程中运行初始化脚本，把项目规则复制到目标工程：

## 初始化项目

```powershell
cd "$HOME\.agents\skills\embedded-project-governance"
.\scripts\init-project.ps1 -ProjectPath C:\work\my-firmware
```

默认保留目标目录中的已有文件。只有确认覆盖范围后才使用 `-Force`。

初始化后，先让 AI 读取 `AGENTS.md` 和 `PROJECT.md`，再开始任务。项目事实可以逐步补充；未知内容使用 `UNKNOWN`，不要猜测。

## 文件结构

```text
embedded-project-governance/
├─ SKILL.md                  # skill 触发和通用工作流
├─ agents/openai.yaml        # skill 展示元数据
├─ project-template/
│  ├─ AGENTS.md              # 项目持续遵守的 AI 开发规则
│  ├─ PROJECT.md             # 项目事实、约束和未知项
│  ├─ .ai-governance/        # 能力和治理元数据
│  └─ docs/templates/
│     ├─ requirement.md      # 可观察需求和验收标准
│     ├─ design.md           # 最小且有依据的设计
│     ├─ task.md             # 当前变更范围和状态
│     └─ verification.md     # 可复现证据和剩余风险
├─ scripts/
│  └─ init-project.ps1       # 初始化模板文件
├─ README.md                 # 中文使用说明
└─ LICENSE                   # MIT 许可证
```
文档按风险启用：

- Low：任务输入和最小检查；
- Medium：必要的 requirement、design、task 或 verification；
- High：冻结需求、恢复方案、明确授权和目标证据。

不要求每个小改动填写全部文档。

## 边界和责任

AI 负责调查、整理事实、提出最小方案、实现批准范围并记录证据。

维护者负责提供产品意图、确认无法从项目发现的真实事实、批准有风险的变更，以及执行或见证 IDE 构建、烧录和目标板观察。

没有目标证据时，不能将代码或文档描述为硬件验收完成。这个模板通过规则和记录指导 AI，但不能机械阻止所有违规行为。
