-- Aqui você deve colocar os códigos SQL referentes às
-- Simulações de um CRUD

-- Criação

-- 1)
INSERT INTO clientes
	(nome, lealdade)
VALUES
	('Georgia', 0);


-- 2)
INSERT INTO pedidos
	(status, cliente_id)
VALUES
	('Recebido', currval('clientes_id_seq'));

-- 3)
INSERT INTO produtos_pedidos
	(pedido_id, produto_id)
VALUES
	(currval('pedidos_id_seq'), 1),
	(currval('pedidos_id_seq'), 2),
	(currval('pedidos_id_seq'), 6),
	(currval('pedidos_id_seq'), 8),
	(currval('pedidos_id_seq'), 8);

-- Leitura

-- 1)
SELECT 
	pedido.id,
	pedido.status,
    pedido.cliente_id,
    produto.id,
    produto.nome,
    produto.tipo,
    produto.preço,
    produto.pts_de_lealdade
FROM
	produtos_pedidos at
JOIN
	pedidos pedido ON pedido.id = at.pedido_id
JOIN
	produtos produto ON produto.id = at.produto_id
WHERE
	pedido.cliente_id = 12;



-- Atualização

-- 1)
UPDATE 
	clientes
SET 
	lealdade=
    (
		SELECT
      		SUM(produto.pts_de_lealdade)
      	FROM
      		produtos_pedidos at
      	JOIN 
    		produtos produto ON produto.id = at.produto_id
		JOIN
			pedidos pedido ON pedido.id = at.pedido_id
        WHERE
            pedido.cliente_id = 12
	)
WHERE
	clientes.id = 12;
	
-- Deleção

-- 1)
DELETE FROM clientes WHERE clientes.id = 4;

