# 🚀 GitHub + Cloudflare 部署指南

## 方案架构

```
用户浏览器
    ↓
Cloudflare Pages (静态网站 - demo-real ai.html)
    ↓
Cloudflare Workers (API 后端 - worker.js)
    ↓
DeepSeek API
```

---

## 📋 步骤 1: 准备 GitHub 仓库

### 1.1 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 创建新仓库，例如：`library-ai-assistant`
3. 选择 Public 或 Private

### 1.2 准备项目文件

确保您的项目包含以下文件：
```
library-ai-assistant/
├── demo-real ai.html    # 前端页面
├── worker.js            # Cloudflare Worker 代码
├── wrangler.toml        # Worker 配置文件
├── .gitignore           # Git 忽略文件
└── README.md            # 项目说明
```

### 1.3 创建 .gitignore 文件

```gitignore
node_modules/
.env
.wrangler/
dist/
*.log
```

### 1.4 推送到 GitHub

```powershell
# 在项目目录下执行
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/library-ai-assistant.git
git push -u origin main
```

---

## 🔧 步骤 2: 部署 Cloudflare Worker (后端 API)

### 2.1 安装 Wrangler CLI

```powershell
npm install -g wrangler
```

### 2.2 登录 Cloudflare

```powershell
wrangler login
```

这会打开浏览器让您授权。

### 2.3 部署 Worker

```powershell
wrangler deploy
```

部署成功后，您会得到一个 Worker URL，例如：
```
https://library-ai-assistant-worker.your-subdomain.workers.dev
```

### 2.4 设置环境变量（重要！）

1. 访问 Cloudflare Dashboard: https://dash.cloudflare.com/
2. 进入 **Workers & Pages** → 找到您的 Worker
3. 点击 **Settings** → **Variables**
4. 添加环境变量：
   - Name: `DEEPSEEK_API_KEY`
   - Value: `您的 API Key`
   - 选择 **Encrypt** (加密)
5. 点击 **Save**

---

## 🌐 步骤 3: 部署 Cloudflare Pages (前端)

### 3.1 修改 HTML 文件中的 API 端点

打开 `demo-real ai.html`，找到这一行：

```javascript
const API_ENDPOINT = window.location.hostname === 'localhost' 
    ? 'http://localhost:3000/api/chat'
    : 'https://your-worker-name.your-subdomain.workers.dev/api/chat';
```

将 `https://your-worker-name.your-subdomain.workers.dev/api/chat` 替换为您在步骤 2.3 获得的 Worker URL + `/api/chat`，例如：

```javascript
const API_ENDPOINT = window.location.hostname === 'localhost' 
    ? 'http://localhost:3000/api/chat'
    : 'https://library-ai-assistant-worker.your-subdomain.workers.dev/api/chat';
```

### 3.2 提交并推送更改

```powershell
git add demo-real\ ai.html
git commit -m "Update API endpoint for production"
git push
```

### 3.3 连接 GitHub 到 Cloudflare Pages

1. 访问 Cloudflare Dashboard: https://dash.cloudflare.com/
2. 点击 **Workers & Pages** → **Create application** → **Pages**
3. 选择 **Connect to Git**
4. 授权 GitHub 并选择您的仓库 `library-ai-assistant`
5. 配置构建设置：
   - **Production branch**: `main`
   - **Build command**: 留空（因为是纯静态）
   - **Build output directory**: `/` （根目录）
6. 点击 **Save and Deploy**

### 3.4 等待部署完成

部署完成后，您会获得一个 URL，例如：
```
https://library-ai-assistant.pages.dev
```

---

## ✅ 步骤 4: 访问您的应用

打开浏览器访问：
```
https://library-ai-assistant.pages.dev/demo-real%20ai.html
```

🎉 恭喜！您的 AI 助手已经上线了！

---

## 🔄 后续更新流程

每次修改代码后：

### 更新前端（HTML）:
```powershell
git add .
git commit -m "Update frontend"
git push
```
Cloudflare Pages 会自动重新部署。

### 更新后端（Worker）:
```powershell
wrangler deploy
```

---

## 💡 高级配置（可选）

### 1. 自定义域名

在 Cloudflare Pages 设置中可以添加自己的域名。

### 2. 环境变量管理

对于不同环境，可以在 `wrangler.toml` 中配置：

```toml
[env.production]
vars = { ENVIRONMENT = "production" }

[env.development]
vars = { ENVIRONMENT = "development" }
```

### 3. 本地测试 Worker

```powershell
wrangler dev
```

---

## 🐛 常见问题

**Q1: CORS 错误**
- 确保 Worker 中的 CORS 头设置正确
- 检查 API_ENDPOINT 是否正确

**Q2: API Key 无效**
- 在 Cloudflare Dashboard 中重新检查环境变量
- 确保变量名是 `DEEPSEEK_API_KEY`

**Q3: 页面 404**
- 确保访问的 URL 包含文件名：`/demo-real%20ai.html`
- 或者将文件重命名为 `index.html`

**Q4: Worker 部署失败**
- 检查 `wrangler.toml` 配置
- 确保已登录：`wrangler whoami`

---

## 📊 成本估算

- **Cloudflare Pages**: 免费（每月 500 次构建）
- **Cloudflare Workers**: 免费套餐每天 100,000 次请求
- **DeepSeek API**: 按使用量计费

对于个人项目，完全可以使用免费套餐！

---

## 🔗 相关链接

- [Cloudflare Pages 文档](https://developers.cloudflare.com/pages/)
- [Cloudflare Workers 文档](https://developers.cloudflare.com/workers/)
- [Wrangler CLI 文档](https://developers.cloudflare.com/workers/wrangler/)
- [DeepSeek API 文档](https://api-docs.deepseek.com/)
