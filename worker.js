// Cloudflare Worker - 作为 API 代理
export default {
  async fetch(request, env) {
    // 处理 CORS 预检请求
    if (request.method === 'OPTIONS') {
      return new Response(null, {
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, Authorization',
        },
      });
    }

    // 只处理 /api/chat 路径
    const url = new URL(request.url);
    if (url.pathname === '/api/chat' && request.method === 'POST') {
      try {
        const { messages } = await request.json();
        
        // 调用 DeepSeek API
        const response = await fetch('https://api.deepseek.com/chat/completions', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${env.DEEPSEEK_API_KEY}`, // 从环境变量读取
          },
          body: JSON.stringify({
            model: 'deepseek-reasoner',
            messages: messages,
            stream: false,
          }),
        });

        const data = await response.json();

        return new Response(JSON.stringify(data), {
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
        });
      } catch (error) {
        return new Response(JSON.stringify({ 
          error: 'Failed to get response from AI',
          details: error.message 
        }), {
          status: 500,
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
          },
        });
      }
    }

    return new Response('Not Found', { status: 404 });
  },
};
