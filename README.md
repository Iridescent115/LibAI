# LibAI - 图书馆智能信息检索系统

基于 DeepSeek API 的智能图书馆信息检索与资源推荐系统，集成真实 MySQL 数据库，提供专业的学术资源检索服务。

部署在 **Cloudflare Pages + Workers** 上，结合本地数据库实现全栈信息检索解决方案。

## 🌟 核心功能

- 🤖 **AI 智能检索** - 使用 DeepSeek R1 模型，理解用户查询意图并推荐相关书籍
- 📚 **真实数据库集成** - 连接 MySQL 数据库，查询真实馆藏信息
- 📊 **元数据标准化** - 严格遵循图书馆元数据标准（13个字段）
- 🎯 **智能推荐引擎** - AI 分析用户需求，从数据库中匹配最相关的书籍
- 📝 **可视化结果** - 以表格形式展示书籍详细信息（书名、作者、位置等）
- 💬 **对话式交互** - 自然语言查询，支持多轮对话和上下文理解
- 🌐 **多语言支持** - 支持中文、英文、马来文三种语言
- 🧠 **思考过程可视化** - 实时显示 AI 检索推理过程
- ☁️ **混合架构** - 云端前端 + 本地数据库，兼顾性能和数据安全

## 📦 系统架构

```
┌─────────────────┐
│   用户浏览器    │
└────────┬────────┘
         │
         ↓
┌─────────────────────────────────┐
│   Cloudflare Pages (前端)       │
│   - LibAI.html                  │
│   - Vue 3 + Tailwind CSS        │
└────────┬───────────────┬────────┘
         │               │
         ↓               ↓
┌────────────────┐  ┌──────────────────┐
│ Cloudflare     │  │  本地数据库 API   │
│ Workers        │  │  (db-server.js)  │
│                │  │                  │
│ DeepSeek API   │  │  MySQL 数据库    │
│ (AI 推理)      │  │  (书籍元数据)    │
└────────────────┘  └──────────────────┘
```

### 架构说明

| 组件 | 技术栈 | 部署位置 | 功能 |
|------|--------|----------|------|
| 前端界面 | Vue 3 + Tailwind CSS + Marked.js | Cloudflare Pages | 用户交互、结果展示 |
| AI 服务 | Cloudflare Workers | Cloudflare 边缘网络 | API 代理、AI 推理 |
| 数据库 API | Node.js + Express + MySQL2 | 本地服务器 | 数据查询接口 |
| 数据存储 | MySQL 8.0 | 本地服务器 | 书籍元数据存储 |

## 🗄️ 数据库元数据标准

系统严格遵循图书馆元数据标准，包含以下13个字段:

| 字段 | 说明 | 示例 |
|------|------|------|
| ID | 书籍唯一标识 | 1 |
| Title | 书名 | Introduction to Algorithms |
| Author | 作者 | Thomas H. Cormen, et al. |
| Language | 语言 | English |
| Publisher | 出版社 | MIT Press |
| Publication time | 出版时间 | 2009 |
| Subjects | 主题分类 | Computer Science; Algorithms |
| Document type | 文献类型 | Book |
| Physical description | 物理描述 | 1312 pages; 24 cm |
| Classification | 分类号 | TP312.1 |
| Status | 状态 | Available / Checked Out |
| Location | 馆藏位置 | 3rd Floor, Zone A, Shelf 15 |
| Call number | 索书号 | TP312.1/C82 |

## 🚀 完整部署指南

### 部署方案说明

LibAI 采用混合部署架构:
- ✅ **前端 + AI**: 部署在 Cloudflare (全球可访问)
- ✅ **数据库**: 部署在本地服务器 (需要网络访问权限)

**重要提示**: 
- 如果您想在多台电脑上使用数据库功能,需要在每台电脑上部署数据库
- 或者将数据库部署在一台服务器上,其他电脑通过网络访问

---

## 📍 部署步骤

### 阶段一: Cloudflare 部署 (前端 + AI)

#### 前置要求

- ✅ DeepSeek API 密钥 ([获取地址](https://platform.deepseek.com/))
- ✅ Cloudflare 账户 ([免费注册](https://dash.cloudflare.com/sign-up))
- ✅ Node.js 环境 (v16+)
- ✅ Git

#### 步骤 1: 准备项目

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

### 步骤 5: 部署前端到 Cloudflare Pages

1. 访问 [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. 点击 **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**
3. 授权 GitHub 仓库
4. 选择 `libai` 仓库
5. 配置构建设置:
   - **Build command**: (留空)
   - **Build output directory**: `/`
6. 点击 **Save and Deploy**

部署成功后,记录 Pages URL:
```
https://libai.pages.dev
```

---

### 阶段二: 本地数据库部署

#### 前置要求

- ✅ MySQL 8.0+ 或 MariaDB 10.5+
- ✅ Node.js 环境 (v16+)
- ✅ 数据库管理工具 (推荐 Navicat Premium)

#### 步骤 1: 安装 MySQL 数据库

**Windows 系统:**

1. 下载 [MySQL Installer](https://dev.mysql.com/downloads/installer/)
2. 运行安装程序,选择 **"Full"** 安装类型
3. 配置设置:
   - **Port**: 3306 (默认)
   - **Authentication**: Use Strong Password Encryption
   - **Root Password**: 设置一个强密码 (记住这个密码!)
4. 完成安装

**macOS 系统:**

```bash
# 使用 Homebrew 安装
brew install mysql

# 启动 MySQL 服务
brew services start mysql

# 安全配置
mysql_secure_installation
```

**Linux 系统 (Ubuntu/Debian):**

```bash
# 安装 MySQL
sudo apt update
sudo apt install mysql-server

# 启动服务
sudo systemctl start mysql
sudo systemctl enable mysql

# 安全配置
sudo mysql_secure_installation
```

#### 步骤 2: 创建数据库

**使用 Navicat (推荐):**

1. 打开 Navicat Premium
2. 点击 **连接** → **MySQL**
3. 配置连接:
   - **连接名**: LibAI
   - **主机**: localhost
   - **端口**: 3306
   - **用户名**: root
   - **密码**: (您设置的密码)
4. 点击 **测试连接** → **确定**
5. 右键连接名 → **新建数据库**
   - **数据库名**: libai_db
   - **字符集**: utf8mb4
   - **排序规则**: utf8mb4_general_ci

**使用命令行:**

```bash
# 登录 MySQL
mysql -u root -p

# 创建数据库
CREATE DATABASE libai_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 退出
exit;
```

#### 步骤 3: 创建表结构

1. 打开 Navicat,连接到 `libai_db` 数据库
2. 点击 **查询** → **新建查询**
3. 复制 `library-metadata-format.sql` 文件内容
4. 粘贴到查询窗口
5. 点击 **运行** (或按 Ctrl+R)
6. 看到 "Books table created successfully" 表示成功

#### 步骤 4: 导入数据

**导入示例数据 (测试用):**

1. 在 Navicat 中新建查询
2. 复制 `sample-data.sql` 文件内容
3. 运行查询
4. 成功后会显示插入了 25 本书

**导入真实数据 (生产环境):**

可以使用以下方式:
- CSV 导入: Navicat → **导入向导**
- Excel 导入: 整理数据后使用 Navicat 导入
- SQL 脚本: 批量 INSERT 语句

#### 步骤 5: 配置数据库 API 服务器

1. 编辑 `db-server.js`,修改数据库连接信息:

```javascript
const dbConfig = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '您的数据库密码',  // ⚠️ 修改这里
  database: 'libai_db',
  charset: 'utf8mb4'
};
```

2. 安装依赖:

```powershell
npm install
```

3. 启动数据库 API 服务器:

```powershell
npm run db-server
```

看到以下信息表示成功:
```
🚀 数据库 API 服务器运行在 http://localhost:3001
📊 数据库: libai_db@localhost:3306
✅ 数据库连接成功!
```

#### 步骤 6: 测试连接

打开浏览器访问:
```
http://localhost:3001/api/health
```

应该看到:
```json
{
  "success": true,
  "message": "数据库服务正常",
  "timestamp": "2026-01-16T..."
}
```

---

### 阶段三: 在其他电脑上部署数据库

如果您想在多台电脑上使用 LibAI 的数据库功能,有两种方案:

#### 方案 A: 每台电脑独立部署数据库

在每台电脑上重复 **阶段二** 的所有步骤。

**优点:**
- ✅ 各自独立,不受网络影响
- ✅ 数据可以不同

**缺点:**
- ❌ 需要多次配置
- ❌ 数据不同步

#### 方案 B: 中心化数据库服务器 (推荐)

将数据库部署在一台中心服务器上,其他电脑通过网络访问。

**步骤 1: 在服务器上部署**

1. 在一台电脑(服务器)上完成 **阶段二** 的部署
2. 记录服务器的 IP 地址 (例如: `192.168.1.100`)

**步骤 2: 配置 MySQL 远程访问**

在服务器上执行:

```sql
-- 创建远程访问用户
CREATE USER 'libai_user'@'%' IDENTIFIED BY 'your_password';

-- 授予权限
GRANT ALL PRIVILEGES ON libai_db.* TO 'libai_user'@'%';

-- 刷新权限
FLUSH PRIVILEGES;
```

编辑 MySQL 配置文件:

**Windows**: `C:\ProgramData\MySQL\MySQL Server 8.0\my.ini`
**Linux/Mac**: `/etc/mysql/mysql.conf.d/mysqld.cnf`

找到并修改:
```ini
bind-address = 0.0.0.0  # 允许所有IP访问
```

重启 MySQL 服务:

**Windows**:
```powershell
Restart-Service MySQL80
```

**Linux/Mac**:
```bash
sudo systemctl restart mysql
```

**步骤 3: 配置防火墙**

**Windows 防火墙:**

```powershell
# 允许 3306 端口
New-NetFirewallRule -DisplayName "MySQL" -Direction Inbound -Protocol TCP -LocalPort 3306 -Action Allow

# 允许 3001 端口 (API 服务器)
New-NetFirewallRule -DisplayName "LibAI API" -Direction Inbound -Protocol TCP -LocalPort 3001 -Action Allow
```

**Linux 防火墙 (UFW):**

```bash
sudo ufw allow 3306/tcp
sudo ufw allow 3001/tcp
sudo ufw reload
```

**步骤 4: 在客户端电脑配置**

1. 在客户端电脑上安装 Node.js
2. 复制 `db-server.js` 和 `package.json` 到客户端
3. 修改 `db-server.js` 中的数据库配置:

```javascript
const dbConfig = {
  host: '192.168.1.100',  // ⚠️ 服务器IP地址
  port: 3306,
  user: 'libai_user',     // ⚠️ 远程用户
  password: 'your_password',
  database: 'libai_db',
  charset: 'utf8mb4'
};
```

4. 启动 API 服务器:

```powershell
npm install
npm run db-server
```

**步骤 5: 测试连接**

在客户端浏览器访问:
```
http://localhost:3001/api/books/titles
```

应该能看到服务器数据库中的书籍列表。

---

## 🎯 使用说明

### 1. 访问系统

## 🎯 使用说明

### 1. 访问系统

打开浏览器访问您的 Cloudflare Pages 地址:
```
https://libai.pages.dev
```

### 2. 启用数据库模式

在界面右上角,打开 **"Local Database"** 开关。

### 3. 查询书籍

输入自然语言查询,例如:
- "I need books on environmental pollution control"
- "推荐一些关于人工智能的书籍"
- "Can you recommend books about biology?"

### 4. 查看结果

AI 会分析您的需求并返回:
- 📝 简短的推荐说明
- 📊 书籍详情表格 (包含12个元数据字段)

### 示例查询与结果

**查询**: "I need books on environmental pollution control"

**AI 响应**:
> Based on your research interest in environmental pollution control, I've identified several relevant books from our library collection that cover theoretical frameworks, technological solutions, policy analysis, and case studies.

**书籍表格**:

| ID | Title | Author | Language | Publisher | Subjects | ... |
|----|-------|--------|----------|-----------|----------|-----|
| 7 | Environmental Pollution Control Engineering | C.S. Rao | English | New Age International | Environmental Engineering; Pollution Control | ... |
| 8 | Green Technologies for Pollution Control | Jonathan Smith | English | Cambridge University Press | Green Technology; Environmental Protection | ... |

## 🔄 更新与维护

### 更新前端代码

```powershell
# 修改 LibAI.html 后提交
git add LibAI.html
git commit -m "Update frontend"
git push
```

Cloudflare Pages 会自动重新部署 (约 1-2 分钟)。

### 更新 Worker 代码

```powershell
# 修改 worker.js 后重新部署
wrangler deploy
```

### 更新数据库

**添加新书籍:**

使用 Navicat 或 SQL:

```sql
INSERT INTO books (title, author, language, publisher, subjects, document_type, physical_description, classification, status, location, call_number)
VALUES 
('Book Title', 'Author Name', 'English', 'Publisher', 'Subject1; Subject2', 'Book', '500 pages; 24 cm', 'TP123', 'Available', '3rd Floor, Zone A', 'TP123/A12');
```

**修改书籍状态:**

```sql
UPDATE books SET status = 'Checked Out' WHERE id = 3;
```

### 本地测试

```powershell
# 测试数据库 API
npm run db-server

# 在浏览器中打开 LibAI.html
# 然后测试查询功能
```

## 💰 成本估算

| 服务 | 免费额度 | 成本 |
|------|---------|------|
| **Cloudflare Pages** | 500 次构建/月 | 免费 |
| **Cloudflare Workers** | 100,000 请求/天 | 免费 |
| **DeepSeek API** | 按使用量计费 | ~¥0.001/次查询 |
| **MySQL 数据库** | 本地部署 | 免费 |

💡 **个人/学校项目完全免费或成本极低!**

## 🐛 常见问题与解决

### Q1: 数据库连接失败

**问题**: `❌ 数据库连接失败: ECONNREFUSED`

**解决**:
1. 检查 MySQL 服务是否运行
   ```powershell
   # Windows
   Get-Service MySQL80
   
   # Linux
   sudo systemctl status mysql
   ```
2. 检查端口 3306 是否被占用
3. 验证 `db-server.js` 中的密码是否正确

### Q2: 表格不显示

**问题**: AI 返回了推荐,但看不到表格

**解决**:
1. 按 F12 打开浏览器控制台
2. 查看是否有错误:
   - `Failed to fetch` - 数据库 API 服务器未运行
   - `CORS error` - 端口配置问题
3. 确认数据库 API 服务器正在运行:
   ```
   npm run db-server
   ```

### Q3: AI 没有返回书籍 ID

**问题**: AI 只返回文字,没有 "Recommended Book IDs:"

**解决**:
1. 检查数据库中是否有数据:
   ```sql
   SELECT COUNT(*) FROM books;
   ```
2. 重新启动数据库 API 服务器
3. 清除浏览器缓存并刷新页面

### Q4: 远程访问数据库失败

**问题**: 客户端无法连接到服务器数据库

**解决**:
1. 检查网络连通性:
   ```powershell
   ping 192.168.1.100
   ```
2. 测试端口是否开放:
   ```powershell
   Test-NetConnection -ComputerName 192.168.1.100 -Port 3306
   ```
3. 检查防火墙规则
4. 验证 MySQL 远程用户权限:
   ```sql
   SELECT user, host FROM mysql.user WHERE user='libai_user';
   ```

### Q5: CORS 错误

**问题**: 浏览器提示跨域错误

**解决**:
1. 检查 `worker.js` 中的 CORS 配置
2. 确保数据库 API 在 `db-server.js` 中启用了 CORS:
   ```javascript
   app.use(cors());
   ```

### Q6: Worker 部署失败

**问题**: `wrangler deploy` 失败

**解决**:
```powershell
# 检查登录状态
wrangler whoami

# 重新登录
wrangler logout
wrangler login

# 重新部署
wrangler deploy
```

## 📚 项目文件说明

### 核心文件

| 文件 | 说明 | 用途 |
|------|------|------|
| `LibAI.html` | 前端页面 | 用户界面,部署到 Cloudflare Pages |
| `worker.js` | Cloudflare Worker | AI API 代理 |
| `db-server.js` | 数据库 API 服务器 | 本地运行,提供书籍查询接口 |
| `package.json` | 项目配置 | 依赖管理 |
| `wrangler.toml` | Worker 配置 | Cloudflare 部署配置 |

### SQL 文件

| 文件 | 说明 |
|------|------|
| `library-metadata-format.sql` | 表结构 (空白) |
| `sample-data.sql` | 示例数据 (25本书) |

### 文档文件

| 文件 | 说明 |
|------|------|
| `README.md` | 项目文档 (本文件) |
| `LIBRARY_METADATA_STANDARD.md` | 元数据标准说明 |
| `DEPLOYMENT.md` | 部署详细指南 |

## � 安全建议

### 生产环境部署

1. **数据库密码**:
   - 使用强密码 (至少12位,包含大小写字母、数字、特殊字符)
   - 不要在代码中硬编码,使用环境变量

2. **API 密钥**:
   - DeepSeek API 密钥必须加密存储在 Cloudflare Workers
   - 定期轮换密钥

3. **网络安全**:
   - 如果部署在公网,使用 VPN 或 IP 白名单
   - 配置 SSL/TLS 证书
   - 启用 MySQL 的 SSL 连接

4. **备份**:
   - 定期备份数据库:
     ```bash
     mysqldump -u root -p libai_db > backup.sql
     ```
   - 自动备份脚本 (建议每天备份)

## 📈 性能优化

### 数据库优化

```sql
-- 添加索引以提高查询速度
CREATE INDEX idx_subjects ON books(subjects);
CREATE INDEX idx_title ON books(title);
CREATE INDEX idx_classification ON books(classification);
```

### 缓存策略

考虑添加 Redis 缓存层以减少数据库查询:
```javascript
// 缓存书籍列表 (5分钟)
// 缓存查询结果 (1分钟)
```

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

### 缓存策略

考虑添加 Redis 缓存层以减少数据库查询:
```javascript
// 缓存书籍列表 (5分钟)
// 缓存查询结果 (1分钟)
```

## 🤝 贡献指南

欢迎贡献!如果您发现问题或有改进建议:

1. Fork 本项目
2. 创建您的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🔗 相关链接

- [DeepSeek API 文档](https://platform.deepseek.com/)
- [Cloudflare Workers 文档](https://developers.cloudflare.com/workers/)
- [Cloudflare Pages 文档](https://developers.cloudflare.com/pages/)
- [Vue 3 文档](https://vuejs.org/)
- [Marked.js 文档](https://marked.js.org/)
- [MySQL 文档](https://dev.mysql.com/doc/)
- [Navicat Premium](https://www.navicat.com/)

## 🙏 致谢

- [DeepSeek](https://www.deepseek.com/) - 强大的 AI 推理引擎
- [Cloudflare](https://www.cloudflare.com/) - 全球化边缘计算平台
- [Vue.js](https://vuejs.org/) - 渐进式 JavaScript 框架
- [Tailwind CSS](https://tailwindcss.com/) - 实用优先的 CSS 框架
- [Marked.js](https://marked.js.org/) - 快速的 Markdown 解析器
- [MySQL](https://www.mysql.com/) - 可靠的关系型数据库

---

**⭐ 如果这个项目对您有帮助,请给个 Star!**

**Made with ❤️ for Library Information Retrieval and Academic Research**

**适用场景**: 高校图书馆、公共图书馆、研究机构、学术资源检索
