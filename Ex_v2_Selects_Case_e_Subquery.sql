-- Consulta do ID, ano e nome dos filmes cujos DVDs foram fabricados
-- após 01/01/2020. Caso o título tenha mais de 10 caracteres,
-- mostra apenas os 10 primeiros seguidos de reticências
SELECT
	id,
	ano,
	CASE
		WHEN LEN(titulo) > 10
			THEN SUBSTRING(titulo,1,10) + '...'
		ELSE titulo
	END AS tilulo
FROM filme
WHERE id IN
	(
		SELECT filmeid
		FROM dvd
		WHERE data_fabricacao > '2020-01-01'
	)

-- Consulta do número do DVD, data de fabricação e quantidade de meses
-- desde a fabricação até a data atual, do filme Interestelar
SELECT 
	num,
	data_fabricacao,
	DATEDIFF(MONTH, data_fabricacao, GETDATE()) AS qtd_meses_desde_fabricacao
FROM dvd
WHERE filmeid IN
	(
		SELECT filmeid
		FROM filme
		WHERE titulo = 'Interestelar'
	)
	
-- Consulta do número do DVD, data de locação, data de devolução,
-- total de dias alugado e valor das locações da cliente
-- que possui o termo 'Rosa' no nome
SELECT 
	dvdnum,
	data_locacao,
	data_devolucao,
	DATEDIFF(DAY, data_locacao, data_devolucao) AS dias_alugado,
	valor
FROM locacao
	WHERE clientenum_cadastro IN
		(
			SELECT num_cadastro
			FROM cliente
			WHERE nome LIKE '%Rosa%'
		)

-- Consulta do nome, endereço completo e CEP formatado
-- dos clientes que alugaram o DVD de número 10002
SELECT 
	nome,
	logradouro + ' ' +  CAST(num AS VARCHAR(5)) AS endereco_completo,
	SUBSTRING(cep,1,5) + '-' + SUBSTRING(cep,6,3) AS cep
FROM cliente
	WHERE num_cadastro IN
		(
			SELECT clientenum_cadastro
			FROM locacao
				WHERE dvdnum = 10002
		)