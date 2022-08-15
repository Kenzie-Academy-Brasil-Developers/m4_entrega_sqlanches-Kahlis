-- Aqui você deve colocar os códigos SQL referentes às
-- Seleções de dados

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
	produtos produto ON produto.id = at.produto_id;

-- 2)
SELECT pedido_id FROM produtos_pedidos WHERE produto_id = 6;

-- 3)
SELECT 
	cliente.nome gostam_de_fritas
FROM 
	produtos_pedidos at
JOIN
	pedidos pedido ON pedido.id = at.pedido_id
JOIN
	clientes cliente ON cliente.id = pedido.cliente_id
WHERE
	produto_id = 6;

-- 4)
SELECT 
	SUM(produto.preço)
FROM 
	produtos_pedidos at
JOIN
	produtos produto ON produto.id = at.produto_id
JOIN
	pedidos pedido ON pedido.id = at.pedido_id
JOIN
	clientes cliente ON cliente.id = pedido.cliente_id
WHERE
	cliente.id = 5;
    
SELECT * FROM pedidos;

-- 5)
SELECT 
	nome,
    quantidade
FROM
(
	SELECT
      	produto.nome,
      	(SELECT COUNT(*) FROM produtos_pedidos WHERE produto_id = produto.id) quantidade,
		COUNT(*) OVER (PARTITION BY produto.nome) AS cnt
	FROM
		produtos_pedidos at
	JOIN
		produtos produto ON produto.id = at.produto_id
) as p
GROUP BY nome, quantidade;
