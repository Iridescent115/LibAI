// 本地数据库 API 服务器
const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
const PORT = 3001;

// 中间件
app.use(cors());
app.use(express.json());

// 数据库连接配置
const dbConfig = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '123456',
  database: 'libai_db',
  charset: 'utf8mb4'
};

// 创建数据库连接池
const pool = mysql.createPool(dbConfig);

// 测试数据库连接
pool.getConnection()
  .then(conn => {
    console.log('✅ 数据库连接成功!');
    conn.release();
  })
  .catch(err => {
    console.error('❌ 数据库连接失败:', err.message);
  });

// API 路由 1: 获取所有书名列表(用于AI分析)
app.get('/api/books/titles', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT id, title, author, subjects FROM books ORDER BY id'
    );
    
    console.log(`📚 返回 ${rows.length} 本书的标题列表`);
    
    res.json({
      success: true,
      count: rows.length,
      books: rows
    });
  } catch (error) {
    console.error('❌ 查询书名列表失败:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// API 路由 2: 根据ID列表获取完整书籍信息
app.post('/api/books/details', async (req, res) => {
  try {
    const { ids } = req.body;
    
    if (!ids || !Array.isArray(ids) || ids.length === 0) {
      return res.status(400).json({
        success: false,
        error: '请提供有效的书籍ID数组'
      });
    }

    // 使用 IN 查询获取多本书的详细信息
    const placeholders = ids.map(() => '?').join(',');
    const [rows] = await pool.query(
      `SELECT * FROM books WHERE id IN (${placeholders}) ORDER BY id`,
      ids
    );
    
    console.log(`📖 返回 ${rows.length} 本书的详细信息, IDs: [${ids.join(', ')}]`);
    
    res.json({
      success: true,
      count: rows.length,
      books: rows
    });
  } catch (error) {
    console.error('❌ 查询书籍详情失败:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// API 路由 3: 健康检查
app.get('/api/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({
      success: true,
      message: '数据库服务正常',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: '数据库服务异常',
      error: error.message
    });
  }
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`🚀 数据库 API 服务器运行在 http://localhost:${PORT}`);
  console.log(`📊 数据库: ${dbConfig.database}@${dbConfig.host}:${dbConfig.port}`);
  console.log(`\n可用的 API 端点:`);
  console.log(`  GET  /api/health          - 健康检查`);
  console.log(`  GET  /api/books/titles    - 获取所有书名`);
  console.log(`  POST /api/books/details   - 根据ID获取书籍详情`);
});
