INSERT INTO catalogo_servicios
(
    codigo,
    nombreservicio,
    esglobal,
    idciapropietaria,
    estado,
    activo
)

SELECT

    CASE

        -- GLOBAL
        WHEN $1 = TRUE THEN

            LPAD(
                (
                    COALESCE(
                        MAX(
                            CASE
                                WHEN esglobal = TRUE
                                THEN CAST(codigo AS INTEGER)
                            END
                        ),
                        0
                    ) + 1
                )::TEXT,
                ,
                '0'
            )

        -- PRIVADO
        ELSE

            (
                ($2 * 1000) +

                COALESCE(
                    MAX(
                        CASE
                            WHEN idciapropietaria = $2
                            THEN CAST(codigo AS INTEGER)
                        END
                    ) % 1000,
                    0
                ) + 1

            )::TEXT

    END AS codigo,

    $3 AS nombreservicio,

    $1 AS esglobal,

    CASE
        WHEN $1 = TRUE THEN NULL
        ELSE $2
    END AS idciapropietaria,

    TRUE AS estado,

    TRUE AS activo

FROM catalogo_servicios

RETURNING *;