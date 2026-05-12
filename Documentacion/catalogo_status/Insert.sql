

INSERT INTO itmanager.catalogo_estados
(
    nombre,
    esfinal,
    es_global,
    id_tipo,
    codigo_estado
)

SELECT
    'En Stock' AS nombre,

    FALSE AS esfinal,

    False AS es_global,

    1 AS id_tipo,

    (
        (1 * 1000) +
        COALESCE(
            MAX(
                CAST(codigo_estado AS INTEGER)
            ) % 1000,
            0
        ) + 1
    ) AS codigo_estado

FROM itmanager.catalogo_estados
WHERE id_tipo = 1

RETURNING *;


