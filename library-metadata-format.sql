-- 按照学校图书馆元数据格式创建表结构
-- 此文件仅创建空白表，不包含示例数据

USE libai_db;

-- 删除旧表（如果存在）
DROP TABLE IF EXISTS books;

-- 创建新表结构（严格按照学校图书馆元数据格式）
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Book ID',
    title VARCHAR(255) NOT NULL COMMENT 'Title',
    author VARCHAR(255) NOT NULL COMMENT 'Author',
    language VARCHAR(50) DEFAULT 'English' COMMENT 'Language',
    publisher VARCHAR(255) COMMENT 'Publisher',
    publication_time VARCHAR(50) COMMENT 'Publication time',
    subjects VARCHAR(255) COMMENT 'Subjects',
    document_type VARCHAR(50) DEFAULT 'Book' COMMENT 'Document type',
    physical_description VARCHAR(255) COMMENT 'Physical description',
    classification VARCHAR(50) COMMENT 'Classification',
    status VARCHAR(20) DEFAULT 'Available' COMMENT 'Status',
    location VARCHAR(100) COMMENT 'Location',
    call_number VARCHAR(50) COMMENT 'Call number',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Library Books Metadata Table';

-- 表创建成功
SELECT 'Books table created successfully' AS message;
-- 表创建成功
SELECT 'Books table created successfully' AS message;
