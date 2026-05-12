-- =========================================
-- DATA DUMMY - CATALOGO SERVICIOS
-- =========================================

INSERT INTO catalogo_servicios
(
    codigo,
    nombreservicio,
    esglobal,
    idciapropietaria,
    estado,
    activo
)
VALUES

-- =========================================
-- SERVICIOS GLOBALES
-- =========================================

('01', 'Internet', TRUE, NULL, TRUE, TRUE),
('02', 'AWS', TRUE, NULL, TRUE, TRUE),
('03', 'Azure', TRUE, NULL, TRUE, TRUE),
('04', 'Microsoft 365', TRUE, NULL, TRUE, TRUE),
('05', 'Google Workspace', TRUE, NULL, TRUE, TRUE),
('06', 'Zoom', TRUE, NULL, TRUE, TRUE),
('07', 'Slack', TRUE, NULL, TRUE, TRUE),
('08', 'GitHub Enterprise', TRUE, NULL, TRUE, TRUE),
('09', 'Cloudflare', TRUE, NULL, TRUE, TRUE),
('10', 'Udemy', TRUE, NULL, TRUE, TRUE),

-- =========================================
-- COMPAÑIA 1
-- =========================================

('1001', 'MPLS Banco', FALSE, 1, TRUE, TRUE),
('1002', 'SAP Legacy', FALSE, 1, TRUE, TRUE),
('1003', 'VPN Sucursal Norte', FALSE, 1, TRUE, TRUE),
('1004', 'Firewall Fortinet HA', FALSE, 1, TRUE, TRUE),
('1005', 'Core Financiero', FALSE, 1, TRUE, TRUE),

-- =========================================
-- COMPAÑIA 2
-- =========================================

('2001', 'Enlace Satelital', FALSE, 2, TRUE, TRUE),
('2002', 'Oracle ERP', FALSE, 2, TRUE, TRUE),
('2003', 'Datacenter DRP', FALSE, 2, TRUE, TRUE),
('2004', 'Antivirus Corporativo', FALSE, 2, TRUE, TRUE),
('2005', 'VPN Casa Matriz', FALSE, 2, TRUE, TRUE),

-- =========================================
-- COMPAÑIA 3
-- =========================================

('3001', 'Sistema Produccion', FALSE, 3, TRUE, TRUE),
('3002', 'Monitoreo Industrial', FALSE, 3, TRUE, TRUE),
('3003', 'Telefonia IP', FALSE, 3, TRUE, TRUE),
('3004', 'Backup Veeam', FALSE, 3, TRUE, TRUE),
('3005', 'SIEM Corporativo', FALSE, 3, TRUE, TRUE),

-- =========================================
-- COMPAÑIA 4
-- =========================================

('4001', 'Control Acceso Biométrico', FALSE, 4, TRUE, TRUE),
('4002', 'ERP Distribucion', FALSE, 4, TRUE, TRUE),
('4003', 'Balanceador F5', FALSE, 4, TRUE, TRUE),
('4004', 'VPN Regional', FALSE, 4, TRUE, TRUE),
('4005', 'CCTV Inteligente', FALSE, 4, TRUE, TRUE);