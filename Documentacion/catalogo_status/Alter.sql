ALTER TABLE itmanager.activo_estados ADD es_global boolean DEFAULT true NULL;
ALTER TABLE itmanager.activo_estados ADD id_tipo int8 NULL;
ALTER TABLE itmanager.activo_estados RENAME TO catalogo_estados;
ALTER TABLE itmanager.catalogo_estados ADD codigo_estado int8 NULL;
