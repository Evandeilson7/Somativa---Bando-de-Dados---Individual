DELIMITER $$

-- Tabela para armazenar os registros de inspeção de qualidade de produtos no MySQL
-- Esta tabela segue o modelo de dados descrito para o módulo de Controle de Qualidade.
CREATE TABLE Inspecao_Qualidade (
    ID_Inspecao INT PRIMARY KEY AUTO_INCREMENT, -- Chave primária com auto-incremento no MySQL
    Data_Inspecao DATE NOT NULL, -- Data em que a inspeção foi realizada
    Resultado_Inspecao VARCHAR(255) NOT NULL, -- Resultado da inspeção (Ex: 'Aprovado', 'Reprovado', 'Em Análise', 'Deteriorado')
    Observacoes TEXT, -- Campo opcional para detalhes adicionais ou comentários sobre a inspeção
    FK_ID_Produto INT, -- Chave estrangeira referenciando a tabela 'Produto'
    -- Assume que existe uma tabela 'Produto' com uma coluna 'ID_Produto' que é a chave primária.
    FOREIGN KEY (FK_ID_Produto) REFERENCES Produto(ID_Produto)
    -- O comportamento ON DELETE/ON UPDATE pode ser adicionado aqui se necessário (Ex: ON DELETE CASCADE)
) $$

-- Procedimento armazenado para registrar uma nova inspeção de qualidade para um produto no MySQL
-- Este procedimento simplifica a inserção de dados na tabela Inspecao_Qualidade.
CREATE PROCEDURE RegistrarInspecaoProduto (
    IN p_id_produto INT,
    IN p_data_inspecao DATE,
    IN p_resultado VARCHAR(255),
    IN p_observacoes TEXT
)
BEGIN
    -- Insere um novo registro na tabela Inspecao_Qualidade
    INSERT INTO Inspecao_Qualidade (FK_ID_Produto, Data_Inspecao, Resultado_Inspecao, Observacoes)
    VALUES (p_id_produto, p_data_inspecao, p_resultado, p_observacoes);
END $$

-- Exemplo de como chamar o procedimento para registrar uma inspeção no MySQL:
-- Suponha que você queira registrar uma inspeção para o Produto com ID 101.
-- CALL RegistrarInspecaoProduto(101, CURDATE(), 'Aprovado', 'Embalagem intacta e produto conforme especificação.');

-- Exemplo de consulta para ver todas as inspeções de um produto específico (Ex: Produto com ID 101):
-- SELECT * FROM Inspecao_Qualidade WHERE FK_ID_Produto = 101;

DELIMITER ;
