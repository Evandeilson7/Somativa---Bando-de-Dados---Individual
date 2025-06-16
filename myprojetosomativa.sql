DELIMITER $$

-- Procedimento armazenado para consultar o histórico de inspeções de um produto específico
-- Retorna todos os registros da tabela Inspecao_Qualidade associados a um determinado Produto ID.
CREATE PROCEDURE ConsultarHistoricoInspecaoProduto (
    IN p_id_produto INT
)
BEGIN
    -- Seleciona todos os campos da tabela Inspecao_Qualidade
    -- Onde a chave estrangeira FK_ID_Produto corresponde ao ID do produto fornecido.
    SELECT
        ID_Inspecao,
        Data_Inspecao,
        Resultado_Inspecao,
        Observacoes,
        FK_ID_Produto
    FROM
        Inspecao_Qualidade
    WHERE
        FK_ID_Produto = p_id_produto
    ORDER BY
        Data_Inspecao DESC; -- Ordena os resultados pela data de inspeção mais recente primeiro
END $$

-- Exemplo de como chamar o procedimento para consultar o histórico de inspeções de um produto:
-- Suponha que você queira ver o histórico de inspeções para o Produto com ID 101.
-- CALL ConsultarHistoricoInspecaoProduto(101);

DELIMITER ;
