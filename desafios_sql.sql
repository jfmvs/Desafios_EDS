CREATE SCHEMA stg_hospital_a;
CREATE SCHEMA stg_hospital_b;
CREATE SCHEMA stg_hospital_c;

CREATE SCHEMA stg_prontuario;

CREATE TABLE stg_hospital_a.PACIENTE(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  dt_nascimento date,
  cpf VARCHAR(11),
  nome_mae VARCHAR(100),
  dt_atualizacao timestamp
);

CREATE TABLE stg_hospital_b.PACIENTE LIKE stg_hospital_a.PACIENTE;
CREATE TABLE stg_hospital_c.PACIENTE LIKE stg_hospital_a.PACIENTE;
CREATE TABLE stg_prontuario.PACIENTE LIKE stg_hospital_a.PACIENTE;

INSERT INTO stg_hospital_a.PACIENTE(nome, dt_nascimento, cpf, nome_mae, dt_atualizacao) VALUES 
('João Silva', '1990-01-01', '12345678901', 'Maria Silva', '2020-05-12 11:54:20'),
('Leticia Ribeiro', '1987-12-24', '46813579204', 'Beatriz Ribeiro', '2021-11-12 09:12:06'),
('Ana Santos', '1985-05-10', '10987654321', 'Julia Santos', '2023-04-02 22:40:57'),
('Pedro Souza', '1978-08-25', '98765432109', 'Paula Souza', '2022-11-11 14:17:30');

INSERT INTO stg_hospital_b.PACIENTE(nome, dt_nascimento, cpf, nome_mae, dt_atualizacao) VALUES 
('Lucas Oliveira', '1995-04-12', '13579246801', 'Laura Oliveira', '2019-11-11 13:45:09'),
('Marina Almeida', '1982-11-15', '24680135792', 'Isabela Almeida', '2022-11-05 15:56:22'),
('Antonio Santos', '1976-06-20', '57924681305', 'Silvana Santos', '2019-12-12 04:02:00');

INSERT INTO stg_hospital_c.PACIENTE(nome, dt_nascimento, cpf, nome_mae, dt_atualizacao) VALUES 
('Rafaela Costa', '1992-09-02', '24681357902', 'Carla Costa', '2021-08-30 07:01:23'),
('Leticia Ribeiro', '1987-12-24', '46813579204', 'Beatriz Ribeiro', '2020-08-14 10:20:11'),
('Rodrigo Mendes', '1974-03-08', '35792468103', 'Isabel Mendes', '2022-09-19 19:13:14'),
('Rodrigo Mendes', '1974-03-08', '35792468103', 'Isabel Mendes', '2022-10-02 17:35:35');


INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao FROM stg_hospital_a.PACIENTE;

INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao FROM stg_hospital_b.PACIENTE;

INSERT INTO stg_prontuario.PACIENTE (nome, dt_nascimento, cpf, nome_mae, dt_atualizacao)
SELECT nome, dt_nascimento, cpf, nome_mae, dt_atualizacao FROM stg_hospital_c.PACIENTE;


CREATE TABLE atendimento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  paciente_id INT,
  data_hora DATETIME,
  tipo VARCHAR(1),
  FOREIGN KEY (paciente_id) REFERENCES stg_prontuario.PACIENTE(id)
);

CREATE TABLE diagnostico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  atendimento_id INT,
  descricao VARCHAR(255),
  FOREIGN KEY (atendimento_id) REFERENCES atendimento(id)
);

INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (1, '2023-05-01 10:00:00', 'U');
INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (2, '2023-05-02 11:00:00', 'I');
INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (3, '2023-05-03 12:00:00', 'A');
INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (1, '2023-05-07 13:00:00', 'I');
INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (2, '2023-05-08 14:00:00', 'A');
INSERT INTO atendimento (paciente_id, data_hora, tipo) VALUES (3, '2023-05-09 15:00:00', 'U');

SELECT nome, dt_nascimento, cpf, nome_mae, COUNT(*) as total_ocorrencias
FROM stg_prontuario.PACIENTE
GROUP BY nome, dt_nascimento, cpf, nome_mae
HAVING COUNT(*) > 1;

SELECT DISTINCT p.*
FROM stg_prontuario.PACIENTE p
INNER JOIN (
  SELECT cpf, COUNT(*) AS duplicados
  FROM stg_prontuario.PACIENTE
  GROUP BY cpf
  HAVING COUNT(*) > 1
) d ON p.cpf = d.cpf;

SELECT nome, dt_nascimento, cpf, nome_mae, MAX(dt_atualizacao) as dt_atualizacao
FROM stg_prontuario.PACIENTE
WHERE cpf IN (
    SELECT cpf
    FROM stg_prontuario.PACIENTE
    GROUP BY cpf
    HAVING COUNT(*) > 1
)
GROUP BY nome, dt_nascimento, cpf, nome_mae;

SELECT COUNT(*)/(SELECT COUNT(*) FROM atendimento) AS media_U
FROM atendimento
WHERE tipo = 'U';
