# 快速部署脚本 - Cloudflare 版本

Write-Host " Library AI Assistant - Cloudflare 部署向导" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否安装了 wrangler
Write-Host " 检查 Wrangler CLI..." -ForegroundColor Yellow
`$wranglerInstalled = Get-Command wrangler -ErrorAction SilentlyContinue
if (-not `$wranglerInstalled) {
    Write-Host " Wrangler 未安装。正在安装..." -ForegroundColor Red
    npm install -g wrangler
    if (`$LASTEXITCODE -ne 0) {
        Write-Host " 安装失败，请手动运行: npm install -g wrangler" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host " Wrangler 已安装" -ForegroundColor Green
}

Write-Host ""
Write-Host " 部署 Cloudflare Worker (后端 API)..." -ForegroundColor Yellow
Write-Host ""

# 检查是否登录
Write-Host " 检查登录状态..." -ForegroundColor Yellow
`$loginStatus = wrangler whoami 2>&1
if (`$LASTEXITCODE -ne 0) {
    Write-Host "需要登录 Cloudflare..." -ForegroundColor Yellow
    wrangler login
    if (`$LASTEXITCODE -ne 0) {
        Write-Host " 登录失败" -ForegroundColor Red
        exit 1
    }
}

Write-Host " 已登录 Cloudflare" -ForegroundColor Green
Write-Host ""

# 部署
Write-Host " 开始部署 Worker..." -ForegroundColor Yellow
wrangler deploy

if (`$LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host " Worker 部署成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "" -ForegroundColor Cyan
    Write-Host " 下一步操作：" -ForegroundColor Cyan
    Write-Host "" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1  设置环境变量" -ForegroundColor Yellow
    Write-Host "   访问: https://dash.cloudflare.com/" -ForegroundColor White
    Write-Host "   进入: Workers 和 Pages > 您的 Worker > Settings > Variables" -ForegroundColor White
    Write-Host "   添加: DEEPSEEK_API_KEY = (您的 API Key)" -ForegroundColor White
    Write-Host ""
    Write-Host "2  复制 Worker URL" -ForegroundColor Yellow
    Write-Host "   在上面的输出中找到类似这样的 URL：" -ForegroundColor White
    Write-Host "   https://library-ai-assistant-worker.your-subdomain.workers.dev" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3  更新前端配置" -ForegroundColor Yellow
    Write-Host "   编辑 demo-Real AI.html 文件" -ForegroundColor White
    Write-Host "   找到: const API_ENDPOINT = ..." -ForegroundColor White
    Write-Host "   替换为您的 Worker URL + /api/chat" -ForegroundColor White
    Write-Host ""
    Write-Host "4  推送到 GitHub" -ForegroundColor Yellow
    Write-Host "   git init" -ForegroundColor White
    Write-Host "   git add ." -ForegroundColor White
    Write-Host "   git commit -m Initial commit" -ForegroundColor White
    Write-Host "   git remote add origin YOUR_GITHUB_REPO_URL" -ForegroundColor White
    Write-Host "   git push -u origin main" -ForegroundColor White
    Write-Host ""
    Write-Host "5  部署到 Cloudflare Pages" -ForegroundColor Yellow
    Write-Host "   访问: https://dash.cloudflare.com/" -ForegroundColor White
    Write-Host "   选择: Workers 和 Pages > Create > Pages > Connect to Git" -ForegroundColor White
    Write-Host "   选择您的 GitHub 仓库并部署" -ForegroundColor White
    Write-Host ""
    Write-Host "" -ForegroundColor Cyan
    Write-Host " 详细说明请查看: DEPLOYMENT.md" -ForegroundColor Cyan
    Write-Host "" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host " Worker 部署失败" -ForegroundColor Red
    Write-Host ""
    Write-Host "常见问题排查：" -ForegroundColor Yellow
    Write-Host "1. 检查 wrangler.toml 配置是否正确" -ForegroundColor White
    Write-Host "2. 确认已正确登录: wrangler whoami" -ForegroundColor White
    Write-Host "3. 查看详细错误信息并根据提示修复" -ForegroundColor White
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
`$null = `$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
