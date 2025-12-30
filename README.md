# LibAI - 图书馆智能助手

基于 DeepSeek API 的智能图书馆助手，提供学术咨询、文献推荐和 AI 对话服务。

部署在 **Cloudflare Pages + Workers** 上，实现全球化无服务器性能。

## 🌟 功能特性

- 🤖 **DeepSeek AI 驱动** - 使用 DeepSeek R1 模型，提供专业的学术咨询
- 📚 **自动参考文献** - 每次回答自动生成 3-5 个学术参考文献
- 📝 **Markdown 渲染** - 优雅的格式化显示，支持标题、列表、代码等
- 💬 **多对话管理** - 支持多个独立对话，自动保存历史
- ⏰ **智能时间戳** - 动态显示对话创建时间（今天/昨天/日期）
- 🌐 **多语言支持** - 支持中文、英文、马来文三种语言
- 🧠 **思考过程可视化** - 实时显示 AI 推理过程
- ☁️ **无服务器架构** - 基于 Cloudflare 全球 CDN，快速稳定

## 📦 技术栈

```
架构：
用户浏览器 → Cloudflare Pages (前端) → Cloudflare Workers (API) → DeepSeek API
```

| 层级 | 技术 |
|-------|-----------|
| 前端 | Vue 3 + Tailwind CSS + Marked.js |
| 后端 | Cloudflare Workers |
| 托管 | Cloudflare Pages |
| AI 引擎 | DeepSeek R1 |
| 部署 | Wrangler CLI |

## 🚀 快速部署指南

### 前置要求

- ✅ DeepSeek API 密钥 ([获取地址](https://api-docs.deepseek.com/))
- ✅ Cloudflare 账户（[免费注册](https://dash.cloudflare.com/sign-up)）
- ✅ GitHub 账户
- ✅ Node.js 环境

### 步骤 1: 克隆或准备项目

```powershell
# 克隆项目（如果从 GitHub）
git clone https://github.com/YOUR_USERNAME/libai.git
cd libai

# 或者初始化新项目
git init
```

项目结构：
```
libai/
├── LibAI.html          # 前端页面
├── worker.js           # Cloudflare Worker 代码
├── wrangler.toml       # Worker 配置
├── package.json        # 项目配置
└── README.md           # 本文件
```

### 步骤 2: 部署 Worker (后端 API)

```powershell
# 安装 Wrangler CLI
npm install -g wrangler

# 登录 Cloudflare（会打开浏览器授权）
wrangler login

# 部署 Worker
wrangler deploy
```

部署成功后，记录 Worker URL（例如）：
```
https://libai-worker.your-subdomain.workers.dev
```

### 步骤 3: 配置环境变量

1. 访问 [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. 进入 **Workers & Pages** → 找到 `libai-worker`
3. 点击 **Settings** → **Variables**
4. 添加环境变量：
   - **Name**: `DEEPSEEK_API_KEY`
   - **Value**: `sk-your-api-key-here`
   - ✅ 勾选 **Encrypt** (加密)
5. 点击 **Save**

### 步骤 4: 更新前端 API 端点

编辑 `LibAI.html`，找到第 373 行附近：

```javascript
const API_ENDPOINT = window.location.hostname === 'localhost' 
    ? 'http://localhost:3000/api/chat'
    : 'https://libai-worker.你的子域名.workers.dev/api/chat';
```

将 `你的子域名` 替换为步骤 2 中获得的实际子域名。

### 步骤 5: 推送到 GitHub

```powershell
git add .
git commit -m "Initial commit: LibAI"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/libai.git
git push -u origin main
```

### 步骤 6: 部署到 Cloudflare Pages

1. 访问 [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. 点击 **Workers & Pages** → **Create application** → **Pages**
3. 选择 **Connect to Git**
4. 授权 GitHub 并选择仓库 `libai`
5. 配置构建设置：
   - **Production branch**: `main`
   - **Build command**: 留空
   - **Build output directory**: `/`
6. 点击 **Save and Deploy**

### 步骤 7: 访问应用

部署完成后，访问：
```
https://libai.pages.dev/LibAI.html
```

🎉 **部署完成！** 您的智能图书馆助手已上线！

## 💡 使用指南

### 基本操作

1. **开始对话** - 在底部输入框输入问题，按 Enter 发送
2. **新建对话** - 点击侧边栏 "New Conversation" 按钮
3. **切换对话** - 点击侧边栏中的任何历史对话
4. **清除上下文** - 点击顶部橡皮擦图标 🧹
5. **切换语言** - 点击设置图标 ⚙️ 选择语言

### 特色功能

- **自动参考文献**: 每次回答后自动在底部显示 3-5 个学术参考文献
- **Markdown 格式**: 支持标题、列表、代码块等丰富格式
- **思考过程**: 查看 AI 的推理步骤（DeepSeek R1 特性）
- **时间戳**: 智能显示对话创建时间（今天/昨天/具体日期）

## 🔄 更新与维护

### 更新前端

```powershell
# 修改 LibAI.html 后
git add LibAI.html
git commit -m "Update frontend features"
git push
```
Cloudflare Pages 会自动重新部署（约 1-2 分钟）。

### 更新后端

```powershell
# 修改 worker.js 后
wrangler deploy
```

### 本地测试

```powershell
# 测试 Worker
wrangler dev

# 本地开启 HTTP 服务器测试前端
npx http-server -p 3000
```

## 💰 成本估算

| 服务 | 免费额度 | 说明 |
|------|---------|------|
| **Cloudflare Pages** | 500 次构建/月 | 足够个人使用 |
| **Cloudflare Workers** | 100,000 请求/天 | 非常慷慨 |
| **DeepSeek API** | 按使用量计费 | 价格低廉 |

💡 **个人项目完全免费！**

## 🐛 常见问题

### Q1: CORS 错误
- ✅ 检查 `worker.js` 中的 CORS 头配置
- ✅ 确认 `API_ENDPOINT` 地址正确

### Q2: API Key 无效 (401/403)
- ✅ 在 Cloudflare Dashboard 检查环境变量
- ✅ 确保变量名是 `DEEPSEEK_API_KEY`
- ✅ 重新部署 Worker

### Q3: 没有参考文献显示
- ✅ 检查浏览器控制台（F12）是否有警告
- ✅ AI 回答中应包含 "References:" 或 "参考文献:" 部分

### Q4: Markdown 格式不显示
- ✅ 确认 `marked.js` CDN 已加载
- ✅ 检查浏览器控制台是否有错误

### Q5: 页面 404
- ✅ 确保 URL 包含 `LibAI.html`
- ✅ 或将文件重命名为 `index.html`

### Q6: Worker 部署失败
- ✅ 运行 `wrangler whoami` 检查登录状态
- ✅ 检查 `wrangler.toml` 配置

## 📚 高级配置

### 自定义域名

在 Cloudflare Pages 设置中可以绑定自己的域名：
```
Settings → Custom domains → Add domain
```

### 环境变量管理

在 `wrangler.toml` 中配置不同环境：

```toml
[env.production]
vars = { ENVIRONMENT = "production" }

[env.development]
vars = { ENVIRONMENT = "development" }
```

### 性能优化

- 启用 Cloudflare CDN 缓存
- 使用 Cloudflare Analytics 监控流量
- 配置 Page Rules 优化加载速度

## 📝 开发者说明

### 项目特点

1. **响应式设计** - 支持桌面和移动设备
2. **多语言架构** - 易于扩展新语言
3. **模块化代码** - Vue 3 Composition API
4. **安全性** - XSS 防护，API Key 加密
5. **可扩展性** - 易于添加新功能

### 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🔗 相关链接

- [DeepSeek API 文档](https://api-docs.deepseek.com/)
- [Cloudflare Workers 文档](https://developers.cloudflare.com/workers/)
- [Cloudflare Pages 文档](https://developers.cloudflare.com/pages/)
- [Vue 3 文档](https://vuejs.org/)
- [Marked.js 文档](https://marked.js.org/)

---

**Made with ❤️ for Academic Libraries**
