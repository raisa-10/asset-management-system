-- ==========================================
-- ASSET MANAGEMENT SYSTEM DATABASE DUMP
-- ==========================================

-- Drop tables if exist (for re-run safety)
DROP TABLE IF EXISTS asset_status_logs;
DROP TABLE IF EXISTS asset_assignments;
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS system_users;

-- ==========================================
-- 1. Departments Table
-- ==========================================
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. Employees Table
-- ==========================================
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    department_id INTEGER,
    date_of_joining DATE,
    employment_status VARCHAR(50) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. Assets Table
-- ==========================================
CREATE TABLE assets (
    asset_id SERIAL PRIMARY KEY,
    asset_code VARCHAR(50) UNIQUE NOT NULL,
    asset_name VARCHAR(150) NOT NULL,
    asset_type VARCHAR(100),
    serial_number VARCHAR(150) UNIQUE,
    purchase_date DATE,
    asset_value NUMERIC(12,2),
    asset_status VARCHAR(50) DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 4. Asset Assignments Table
-- ==========================================
CREATE TABLE asset_assignments (
    assignment_id SERIAL PRIMARY KEY,
    asset_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    assigned_date DATE NOT NULL,
    expected_return_date DATE,
    actual_return_date DATE,
    assignment_status VARCHAR(50) DEFAULT 'ASSIGNED',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 5. Asset Status Logs (History Tracking)
-- ==========================================
CREATE TABLE asset_status_logs (
    log_id SERIAL PRIMARY KEY,
    asset_id INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    status_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by_user_id INTEGER,
    remarks TEXT
);

-- ==========================================
-- 6. System Users (HR/Admin Accounts)
-- ==========================================
CREATE TABLE system_users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL, -- ADMIN / HR
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- INSERT DUMMY DATA
-- ==========================================

-- Departments
INSERT INTO departments (department_name, department_location) VALUES
('Human Resources', 'Head Office'),
('Engineering', 'Tech Park'),
('Finance', 'Head Office'),
('Operations', 'Warehouse');

-- Employees (Sample only – scalable to 1000+)
INSERT INTO employees (employee_code, first_name, last_name, email, phone_number, department_id, date_of_joining)
VALUES
('EMP001', 'Aisha', 'Khan', 'aisha.khan@company.com', '9876543210', 1, '2022-01-10'),
('EMP002', 'Rahul', 'Sharma', 'rahul.sharma@company.com', '9876543211', 2, '2021-03-15'),
('EMP003', 'Meera', 'Nair', 'meera.nair@company.com', '9876543212', 3, '2020-07-20');

-- Assets
INSERT INTO assets (asset_code, asset_name, asset_type, serial_number, purchase_date, asset_value)
VALUES
('AST001', 'Dell Latitude 5420', 'Laptop', 'SN123456', '2023-01-15', 75000.00),
('AST002', 'iPhone 14', 'Mobile Phone', 'SN987654', '2023-03-10', 80000.00),
('AST003', 'HP LaserJet Printer', 'Printer', 'SN555666', '2022-11-05', 25000.00);

-- Asset Assignments
INSERT INTO asset_assignments (asset_id, employee_id, assigned_date)
VALUES
(1, 2, '2023-04-01'),
(2, 1, '2023-05-10');

-- Asset Status Logs
INSERT INTO asset_status_logs (asset_id, status, updated_by_user_id, remarks)
VALUES
(1, 'ASSIGNED', 1, 'Assigned to Rahul Sharma'),
(2, 'ASSIGNED', 1, 'Assigned to Aisha Khan');

-- System Users
INSERT INTO system_users (username, password_hash, role)
VALUES
('admin_user', 'hashed_password_123', 'ADMIN'),
('hr_user', 'hashed_password_456', 'HR');
