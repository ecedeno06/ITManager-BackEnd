-- IT Asset Management Database Schema

-- Regions table
CREATE TABLE IF NOT EXISTS regions (
  id SERIAL PRIMARY KEY,
  country VARCHAR(100) NOT NULL,
  province VARCHAR(100) NOT NULL,
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  risk_level CHAR(1) CHECK (risk_level IN ('H', 'M', 'L')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Companies table
CREATE TABLE IF NOT EXISTS companies (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  tax_id VARCHAR(50) UNIQUE,
  address TEXT,
  region_id INTEGER REFERENCES regions(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Roles table
CREATE TABLE IF NOT EXISTS roles (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  permissions JSONB DEFAULT '{}'
);

-- Modules table (Menu Options)
CREATE TABLE IF NOT EXISTS modules (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Role Permissions (Granular CRUD)
CREATE TABLE IF NOT EXISTS role_permissions (
  role_id INTEGER REFERENCES roles(id) ON DELETE CASCADE,
  module_id INTEGER REFERENCES modules(id) ON DELETE CASCADE,
  can_create BOOLEAN DEFAULT FALSE,
  can_read BOOLEAN DEFAULT TRUE,
  can_update BOOLEAN DEFAULT FALSE,
  can_delete BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (role_id, module_id)
);

-- Users table
CREATE TABLE IF NOT EXISTS users (
  email VARCHAR(100) PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL, 
  department VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  active boolean,
  activated_date DATE,
  deactivate_date DATE,
  topt INTEGER,
  topt_live DATE
);

-- User Roles Junction Table (Many-to-Many + Company Specific)
CREATE TABLE IF NOT EXISTS user_roles (
  user_email VARCHAR(100) REFERENCES users(email) ON DELETE CASCADE ON UPDATE CASCADE,
  role_id INTEGER REFERENCES roles(id) ON DELETE CASCADE,
  company_id INTEGER REFERENCES companies(id) ON DELETE CASCADE,
  assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  assigned_by VARCHAR(100),
  active boolean,
  start_date DATE NOT NULL DEFAULT CURRENT_DATE,
  end_date DATE, -- NULL means indefinite
  PRIMARY KEY (user_email, role_id, company_id)
);

-- User Companies Junction Table (Kept for primary company context)
CREATE TABLE IF NOT EXISTS user_companies (
  user_email VARCHAR(100) REFERENCES users(email) ON DELETE CASCADE ON UPDATE CASCADE,
  company_id INTEGER REFERENCES companies(id) ON DELETE CASCADE,
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_primary BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (user_email, company_id)
);

-- Equipment table
CREATE TABLE IF NOT EXISTS equipment (
  id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL, -- Laptop, Desktop, Mobile, etc.
  brand VARCHAR(50),
  model VARCHAR(50),
  serial_number VARCHAR(100) UNIQUE NOT NULL,
  assigned_to_email VARCHAR(100) REFERENCES users(email) ON DELETE SET NULL ON UPDATE CASCADE,
  status VARCHAR(20) DEFAULT 'available', -- available, assigned, maintenance, retired
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services table (Software or Services)
CREATE TABLE IF NOT EXISTS services (
  id SERIAL PRIMARY KEY,
  service_name VARCHAR(100) NOT NULL,
  manufacturer VARCHAR(100), -- Microsoft, AWS, etc.
  service_type VARCHAR(50), -- software, cloud_service, maintenance, etc.
  license_key VARCHAR(255), -- Optional, for software
  cost DECIMAL(10, 2),
  billing_period VARCHAR(20), -- monthly, annually, one-time, etc.
  is_recurring BOOLEAN DEFAULT TRUE,
  is_variable_cost BOOLEAN DEFAULT FALSE,
  active BOOLEAN DEFAULT TRUE,
  expiration_date DATE,
  assigned_to_user_email VARCHAR(100) REFERENCES users(email) ON DELETE SET NULL ON UPDATE CASCADE,
  assigned_to_equipment INTEGER REFERENCES equipment(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Service Payments (History)
CREATE TABLE IF NOT EXISTS service_payments (
  id SERIAL PRIMARY KEY,
  service_id INTEGER REFERENCES services(id) ON DELETE CASCADE,
  amount DECIMAL(10, 2) NOT NULL,
  payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
  attachments JSONB,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Initial Data
INSERT INTO roles (name, permissions) VALUES 
('Admin', '{"all": true}'),
('Operator', '{"read": true, "write": true}'),
('Viewer', '{"read": true}')
ON CONFLICT (name) DO NOTHING;

-- Seed Modules
INSERT INTO modules (name, description) VALUES
('Users', 'System user management'),
('Licenses', 'Software and service licenses'),
('Equipment', 'IT hardware and devices'),
('Payments', 'Financial transaction history')
ON CONFLICT (name) DO NOTHING;

-- Seed Sample Permissions
-- Assuming Admin has all permissions on all modules
-- (Getting role/module IDs)
-- This is a sample, normally IDs are retrieved first.
-- Admin permissions (Assumes ID 1)
INSERT INTO role_permissions (role_id, module_id, can_create, can_read, can_update, can_delete)
SELECT r.id, m.id, true, true, true, true
FROM roles r, modules m
WHERE r.name = 'Admin'
ON CONFLICT (role_id, module_id) DO NOTHING;

-- Viewer permissions (Read-only)
INSERT INTO role_permissions (role_id, module_id, can_create, can_read, can_update, can_delete)
SELECT r.id, m.id, false, true, false, false
FROM roles r, modules m
WHERE r.name = 'Viewer'
ON CONFLICT (role_id, module_id) DO NOTHING;
