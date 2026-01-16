-- 示例数据插入脚本
-- 此文件包含25本示例书籍数据，用于测试和演示

USE libai_db;

-- 插入示例数据
-- Computer Science & Technology
INSERT INTO books (title, author, language, publisher, publication_time, subjects, document_type, physical_description, classification, status, location, call_number) VALUES
('Introduction to Algorithms', 'Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein', 'English', 'MIT Press', '2009', 'Computer Science; Algorithms; Data Structures', 'Book', '1312 pages; 24 cm', 'TP312.1', 'Available', '3rd Floor, Zone A, Shelf 15', 'TP312.1/C82'),
('Clean Code: A Handbook of Agile Software Craftsmanship', 'Robert C. Martin', 'English', 'Prentice Hall', '2008', 'Software Engineering; Programming; Code Quality', 'Book', '464 pages; 23 cm', 'TP311.5', 'Available', '3rd Floor, Zone A, Shelf 22', 'TP311.5/M36'),
('Artificial Intelligence: A Modern Approach', 'Stuart Russell, Peter Norvig', 'English', 'Pearson Education', '2020', 'Artificial Intelligence; Machine Learning; Neural Networks', 'Book', '1136 pages; 26 cm', 'TP18', 'Checked Out', '3rd Floor, Zone B, Shelf 8', 'TP18/R91'),
('Python Crash Course: A Hands-On, Project-Based Introduction', 'Eric Matthes', 'English', 'No Starch Press', '2019', 'Programming; Python; Software Development', 'Book', '544 pages; 23 cm', 'TP312.8', 'Available', '3rd Floor, Zone A, Shelf 28', 'TP312.8/M38'),
('Database System Concepts', 'Abraham Silberschatz, Henry F. Korth, S. Sudarshan', 'English', 'McGraw-Hill Education', '2019', 'Database Systems; SQL; Data Management', 'Book', '1376 pages; 24 cm', 'TP311.13', 'Available', '3rd Floor, Zone A, Shelf 18', 'TP311.13/S57'),

-- Environmental Science
('Environmental Science: Toward a Sustainable Future', 'Richard T. Wright, Dorothy F. Boorse', 'English', 'Pearson Education', '2017', 'Environmental Science; Sustainability; Ecology', 'Book', '720 pages; 28 cm', 'X-1', 'Available', '4th Floor, Zone C, Shelf 12', 'X-1/W93'),
('Environmental Pollution Control Engineering', 'C.S. Rao', 'English', 'New Age International Publishers', '2020', 'Environmental Engineering; Pollution Control; Technology', 'Book', '532 pages; 24 cm', 'X50', 'Available', '4th Floor, Zone C, Shelf 15', 'X50/R21'),
('Green Technologies for Pollution Control and Sustainable Development', 'Jonathan Smith', 'English', 'Cambridge University Press', '2023', 'Green Technology; Environmental Protection; Innovation', 'Book', '488 pages; 25 cm', 'X50', 'Available', '4th Floor, Zone C, Shelf 18', 'X50/S64'),
('Climate Change: Evidence and Causes', 'National Academy of Sciences, Royal Society', 'English', 'National Academies Press', '2020', 'Climate Science; Global Warming; Environmental Policy', 'Book', '36 pages; 23 cm', 'X16', 'Available', '4th Floor, Zone C, Shelf 22', 'X16/N21'),
('Sustainable Development Goals: A Global Perspective', 'Maria Rodriguez', 'English', 'Springer Nature', '2021', 'Sustainability; Development; International Policy', 'Book', '456 pages; 24 cm', 'X-1', 'Available', '4th Floor, Zone C, Shelf 25', 'X-1/R63'),

-- Biology & Life Sciences
('Campbell Biology', 'Jane B. Reece, Lisa A. Urry, Michael L. Cain, Steven A. Wasserman', 'English', 'Pearson Education', '2020', 'Biology; Life Sciences; Genetics', 'Book', '1488 pages; 28 cm', 'Q3', 'Available', '4th Floor, Zone D, Shelf 5', 'Q3/R25'),
('Molecular Biology of the Cell', 'Bruce Alberts, Alexander Johnson, Julian Lewis', 'English', 'Garland Science', '2019', 'Molecular Biology; Cell Biology; Biochemistry', 'Book', '1464 pages; 29 cm', 'Q2', 'Available', '4th Floor, Zone D, Shelf 12', 'Q2/A35'),
('Plant Physiology and Development', 'Lincoln Taiz, Eduardo Zeiger, Ian Max Møller', 'English', 'Sinauer Associates', '2015', 'Plant Science; Botany; Physiology', 'Book', '761 pages; 28 cm', 'Q94', 'Checked Out', '4th Floor, Zone D, Shelf 18', 'Q94/T14'),
('Ecology: Concepts and Applications', 'Manuel C. Molles Jr.', 'English', 'McGraw-Hill Education', '2018', 'Ecology; Environmental Science; Conservation', 'Book', '608 pages; 27 cm', 'Q14', 'Available', '4th Floor, Zone D, Shelf 22', 'Q14/M65'),
('Genetics: A Conceptual Approach', 'Benjamin A. Pierce', 'English', 'W. H. Freeman and Company', '2019', 'Genetics; Molecular Genetics; Genomics', 'Book', '896 pages; 28 cm', 'Q3', 'Available', '4th Floor, Zone D, Shelf 15', 'Q3/P61'),

-- Business & Economics
('Principles of Economics', 'N. Gregory Mankiw', 'English', 'Cengage Learning', '2020', 'Economics; Microeconomics; Macroeconomics', 'Book', '896 pages; 26 cm', 'F0', 'Available', '2nd Floor, Zone E, Shelf 8', 'F0/M23'),
('Financial Accounting', 'Walter T. Harrison Jr., Charles T. Horngren', 'English', 'Pearson Education', '2018', 'Accounting; Finance; Business', 'Book', '768 pages; 28 cm', 'F23', 'Available', '2nd Floor, Zone E, Shelf 12', 'F23/H24'),
('Marketing Management', 'Philip Kotler, Kevin Lane Keller', 'English', 'Pearson Education', '2021', 'Marketing; Business Strategy; Consumer Behavior', 'Book', '720 pages; 26 cm', 'F71', 'Available', '2nd Floor, Zone E, Shelf 18', 'F71/K68'),
('Strategic Management: Concepts and Cases', 'Michael A. Hitt, R. Duane Ireland, Robert E. Hoskisson', 'English', 'Cengage Learning', '2019', 'Management; Strategy; Leadership', 'Book', '544 pages; 28 cm', 'F27', 'Available', '2nd Floor, Zone E, Shelf 22', 'F27/H58'),
('International Business: Competing in the Global Marketplace', 'John J. Wild, Kenneth L. Wild', 'English', 'Pearson Education', '2020', 'International Business; Global Trade; Economics', 'Book', '576 pages; 28 cm', 'F74', 'Available', '2nd Floor, Zone E, Shelf 25', 'F74/W57'),

-- Physics & Engineering
('Physics for Scientists and Engineers', 'Raymond A. Serway, John W. Jewett Jr.', 'English', 'Cengage Learning', '2018', 'Physics; Mechanics; Thermodynamics', 'Book', '1344 pages; 28 cm', 'O4', 'Available', '5th Floor, Zone F, Shelf 5', 'O4/S48'),
('Introduction to Quantum Mechanics', 'David J. Griffiths', 'English', 'Cambridge University Press', '2017', 'Quantum Physics; Modern Physics; Wave Mechanics', 'Book', '468 pages; 25 cm', 'O413.1', 'Available', '5th Floor, Zone F, Shelf 12', 'O413.1/G85'),
('Fundamentals of Electric Circuits', 'Charles K. Alexander, Matthew N.O. Sadiku', 'English', 'McGraw-Hill Education', '2016', 'Electrical Engineering; Circuit Analysis; Electronics', 'Book', '960 pages; 26 cm', 'TM1', 'Available', '5th Floor, Zone F, Shelf 18', 'TM1/A38'),
('Mechanical Engineering Design', 'Joseph Edward Shigley, Charles R. Mischke', 'English', 'McGraw-Hill Education', '2020', 'Mechanical Engineering; Machine Design; Engineering', 'Book', '1104 pages; 24 cm', 'TH12', 'Available', '5th Floor, Zone F, Shelf 22', 'TH12/S55'),
('Thermodynamics: An Engineering Approach', 'Yunus A. Cengel, Michael A. Boles', 'English', 'McGraw-Hill Education', '2019', 'Thermodynamics; Engineering; Energy Systems', 'Book', '1024 pages; 27 cm', 'O551', 'Available', '5th Floor, Zone F, Shelf 25', 'O551/C33');

-- 显示插入的数据统计
SELECT COUNT(*) AS total_books FROM books;
SELECT '25 sample books inserted successfully' AS message;
