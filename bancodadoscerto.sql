CREATE TABLE aeronaves (
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    codigo_cauda VARCHAR(10) UNIQUE NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0)
);


-- Tabela de pilotos
CREATE TABLE pilotos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    codigo_anac CHAR(6) UNIQUE NOT NULL,
    horas_voo INTEGER DEFAULT 0 CHECK (horas_voo >= 0)
);


-- Tabela de voos
CREATE TABLE voos (
    id SERIAL PRIMARY KEY,
    aeronave_id INTEGER NOT NULL,
    piloto_id INTEGER NOT NULL,
    numero_voo VARCHAR(20) NOT NULL,
    origem VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendado'
        CHECK (status IN ('Agendado', 'Em Voo', 'Concluido', 'Cancelado')),

    FOREIGN KEY (aeronave_id) REFERENCES aeronaves(id),
    FOREIGN KEY (piloto_id) REFERENCES pilotos(id)
);


-- Tabela de passageiros
CREATE TABLE passageiros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);


-- Tabela de passagens
CREATE TABLE passagens (
    id SERIAL PRIMARY KEY,
    voo_id INTEGER NOT NULL,
    passageiro_id INTEGER NOT NULL,
    assento VARCHAR(4) NOT NULL,
    classe VARCHAR(20) DEFAULT 'Economica'
        CHECK (classe IN ('Economica', 'Executiva')),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),

    FOREIGN KEY (voo_id) REFERENCES voos(id),
    FOREIGN KEY (passageiro_id) REFERENCES passageiros(id)
);



CREATE TABLE aeronaves (
    id SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    codigo_cauda VARCHAR(10) UNIQUE NOT NULL,
    capacidade INTEGER NOT NULL CHECK (capacidade > 0)
);


-- Tabela de pilotos
CREATE TABLE pilotos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    codigo_anac CHAR(6) UNIQUE NOT NULL,
    horas_voo INTEGER DEFAULT 0 CHECK (horas_voo >= 0)
);


-- Tabela de voos
CREATE TABLE voos (
    id SERIAL PRIMARY KEY,
    aeronave_id INTEGER NOT NULL,
    piloto_id INTEGER NOT NULL,
    numero_voo VARCHAR(20) NOT NULL,
    origem VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Agendado'
        CHECK (status IN ('Agendado', 'Em Voo', 'Concluido', 'Cancelado')),

    FOREIGN KEY (aeronave_id) REFERENCES aeronaves(id),
    FOREIGN KEY (piloto_id) REFERENCES pilotos(id)
);


-- Tabela de passageiros
CREATE TABLE passageiros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);


-- Tabela de passagens
CREATE TABLE passagens (
    id SERIAL PRIMARY KEY,
    voo_id INTEGER NOT NULL,
    passageiro_id INTEGER NOT NULL,
    assento VARCHAR(4) NOT NULL,
    classe VARCHAR(20) DEFAULT 'Economica'
        CHECK (classe IN ('Economica', 'Executiva')),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),

    FOREIGN KEY (voo_id) REFERENCES voos(id),
    FOREIGN KEY (passageiro_id) REFERENCES passageiros(id)
);



SELECT
    v.numero_voo,
    v.origem,
    v.destino,
    a.modelo,
    p.nome AS piloto
FROM voos v
JOIN aeronaves a
    ON v.aeronave_id = a.id
JOIN pilotos p
    ON v.piloto_id = p.id
WHERE v.status IN ('Agendado', 'Em Voo');


SELECT
    classe,
    SUM(valor) AS total_arrecadado
FROM passagens
GROUP BY classe;


SELECT
    p.nome AS passageiro,
    v.numero_voo,
    pa.assento,
    pa.valor
FROM passagens pa
JOIN passageiros p
    ON pa.passageiro_id = p.id
JOIN voos v
    ON pa.voo_id = v.id
WHERE pa.classe = 'Executiva'
  AND pa.valor > 800
ORDER BY pa.valor DESC;



CREATE VIEW vw_painel_aeroporto AS
SELECT
    v.numero_voo,
    v.data_hora,
    v.origem,
    v.destino,
    a.modelo,
    a.codigo_cauda,
    v.status
FROM voos v
JOIN aeronaves a
    ON v.aeronave_id = a.id;




    SELECT * FROM vw_painel_aeroporto;




    CREATE VIEW vw_faturamento_por_voo AS
SELECT
    v.id AS voo_id,
    v.numero_voo,
    v.destino,
    COUNT(pa.id) AS quantidade_passageiros,
    COALESCE(SUM(pa.valor), 0) AS receita_total
FROM voos v
LEFT JOIN passagens pa
    ON v.id = pa.voo_id
GROUP BY
    v.id,
    v.numero_voo,
    v.destino;




    SELECT * FROM vw_faturamento_por_voo;



    