# 嵌入式项目开发治理

一个让 AI 以最小、受控、可验证方式参与嵌入式固件开发的 Agent Skill。

## 功能

- 调查项目结构、构建方式和已有能力；
- 支持简单模式与结构化任务模式；
- 根据风险选择必要的工作流程；
- 标记无法从项目确认的事实为 `UNKNOWN`；
- 识别生成代码边界并优先复用已有驱动、BSP、SDK、HAL 和 RTOS 能力；
- 在明确授权后实施最小变更；
- 记录构建、主机、目标硬件验证证据和剩余风险；
- 提供项目治理文件模板和初始化脚本。

## 适用场景

- 新项目接入和平台 bring-up；
- UART、SPI、I2C、CAN、Ethernet 等外设开发；
- Boot、Flash/NVM、OTA 和看门狗；
- DMA、ISR、RTOS 任务和共享缓冲区；
- 协议、公共接口和兼容性修改；
- 故障修复、异常恢复和目标硬件验收。

它不替代芯片规格、硬件判断、IDE 构建、烧录或目标板测试。

## 工作流程

```text
调查 → 最小方案 → 明确授权 → 实现 → 实际验证 → 记录结果
```

## 使用方式

### 简单模式

适合新手和快速开始，只需提供项目路径、目标或现象：

```text
$embedded-project-governance
项目路径：C:\\work\\firmware
目标或现象：我想增加串口接收，但当前配置不清楚。
请先调查，不要修改代码。
```

AI 会先检查工程结构、构建方式、已有驱动和可确认事实。只有无法从项目发现、且会改变设计、风险或验收的问题才需要你确认。

### 结构化任务模式

适合复杂或高风险任务：

```text
目标：<可观察结果>
范围：<文件、模块或边界>
当前问题：<现象或原因>
参考：<已有实现或文档>
限制：<不可修改项、资源或兼容性限制>
验收：<如何观察成功>
```

不知道的内容写 `UNKNOWN`。结构化输入会减少探索范围，但不会跳过调查、风险判断和授权门禁。Claude Code 使用时，将第一行替换为 `/embedded-project-governance`。

## 文件结构

```text
embedded-project-governance/
├─ SKILL.md
├─ agents/openai.yaml
├─ project-template/
│  ├─ AGENTS.md
│  ├─ PROJECT.md
│  ├─ .ai-governance/capability-map.md
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

| 文件 | 作用 |
|---|---|
| `SKILL.md` | AI skill 入口和通用工作流 |
| `agents/openai.yaml` | Codex 的显示名称和默认提示 |
| `project-template/AGENTS.md` | 复制到项目后持续生效的 AI 开发规则 |
| `project-template/PROJECT.md` | 项目事实、约束和未知信息 |
| `capability-map.md` | 已有能力和可复用组件记录 |
| `docs/templates/` | 需求、设计、任务和验证模板 |
| `init-project.ps1` | 将治理模板初始化到具体工程 |

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
git clone https://github.com/crichars/embedded-project-governance "$HOME\\.claude\\skills\\embedded-project-governance"
```

然后使用 `/embedded-project-governance` 调用。

## 初始化项目

安装后，让 AI 执行：

```text
请初始化 C:\\work\\my-firmware，不要覆盖已有文件。
```

初始化脚本默认保留已有文件。只有明确确认覆盖范围后才允许使用 `-Force`。脚本目前已在 Windows PowerShell 环境验证。

## 边界

- 不替代芯片手册、硬件判断或工程师决策；
- 不自动完成 IDE 操作、烧录和目标板观察；
- 没有目标证据时，不把编译通过称为硬件验收完成；
- skill 提供工作流约束，不是强制安全沙箱。

## License

[MIT](LICENSE)