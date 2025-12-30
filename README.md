# 图书馆智能助手 - DeepSeek 集成

基于 DeepSeek API 的实时 AI 写作助手，专为图书馆服务设计。

部署在 **Cloudflare Pages + Workers** 上，实现全球化无服务器性能。

## 🌟 功能特性

- 🤖 使用 DeepSeek Reasoner 模型的实时 AI 对话
- 💬 多对话管理
- 🌐 多语言支持（英文、中文、马来文）
- 📝 自动生成对话标题
- 🧠 显示 AI 思考过程
- ☁️ Cloudflare 无服务器部署
- 🌍 全球 CDN 分发

## 📦 前置要求

- DeepSeek API 密钥
- Cloudflare 账户（免费）
- GitHub 账户
- Wrangler CLI 工具

## 🚀 快速部署

### 1. 安装 Wrangler CLI

```powershell
npm install -g wrangler
```

### 2. 部署 Worker（后端 API）

```powershell
# 登录 Cloudflare
wrangler login

# 部署 Worker
wrangler deploy
```

您将获得一个 Worker URL，例如：
```
https://library-ai-assistant-worker.your-subdomain.workers.dev
```

### 3. 设置环境变量

1. 访问 [Cloudflare 控制台](https://dash.cloudflare.com/)
2. 进入 **Workers & Pages** → 您的 Worker → **Settings** → **Variables**
3. 添加变量：
   - 名称：`DEEPSEEK_API_KEY`
   - 值：您的 DeepSeek API 密钥
   - 勾选 **加密**

### 4. 更新前端 API 端点

编辑 `demo-Real AI.html`，找到这一行：

```javascript
const API_ENDPOINT = window.location.hostname === 'localhost' 
    ? 'http://localhost:3000/api/chat'
    : 'https://your-worker-name.your-subdomain.workers.dev/api/chat';
```

替换为步骤 2 中获得的实际 Worker URL。

### 5. 推送到 GitHub

```powershell
git init
git add .
git commit -m "Initial commit: Library AI Assistant"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/library-ai-assistant.git
git push -u origin main
```

### 6. 部署到 Cloudflare Pages

1. 访问 [Cloudflare 控制台](https://dash.cloudflare.com/)
2. 点击 **Workers & Pages** → **Create application** → **Pages**
3. 选择 **Connect to Git**
4. 选择您的 GitHub 仓库
5. 配置：
   - **Production branch**（生产分支）：`main`
   - **Build command**（构建命令）：*（留空）*
   - **Build output directory**（构建输出目录）：`/`
6. 点击 **Save and Deploy**（保存并部署）

### 7. 访问您的应用

您的应用将在以下地址上线：
```
https://your-project.pages.dev/demo-Real%20AI.html
```

🎉 **完成！** 您的 AI 助手现已全球上线！

## 📖 文档

- [完整部署指南](DEPLOYMENT.md) - 详细的分步说明

## 💡 使用方法

1. **创建新对话**：点击侧边栏的 "New Conversation" 按钮
2. **发送消息**：输入您的问题并按 Enter 键
3. **切换对话**：点击侧边栏中的任何对话
4. **更改语言**：点击右上角的齿轮图标 (⚙️) 切换语言
5. **清除上下文**：点击橡皮擦图标 (🧹) 清除当前对话

## 🔄 更新工作流

### 更新前端（HTML）
```powershell
git add demo-Real\ AI.html
git commit -m "Update frontend"
git push
```
Cloudflare Pages 会在推送后自动部署。

### 更新后端（Worker）
```powershell
wrangler deploy
```

## 💰 费用

- **Cloudflare Pages**：免费（每月 500 次构建）
- **Cloudflare Workers**：免费（每天 100,000 次请求）
- **DeepSeek API**：按使用量付费

非常适合个人项目和原型开发！

## 🛠️ 技术栈

| 层级 | 技术 |
|-------|-----------|
| 前端 | Vue 3, Tailwind CSS |
| 后端 | Cloudflare Workers |
| 托管 | Cloudflare Pages |
| AI 引擎 | DeepSeek API (Reasoner 模型) |
| 部署工具 | Wrangler CLI |

## 🐛 故障排除

**CORS 错误**：检查 `worker.js` 中的 Worker CORS 设置

**401/403 错误**：在 Cloudflare 控制台中验证 `DEEPSEEK_API_KEY`

**Worker 无响应**：部署后等待 1-2 分钟

**Pages 404 错误**：使用包含文件名的完整 URL，或将文件重命名为 `index.html`

## 📝 许可证

MIT

## 🔗 链接

- [DeepSeek API 文档](https://api-docs.deepseek.com/)
- [Cloudflare Workers 文档](https://developers.cloudflare.com/workers/)
- [Cloudflare Pages 文档](https://developers.cloudflare.com/pages/)
