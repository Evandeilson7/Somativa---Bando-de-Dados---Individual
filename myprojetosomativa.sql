DELIMITER $$

-- Procedimento original para inserir carros (do seu arquivo)
CREATE PROCEDURE InserirCarro (
    IN p_id INT,
    IN p_marca VARCHAR(100),
    IN p_modelo VARCHAR(100),
    IN p_ano INT,
    IN p_valor DECIMAL(10,2),
    IN p_cor VARCHAR(100),
    IN p_numero_vendas INT
)
BEGIN
    INSERT INTO carros (id, marca, modelo, ano, valor, cor, numero_vendas)
    VALUES (p_id, p_marca, p_modelo, p_ano, p_valor, p_cor, p_numero_vendas);
END $$

-- Nova tabela para Controle de Qualidade de Carros, adaptada do conceito E-LogiWare
-- Esta tabela armazena os resultados das inspeções para cada carro.
CREATE TABLE Inspecao_Qualidade_Carro (
    ID_Inspecao_Carro INT PRIMARY KEY AUTO_INCREMENT, -- Chave primária com auto-incremento (assumindo MySQL/MariaDB)
    Data_Inspecao DATE NOT NULL, -- Data em que a inspeção foi realizada
    Resultado_Inspecao VARCHAR(255) NOT NULL, -- Resultado da inspeção (Ex: 'Aprovado', 'Reprovado', 'Requer Reparo')
    Observacoes TEXT, -- Campo para detalhes adicionais ou comentários sobre a inspeção
    FK_ID_Carro INT, -- Chave estrangeira referenciando a tabela 'carros'
    FOREIGN KEY (FK_ID_Carro) REFERENCES carros(id) -- Define o relacionamento com a tabela de carros
) $$

-- Novo procedimento armazenado para registrar uma inspeção de qualidade de carro
-- Facilita a inserção de novos registros na tabela Inspecao_Qualidade_Carro.
CREATE PROCEDURE RegistrarInspecaoCarro (
    IN p_id_carro INT,
    IN p_data_inspecao DATE,
    IN p_resultado VARCHAR(255),
    IN p_observacoes TEXT
)
BEGIN
    INSERT INTO Inspecao_Qualidade_Carro (FK_ID_Carro, Data_Inspecao, Resultado_Inspecao, Observacoes)
    VALUES (p_id_carro, p_data_inspecao, p_resultado, p_observacoes);
END $$

DELIMITER ;

-- Chamadas e consultas originais do arquivo fornecido:

-- Exemplo de chamada para inserir um carro (mantido do seu arquivo)
-- Note: A chamada original tem 'uno' como marca e 'Corolla' como modelo, e '15' como string para ID. Ajuste conforme necessário para seu banco de dados e schema.
CALL InserirCarro('15', 'uno', 'Corolla', '2021', '95000.00', 'Branco', '50');

-- Adicionando outro exemplo de inserção para melhor clareza
CALL InserirCarro(16, 'Fiat', 'Uno', 2020, 45000.00, 'Vermelho', 30);

-- Consulta original para ver os carros
SELECT * FROM carros;

-- Exemplo de chamada para o novo procedimento de registro de inspeção
-- Assume que o carro com ID 15 existe após a inserção anterior.
CALL RegistrarInspecaoCarro(15, CURDATE(), 'Aprovado', 'Inspeção visual e mecânica básica OK.');

-- Chamadas e consultas adicionais do arquivo original (podem depender de outras partes do schema não fornecidas e podem causar erros se não existirem):
-- CALL AtualizarValorCarro(1, 8000000); -- Este procedimento não está definido neste script.
-- call carrosbd.InserirCarro(car, 'ferrare', 'spyder', 2025, 8000000, 'black', 1); -- Esta sintaxe parece incorreta e depende de um schema 'carrosbd' não definido.
-- SELECT * FROM tb_carros; -- Esta tabela não está definida neste script.
-- SELECT * FROM historico_preco; -- Esta tabela não está definida neste script.

-- Consulta para ver os registros de inspeção de qualidade que foram adicionados
SELECT * FROM Inspecao_Qualidade_Carro;
