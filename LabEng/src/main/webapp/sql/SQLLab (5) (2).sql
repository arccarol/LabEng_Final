USE master
GO 
DROP DATABASE CrudEstoque

CREATE DATABASE CrudEstoque
GO
USE CrudEstoque

CREATE TABLE Produto (
    codigo INT PRIMARY KEY,
    nome VARCHAR(255),
	marca VARCHAR(30),
    validade DATE,
    descricao TEXT,
    valorUnit DECIMAL(10, 2),
    teorAlcoolico DECIMAL(5, 2),
    quantidade INT
);
GO
CREATE  PROCEDURE GerenciarProduto (
    @op VARCHAR(10),
	@codigo INT,
    @nome VARCHAR(100),
	@marca VARCHAR(30),
    @validade DATE,
    @descricao VARCHAR(200),
    @valorUnit DECIMAL(10, 2),
    @teorAlcoolico DECIMAL(5, 2),
    @quantidade INT,
    @saida VARCHAR(100) OUTPUT
)
AS
BEGIN

    IF @op = 'I' 
    BEGIN
         IF @codigo IS NOT NULL AND @nome IS NOT NULL AND @validade IS NOT NULL AND @valorUnit IS NOT NULL AND @quantidade IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Produto WHERE nome = @nome AND marca = @marca)
            BEGIN
                INSERT INTO Produto ( codigo, nome, marca, validade, descricao, valorUnit, teorAlcoolico, quantidade)
                VALUES ( @codigo, @nome, @marca, @validade, @descricao, @valorUnit, @teorAlcoolico, @quantidade);
                
                SET @saida = 'Produto inserido com sucesso.';
            END
            ELSE
            BEGIN
                SET @saida = 'O código do produto já existe na base de dados.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para inserção.';
        END
    END
    ELSE IF @op = 'U' 
    BEGIN
        IF @codigo IS NOT NULL AND @nome IS NOT NULL AND @validade IS NOT NULL AND @valorUnit IS NOT NULL AND @quantidade IS NOT NULL
        BEGIN
            IF EXISTS (SELECT 1 FROM Produto WHERE codigo = @codigo)
            BEGIN
                UPDATE Produto
                SET nome = @nome,
                    validade = @validade,
					marca = @marca,
                    descricao = @descricao,
                    valorUnit = @valorUnit,
                    teorAlcoolico = @teorAlcoolico,
                    quantidade = @quantidade
                WHERE codigo = @codigo;

                SET @saida = 'Produto atualizado com sucesso.';
            END
            ELSE
            BEGIN
                SET @saida = 'O código do produto não foi encontrado na base de dados.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para atualização.';
        END
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
    END
END;


GO
CREATE FUNCTION fnProdutos ()
RETURNS TABLE
AS
RETURN
(
    SELECT
        codigo,
        nome,
		marca,
        validade,
        descricao,
        valorUnit,
        teorAlcoolico,
        quantidade
    FROM
        Produto
);


GO
CREATE TABLE Itens(
    codigo INT IDENTITY(1,1) PRIMARY KEY,
    produto INT,
    FOREIGN KEY(produto) REFERENCES Produto(codigo)
)
GO
CREATE PROCEDURE GerenciarItens (
    @op VARCHAR(10),
    @produto INT,
    @saida VARCHAR(100) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @op = 'I'
    BEGIN
        IF @produto IS NOT NULL
        BEGIN
            -- Verifica se o produto existe na tabela Produto
            IF EXISTS (SELECT 1 FROM Produto WHERE codigo = @produto)
            BEGIN
                -- Verifica se o produto já foi inserido na tabela Itens
                IF NOT EXISTS (SELECT 1 FROM Itens WHERE produto = @produto)
                BEGIN
                    -- Insere o item na tabela Itens
                    INSERT INTO Itens (produto)
                    VALUES (@produto);

                    SET @saida = 'Item adicionado com sucesso.';
                END
                ELSE
                BEGIN
                    SET @saida = 'Este produto já foi adicionado anteriormente.';
                END
            END
            ELSE
            BEGIN
                SET @saida = 'O produto especificado não existe na base de dados.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para inserção.';
        END
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
    END
END;

GO
CREATE FUNCTION fnItens (
    @nome VARCHAR(100),
    @marca VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        codigo,
        nome,
        marca,
        valorUnit
    FROM
        Produto
    WHERE
        codigo = @nome AND
        marca = @marca
);

GO
CREATE TABLE Pedido (
    codigo INT,
    produto INT,
    quantidade INT,
	status_p VARCHAR(30)
	FOREIGN KEY (produto) REFERENCES Produto(codigo)
);
GO
CREATE PROCEDURE GerenciarPedido (
    @op VARCHAR(10),
    @codigo INT,
    @produto INT,
    @quantidade INT,
    @saida VARCHAR(100) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @op = 'I'
    BEGIN
        IF @produto IS NOT NULL AND @quantidade IS NOT NULL
        BEGIN
            IF @quantidade > 0
            BEGIN
                -- Verifica se o produto existe na tabela Produto
                IF EXISTS (SELECT 1 FROM Produto WHERE codigo = @produto)
                BEGIN
                    -- Insere o pedido na tabela Pedido com o status 'esperando venda'
                    INSERT INTO Pedido (codigo, produto, quantidade, status_p)
                    VALUES (@codigo, @produto, @quantidade, 'Esperando Venda');

                    SET @saida = 'Pedido adicionado com sucesso.';
                END
                ELSE
                BEGIN
                    SET @saida = 'O produto especificado não existe na base de dados.';
                END
            END
            ELSE
            BEGIN
                SET @saida = 'Pedido adicionado com sucesso.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para inserção.';
        END
    END
    ELSE IF @op = 'D'
    BEGIN
        IF @codigo IS NOT NULL
        BEGIN
            -- Verifica se o pedido existe na tabela Pedido
            IF EXISTS (SELECT 1 FROM Itens WHERE produto = @produto)
            BEGIN
                -- Exclui o pedido da tabela Pedido
                DELETE FROM Itens
                WHERE produto = @produto;

                SET @saida = 'Pedido excluído com sucesso.';
            END
            ELSE
            BEGIN
                SET @saida = 'O pedido especificado não existe na base de dados.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para exclusão.';
        END
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
    END
END;
GO
CREATE FUNCTION fnPedidos ()
RETURNS TABLE
AS
RETURN
(
    SELECT
        i.produto AS produto,
        p.nome,
        p.marca
    FROM
        Produto p
    INNER JOIN Itens i ON i.produto = p.codigo
);
GO
CREATE FUNCTION fnPedidosI ()
RETURNS TABLE
AS
RETURN
(
    SELECT
        Pe.codigo,
        Pe.produto,
        p.nome AS nomeProduto,
        p.marca AS marcaProduto,
        p.valorUnit AS valorProduto,
        Pe.quantidade,
        Pe.status_p AS status_p
    FROM
        Pedido Pe
    INNER JOIN Produto p ON Pe.produto = p.codigo
);
   
GO
CREATE TABLE Venda (
    pedido INT,
	reserva INT,
	data_v VARCHAR(20),
    quantidade INT,
	valorTotal DECIMAL(10, 2),
);
GO
CREATE FUNCTION fnVendaP ()
RETURNS TABLE
AS
RETURN
(
    SELECT
        Pe.codigo AS codigoPedido,
        P.codigo AS codigoProduto,
        p.nome AS nomeProduto,
        p.marca AS marcaProduto,
        p.valorUnit AS valorProduto,
        Pe.quantidade AS quantidadeProduto,
        Pe.quantidade * p.valorUnit AS valorTotal  
    FROM
        Pedido Pe
    INNER JOIN Produto p ON Pe.produto = p.codigo
	WHERE Pe.status_p = 'Esperando Venda'
);

GO
CREATE PROCEDURE GerenciarVenda (
    @op VARCHAR(10),
    @pedido INT,
    @saida VARCHAR(100) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF @op = 'I'
        BEGIN
            DECLARE @data_v VARCHAR(20) = CONVERT(VARCHAR(20), GETDATE(), 120); 
            DECLARE @quantidade INT;
            DECLARE @valorTotal DECIMAL(10, 2);

            -- Verifica se o pedido existe e está com status 'Esperando Venda'
            IF EXISTS (SELECT 1 FROM Pedido WHERE codigo = @pedido AND status_p = 'Esperando Venda')
            BEGIN
                -- Verifica se o pedido já foi vendido (existe na tabela Venda)
                IF NOT EXISTS (SELECT 1 FROM Venda WHERE pedido = @pedido)
                BEGIN
                    -- Verifica se há produtos no pedido com quantidade zero no estoque
                    IF EXISTS (SELECT p.quantidade FROM Produto p
                               INNER JOIN Pedido pi ON p.codigo = pi.produto
                               WHERE pi.codigo = @pedido AND p.quantidade = 0)
                    BEGIN
                        SET @saida = 'Não é possível vender o pedido. Alguns produtos estão esgotados. Reabasteça o estoque imediatamente.';
                    END
                    ELSE
                    BEGIN
                        -- Verifica se a quantidade do produto é suficiente para a venda
                        IF NOT EXISTS (SELECT p.quantidade
                                       FROM Produto p
                                       INNER JOIN Pedido pi ON p.codigo = pi.produto
                                       WHERE pi.codigo = @pedido AND p.quantidade < pi.quantidade)
                        BEGIN
                            -- Consulta para obter a quantidade de produtos no pedido
                            SELECT @quantidade = SUM(quantidade)
                            FROM Pedido
                            WHERE codigo = @pedido;

                            -- Consulta para obter o valor total do pedido
                            SELECT @valorTotal = SUM(p.valorUnit * pi.quantidade)
                            FROM Pedido pi
                            INNER JOIN Produto p ON pi.produto = p.codigo
                            WHERE pi.codigo = @pedido;

                            -- Atualiza o status do pedido para 'Vendido'
                            UPDATE Pedido SET status_p = 'Vendido' WHERE codigo = @pedido;

                            -- Insere na tabela Venda
                            INSERT INTO Venda (pedido, data_v, quantidade, valorTotal)
                            VALUES (@pedido, @data_v, @quantidade, @valorTotal);

                            -- Subtrai a quantidade vendida do estoque dos produtos
                            UPDATE Produto
                            SET quantidade = p.quantidade - pi.quantidade
                            FROM Produto p
                            INNER JOIN Pedido pi ON p.codigo = pi.produto
                            WHERE p.codigo = pi.produto AND pi.codigo = @pedido;

                            -- Remove todos os itens relacionados ao pedido da tabela Itens
                            DELETE FROM Itens WHERE produto IN (
                                SELECT produto FROM Pedido WHERE codigo = @pedido
                            );

                            -- Verifica o estoque após a venda e define a mensagem apropriada
                             IF EXISTS (SELECT p.quantidade FROM Produto p
                               INNER JOIN Pedido pi ON p.codigo = pi.produto
                               WHERE pi.codigo = @pedido AND p.quantidade <= 10)
                            BEGIN
                                SET @saida = 'Pedido vendido com sucesso. Alguns produtos estão com estoque baixo. Reabasteça o estoque.';
                            END
                            ELSE
                            BEGIN
                                SET @saida = 'Pedido vendido com sucesso.';
                            END
                        END
                        ELSE
                        BEGIN
                            -- Define a saída de erro
                            SET @saida = 'Não é possível vender. A quantidade de algum produto na reserva é maior do que a quantidade disponível no estoque.';
                        END
                    END
                END
                ELSE
                BEGIN
                    -- Define a saída de erro
                    SET @saida = 'Pedido já foi vendido anteriormente.';
                END
            END
            ELSE
            BEGIN
                -- Define a saída de erro
                SET @saida = 'Pedido não encontrado ou não está pendente de venda.';
            END
        END
        ELSE IF @op = 'D'
        BEGIN
            -- Verifica se o pedido existe e está com status diferente de 'Não Requerido'
            IF EXISTS (SELECT 1 FROM Pedido WHERE codigo = @pedido AND status_p <> 'Não Requerido')
            BEGIN
                -- Atualiza o status do pedido para 'Não Requerido'
                UPDATE Pedido SET status_p = 'Não Requerido' WHERE codigo = @pedido;

                -- Remove os itens relacionados ao pedido da tabela Itens
                DELETE FROM Itens
                WHERE produto IN (SELECT produto FROM Pedido WHERE codigo = @pedido);

                -- Define a saída de sucesso
                SET @saida = 'Pedido marcado como não requerido com sucesso.';
            END
            ELSE
            BEGIN
                -- Define a saída de erro
                SET @saida = 'Pedido não encontrado ou já está marcado como não requerido.';
            END
        END
        ELSE
        BEGIN
            -- Define a saída de erro para operação inválida
            SET @saida = 'Operação inválida. Utilize apenas "I" para inserção ou "D" para desistência.';
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @saida = 'Erro na operação: ' + ERROR_MESSAGE();
    END CATCH
END;


GO
CREATE FUNCTION fnVendasI ()
RETURNS TABLE
AS
RETURN
(
     SELECT DISTINCT
        v.pedido AS pedido,
		v.quantidade AS quantidadeTotal,
		v.valorTotal AS valorTotal,
		v.data_v AS data_v
    FROM
        Venda v
	INNER JOIN pedido p ON p.codigo = v.pedido
	WHERE p.status_p = 'Vendido'
	
);
GO
CREATE TABLE Reserva (
    codigo INT,
    data_reserva DATE,
    data_limite DATE,
    produto INT,
    quantidade INT,
    status_r VARCHAR(20),
    FOREIGN KEY (produto) REFERENCES Produto(codigo)
);

GO
CREATE PROCEDURE InserirReserva
    @op VARCHAR(10),
    @codigo INT,
    @produto INT,
    @quantidade INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @op = 'I'
    BEGIN
        IF @produto IS NOT NULL AND @quantidade IS NOT NULL
        BEGIN
            IF @quantidade > 0
            BEGIN
                -- Verifica se o produto existe na tabela Produto
                IF EXISTS (SELECT 1 FROM Produto WHERE codigo = @produto)
                BEGIN
                    DECLARE @data_reserva DATE;
                    DECLARE @data_limite DATE;
                    DECLARE @status_r VARCHAR(20);

                    -- Definir a data de reserva como a data atual
                    SET @data_reserva = GETDATE();
                    -- Definir a data limite como um dia após a data atual
                    SET @data_limite = DATEADD(DAY, 1, @data_reserva);
                    -- Definir o status como "Reservado"
                    SET @status_r = 'Reservado';

                    -- Insere a reserva na tabela Reserva
                    INSERT INTO Reserva (codigo, data_reserva, data_limite, produto, quantidade, status_r)
                    VALUES (@codigo, @data_reserva, @data_limite, @produto, @quantidade, @status_r);

                    SET @saida = 'Reserva inserida com sucesso.';
                END
                ELSE
                BEGIN
                    SET @saida = 'O produto especificado não existe na base de dados.';
                END
            END
            ELSE
            BEGIN
                SET @saida = 'Reserva inserida com sucesso.';
            END
        END
        ELSE
        BEGIN
            SET @saida = 'Parâmetros incompletos para inserção.';
        END
    END
    ELSE
    BEGIN
        SET @saida = 'Operação inválida.';
    END
END;

GO
CREATE PROCEDURE ListarReservas
    @opcao CHAR(1) = NULL
AS
BEGIN
    -- Se a opção for "L", atualiza o status das reservas cuja data limite já passou para 'Cancelada'
    IF @opcao = 'L'
    BEGIN
        UPDATE Reserva
        SET status_r = 'Cancelada'
        WHERE data_limite < GETDATE() AND status_r = 'Reservado';
    END;

    -- Seleciona as reservas do dia atual
    SELECT 
        R.codigo AS codigo_reserva,
        R.data_reserva,
        R.data_limite,
        P.nome AS nome_produto,
        R.quantidade,
        R.status_r AS status_reserva
    FROM 
        Reserva R
    INNER JOIN 
        Produto P ON R.produto = P.codigo
    WHERE 
        R.data_reserva = CONVERT(DATE, GETDATE());
END;

GO
 CREATE FUNCTION fnVendaR ()
RETURNS TABLE
AS
RETURN
(
    SELECT
        R.codigo AS codigoReserva,
        P.codigo AS codigoProduto,
        p.nome AS nomeProduto,
        p.marca AS marcaProduto,
        p.valorUnit AS valorProduto,
        R.quantidade AS quantidadeProduto,
        R.quantidade * p.valorUnit AS valorTotal  
    FROM
        Reserva R
    INNER JOIN Produto p ON R.produto = p.codigo
	WHERE R.status_r = 'Reservado'
);

GO
CREATE PROCEDURE GerenciarVendaR (
    @op VARCHAR(10),
    @reserva INT,
    @saida VARCHAR(100) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @op = 'I'
        BEGIN
            DECLARE @data_r VARCHAR(20) = CONVERT(VARCHAR(20), GETDATE(), 120);
            DECLARE @quantidade INT;
            DECLARE @valorTotal DECIMAL(10, 2);

            -- Verifica se a reserva existe e está com status 'Reservado'
            IF EXISTS (SELECT 1 FROM Reserva WHERE codigo = @reserva AND status_r = 'Reservado')
            BEGIN
                -- Verifica se a reserva já foi vendida
                IF NOT EXISTS (SELECT 1 FROM Venda WHERE reserva = @reserva)
                BEGIN
                    -- Verifica se há produtos na reserva com quantidade zero no estoque
                    IF EXISTS (SELECT p.quantidade FROM Produto p
                               INNER JOIN Reserva r ON p.codigo = r.produto
                               WHERE r.codigo = @reserva AND p.quantidade = 0)
                    BEGIN
                        SET @saida = 'Não é possível vender o pedido. Alguns produtos estão esgotados. Reabasteça o estoque imediatamente.';
                    END
                    ELSE
                    BEGIN
                        -- Verifica se a quantidade do produto é suficiente para a venda
                        IF EXISTS (SELECT p.quantidade
                                   FROM Produto p
                                   INNER JOIN Reserva r ON p.codigo = r.produto
                                   WHERE r.codigo = @reserva AND p.quantidade >= r.quantidade)
                        BEGIN
                            -- Obtém a quantidade total de produtos na reserva
                            SELECT @quantidade = SUM(quantidade)
                            FROM Reserva
                            WHERE codigo = @reserva;

                            -- Obtém o valor total da reserva
                            SELECT @valorTotal = SUM(p.valorUnit * r.quantidade)
                            FROM Reserva r
                            INNER JOIN Produto p ON r.produto = p.codigo
                            WHERE r.codigo = @reserva;

                            -- Atualiza o status da reserva para 'Vendido'
                            UPDATE Reserva SET status_r = 'Vendido' WHERE codigo = @reserva;

                            -- Insere a reserva na tabela Venda
                            INSERT INTO Venda (reserva, data_v, quantidade, valorTotal)
                            VALUES (@reserva, @data_r, @quantidade, @valorTotal);

                            -- Atualiza a quantidade de produtos no estoque
                            UPDATE Produto
                            SET quantidade = p.quantidade - r.quantidade
                            FROM Produto p
                            INNER JOIN Reserva r ON p.codigo = r.produto
                            WHERE r.codigo = @reserva;

                            -- Remove os itens relacionados à reserva da tabela Itens
                            DELETE FROM Itens
                            WHERE produto IN (SELECT produto FROM Reserva WHERE codigo = @reserva);

                            -- Verifica o estoque após a venda e define a mensagem apropriada
                             IF EXISTS (SELECT p.quantidade FROM Produto p
                               INNER JOIN Reserva r ON p.codigo = r.produto
                               WHERE r.codigo = @reserva AND p.quantidade <= 10)
                            BEGIN
                                SET @saida = 'Pedido vendido com sucesso. Alguns produtos estão com estoque baixo. Reabasteça o estoque.';
                            END
                            ELSE
                            BEGIN
                                SET @saida = 'Pedido vendido com sucesso.';
                            END
                        END
                        ELSE
                        BEGIN
                            -- Define a saída de erro
                            SET @saida = 'Não é possível vender. A quantidade de algum produto na reserva é maior do que a quantidade disponível no estoque.';
                        END
                    END
                END
                ELSE
                BEGIN
                    -- Define a saída de erro
                    SET @saida = 'Pedido já foi vendido anteriormente.';
                END
            END
            ELSE
            BEGIN
                -- Define a saída de erro
                SET @saida = 'Pedido não encontrado ou não está reservado.';
            END
        END
        ELSE IF @op = 'D'
        BEGIN
            -- Verifica se a reserva existe e está com status diferente de 'Não Requerido'
            IF EXISTS (SELECT 1 FROM Reserva WHERE codigo = @reserva AND status_r <> 'Não Requerido')
            BEGIN
                -- Atualiza o status da reserva para 'Não Requerido'
                UPDATE Reserva SET status_r = 'Não Requerido' WHERE codigo = @reserva;

                -- Remove os itens relacionados à reserva da tabela Itens
                DELETE FROM Itens
                WHERE produto IN (SELECT produto FROM Reserva WHERE codigo = @reserva);

                -- Define a saída de sucesso
                SET @saida = 'Pedido marcado como não requerido com sucesso.';
            END
            ELSE
            BEGIN
                -- Define a saída de erro
                SET @saida = 'Pedido não encontrado ou já está marcado como não requerido.';
            END
        END
        ELSE
        BEGIN
            -- Define a saída de erro para operação inválida
            SET @saida = 'Operação inválida. Utilize apenas "I" para inserção ou "D" para desistência.';
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @saida = 'Erro na operação: ' + ERROR_MESSAGE();
    END CATCH
END;

GO
CREATE FUNCTION fnVendasIR ()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT
        v.reserva AS reserva,
        v.quantidade AS quantidadeTotalr,
        v.valorTotal AS valorTotalr,
        v.data_v AS data_vr
    FROM
        Venda v
    INNER JOIN Reserva r ON r.codigo = v.reserva
    WHERE
        r.status_r = 'Vendido'
);


INSERT INTO Produto VALUES
(1, 'Cerveja Pilsen', 'Marca A', '2024-12-31', 'Cerveja leve e refrescante.', 3.50, 4.7, 100),
(2, 'Vinho Tinto', 'Marca B', '2025-06-30', 'Vinho tinto seco com sabor encorpado.', 25.00, 12.5, 50),
(3, 'Whisky 12 Anos', 'Marca C', '2030-01-01', 'Whisky envelhecido por 12 anos.', 120.00, 40.0, 20),
(4, 'Vodka', 'Marca D', '2028-05-20', 'Vodka pura e cristalina.', 45.00, 40.0, 75),
(5, 'Rum', 'Marca E', '2027-11-15', 'Rum caribenho de alta qualidade.', 35.00, 38.0, 60),
(6, 'Tequila', 'Marca F', '2029-09-10', 'Tequila autêntica mexicana.', 50.00, 40.0, 30),
(7, 'Gin', 'Marca G', '2026-03-25', 'Gin premium com botânicos.', 70.00, 37.5, 45),
(8, 'Cachaça', 'Marca H', '2025-12-31', 'Cachaça artesanal.', 15.00, 39.0, 200),
(9, 'Licor de Chocolate', 'Marca I', '2024-08-15', 'Licor de chocolate cremoso.', 20.00, 17.0, 80),
(10, 'Espumante', 'Marca J', '2026-12-25', 'Espumante brut.', 60.00, 12.0, 40);

EXEC ListarReservas @opcao = 'L';

   select * from pedido
   select * from itens
   select * from Produto
   select * from venda
   select * from reserva