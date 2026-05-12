  
  
  INSERT INTO catalogo_servicios
            (
                codigo,
                nombreServicio,
                esGlobal,
                idCiaPropietaria,
                activo
            )

            SELECT
                (
                    (3 * 1000) +
                    COALESCE(
                        MAX(
                            CAST(codigo AS INTEGER)
                        ) % 1000,
                        0
                    ) + 1
                )::VARCHAR AS codigo,

                'prueba cia 3-2' AS nombreServicio,

                FALSE AS esGlobal,

                3 AS idCiaPropietaria,

                TRUE AS activo

            FROM catalogo_servicios
            WHERE idCiaPropietaria = 3