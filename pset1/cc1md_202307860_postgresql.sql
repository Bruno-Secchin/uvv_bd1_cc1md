/* Script SQL da criação do banco de dados "Lojas UVV" no postgresql, referente ao PSET1.
    Bruno Secchin Telles    CC1MD */

    /* Criando usuário com senha e atribuindo-lhe as devidas permissões. */
        -- Deletando o banco de dados "uvv" e o usuário "bruno", caso já existam:
            DROP DATABASE IF EXISTS uvv;
            DROP USER IF EXISTS bruno;

        CREATE USER bruno 
        WITH 
        createdb 
        createrole 
        encrypted password '123ibitirui';

    /* Criando o banco de dados e suas configurações. */
        CREATE DATABASE uvv 
        WITH 
        owner =             bruno
        encoding =          "UTF8"
        lc_collate =        'pt_BR.UTF-8'
        lc_ctype =          'pt_BR.UTF-8'
        allow_connections = TRUE;

        -- Inserindo comentário:
            COMMENT ON DATABASE uvv
            IS 'Banco de dados que contém os projetos realizados durante minha vida acadêmica.';

        -- Me conectando ao usuário e ao banco de dados criados.
            \setenv PGPASSWORD 123ibitirui
            \c uvv bruno;
    /* Criando um esquema dentro do banco de dados. */
        CREATE SCHEMA IF NOT EXISTS lojas
        AUTHORIZATION bruno;

        -- Inserindo comentário:
            COMMENT ON SCHEMA lojas
            IS 'Esquema referente ao projeto Lojas UVV, desenvolvido durante a realização do PSET1.';

        -- O definindo como caminho principal:
            SET SEARCH_PATH TO lojas, "$user", public;
            
            ALTER USER bruno
            SET SEARCH_PATH TO lojas, "$user", public;
    /* Criação das tabelas. */
        /* Criando a tabela "clientes", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE clientes (
                cliente_id      NUMERIC(38)  NOT NULL,
                email           VARCHAR(255) NOT NULL,
                nome            VARCHAR(255) NOT NULL,
                telefone1       VARCHAR(20),
                telefone2       VARCHAR(20),
                telefone3       VARCHAR(20),

                -- Definindo a PK:
                    CONSTRAINT pk_clientes      
                    PRIMARY KEY (cliente_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE clientes
                IS 'Tabela referente aos dados do cliente, tais como, seu código, seu email, nome e telefones.';

            -- Comentários das colunas:
                COMMENT ON COLUMN clientes.cliente_id 
                IS 'Apresenta a chave primária da tabela clientes, funciona como identificador de cada cliente.';

                COMMENT ON COLUMN clientes.email 
                IS 'Apresenta o email do cliente.';

                COMMENT ON COLUMN clientes.nome 
                IS 'Apresenta o nome do cliente.';

                COMMENT ON COLUMN clientes.telefone1 
                IS 'Apresenta o primeiro telefone do cliente.';

                COMMENT ON COLUMN clientes.telefone2 
                IS 'Apresenta o segundo telefone do cliente.';

                COMMENT ON COLUMN clientes.telefone3 
                IS 'Apresenta o terceiro telefone do cliente.';

        /* Criando a tabela "produtos", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE produtos (
                produto_id                  NUMERIC(38)    NOT NULL,
                nome                        VARCHAR(255)   NOT NULL,
                preco_unitario              NUMERIC(10,2),
                detalhes                    BYTEA,
                imagem                      BYTEA,
                imagem_mime_type            VARCHAR(512),
                imagem_arquivo              VARCHAR(512),
                imagem_charset              VARCHAR(512),
                imagem_ultima_atualizacao   DATE,

                -- Definindo a PK:
                    CONSTRAINT pk_produtos 
                    PRIMARY KEY (produto_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE produtos 
                IS 'Tabela referente as informações dos produtos, tais como, código, nome, preço, detalhes e imagem.';

            -- Comentários das colunas:
                COMMENT ON COLUMN produtos.produto_id 
                IS 'Apresenta a chave primária da tabela produtos, funciona como identificador de cada produto cadastrado.';

                COMMENT ON COLUMN produtos.nome 
                IS 'Apresenta o nome dos produtos.';

                COMMENT ON COLUMN produtos.preco_unitario 
                IS 'Apresenta o preço unitário referente ao produto.';

                COMMENT ON COLUMN produtos.detalhes 
                IS 'Apresenta os detalhes de cada produto.';

                COMMENT ON COLUMN produtos.imagem 
                IS 'Apresenta a imagem do produto, em arquivo BLOB.';

                COMMENT ON COLUMN produtos.imagem_mime_type 
                IS 'Apresenta o MIME Type referente a imagem do produto.';

                COMMENT ON COLUMN produtos.imagem_arquivo 
                IS 'Apresenta o arquivo referente á imagem do produto.';

                COMMENT ON COLUMN produtos.imagem_arquivo 
                IS 'Apresenta o charset utilizado na imagem do produto.';

                COMMENT ON COLUMN produtos.imagem_ultima_atualizacao 
                IS 'Apresenta a data da última atualização na imagem do produto.';

        /* Criando a tabela "lojas", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE lojas (
                loja_id                     NUMERIC(38)   NOT NULL,
                nome                        VARCHAR(255)  NOT NULL,
                endereco_web                VARCHAR(100),
                endereco_fisico             VARCHAR(512),
                latitude                    NUMERIC,
                longitude                   NUMERIC,
                logo                        BYTEA,
                logo_mime_type              VARCHAR(512),
                logo_arquivo                VARCHAR(512),
                logo_charset                VARCHAR(512),
                logo_ultima_atualizacao     DATE,

                -- Definindo a PK:
                    CONSTRAINT pk_lojas 
                    PRIMARY KEY (loja_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE lojas 
                IS 'Tabela referente ás informações das lojas, tais como, código, nome, localização e logo.';

            -- Comentários das colunas:
                COMMENT ON COLUMN lojas.loja_id 
                IS 'Apresenta a chave primária da tabela lojas, funciona como identificador de cada loja cadastrada.';

                COMMENT ON COLUMN lojas.nome 
                IS 'Apresenta o nome das lojas.';

                COMMENT ON COLUMN lojas.endereco_web 
                IS 'Apresenta o endereço web das lojas.';

                COMMENT ON COLUMN lojas.endereco_fisico 
                IS 'Apresenta o endereço físico das lojas.';

                COMMENT ON COLUMN lojas.latitude 
                IS 'Apresenta a latitude da coordenada da loja.';

                COMMENT ON COLUMN lojas.longitude 
                IS 'Apresenta a longitude da coordenada da loja.';

                COMMENT ON COLUMN lojas.logo 
                IS 'Apresenta a logo da loja, em arquivo BLOB.';

                COMMENT ON COLUMN lojas.logo_mime_type 
                IS 'Apresenta o MIME Type referente a logo da loja.';

                COMMENT ON COLUMN lojas.logo_arquivo 
                IS 'Apresenta o arquivo referente á logo da loja.';

                COMMENT ON COLUMN lojas.logo_charset 
                IS 'Apresenta o charset utilizado na logo da loja.';

                COMMENT ON COLUMN lojas.logo_ultima_atualizacao 
                IS 'Apresenta a data da última atualização na logo da loja.';

        /* Criando a tabela "pedidos", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE pedidos (
                pedido_id       NUMERIC(38) NOT NULL,
                data_hora       TIMESTAMP   NOT NULL,
                cliente_id      NUMERIC(38) NOT NULL,
                status          VARCHAR(15) NOT NULL,
                loja_id         NUMERIC(38) NOT NULL,

                --Definindo a PK:
                    CONSTRAINT pk_pedidos 
                    PRIMARY KEY (pedido_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE pedidos 
                IS 'Tabela referente ás informações de um pedido realizado, tais como, código do pedido, quando foi efetuado, quem o efetuou, status atual e em que loja foi feito.';

            -- Comentários das colunas:
                COMMENT ON COLUMN pedidos.pedido_id 
                IS 'Apresenta a chave primária da tabela pedidos, funciona como identificador de cada pedido realizado.';

                COMMENT ON COLUMN pedidos.data_hora 
                IS 'Apresenta a data e hora em que o pedido foi efetuado.';

                COMMENT ON COLUMN pedidos.cliente_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "clientes". Apresenta qual cliente efetuou o pedido.';

                COMMENT ON COLUMN pedidos.status 
                IS 'Apresenta a situação atual do pedido.';

                COMMENT ON COLUMN pedidos.loja_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "lojas". Apresenta em que loja foi feito o pedido.';

        /* Criando a tabela "envios", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE envios (
                envio_id            NUMERIC(38)  NOT NULL,
                loja_id             NUMERIC(38)  NOT NULL,
                cliente_id          NUMERIC(38)  NOT NULL,
                endereco_entrega    VARCHAR(512) NOT NULL,
                status              VARCHAR(15)  NOT NULL,

                -- Definindo a PK:
                    CONSTRAINT pk_envios 
                    PRIMARY KEY (envio_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE envios 
                IS 'Tabela referente as informações de envio dos pedidos, tais como, código de envio, qual loja o realizou, para qual cliente foi enviado e sua situação.';

            -- Comentários das colunas:
                COMMENT ON COLUMN envios.envio_id 
                IS 'Apresenta a chave primária da tabela envios, funciona como identificador de cada envio.';

                COMMENT ON COLUMN envios.loja_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "lojas". Apresenta que loja realizou o envio.';

                COMMENT ON COLUMN envios.cliente_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "clientes". Apresenta para qual cliente foi feito o envio.';

                COMMENT ON COLUMN envios.endereco_entrega 
                IS 'Apresenta qual o endereço de entrega onde o envio deve ser destinado.';

                COMMENT ON COLUMN envios.status 
                IS 'Apresenta a situação atual do envio.';

        /* Criando a tabela "pedidos_itens", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE pedidos_itens (
                pedido_id           NUMERIC(38)    NOT NULL,
                produto_id          NUMERIC(38)    NOT NULL,
                numero_da_linha     NUMERIC(38)    NOT NULL,
                preco_unitario      NUMERIC(10,2),
                quantidade          NUMERIC(38)    NOT NULL,
                envio_id            NUMERIC(38),

                -- Definindo a PK:
                    CONSTRAINT pk_pedidos_itens 
                    PRIMARY KEY (pedido_id, produto_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE pedidos_itens 
                IS 'Tabela referente ás informações do conteúdo de um pedido, tais como, código do pedido, quais produtos estão contidos nele, linha do produto, preço, quantidade pedida e qual seu envio.';

            -- Comentários das colunas:
                COMMENT ON COLUMN pedidos_itens.pedido_id 
                IS 'Parte da chave primária da tabela pedidos_itens, chave estrangeira referente a PK da tabela "pedidos". Apresenta o código do pedido';

                COMMENT ON COLUMN pedidos_itens.produto_id 
                IS 'Parte da chave primária da tabela pedidos_itens, chave estrangeira referente a PK da tabela "produtos". Apresenta o código do produto que foi pedido.';

                COMMENT ON COLUMN pedidos_itens.numero_da_linha 
                IS 'Apresenta o número da linha do pedido.';

                COMMENT ON COLUMN pedidos_itens.preco_unitario 
                IS 'Apresenta o preço unitário referente ao produto.';

                COMMENT ON COLUMN pedidos_itens.quantidade 
                IS 'Apresenta a quantidade pedida de um produto.';

                COMMENT ON COLUMN pedidos_itens.envio_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "envios". Apresenta o código de envio do pedido.';

        /* Criando a tabela "estoques", suas colunas,
        seus comentários e definindo sua primary key. */
            CREATE TABLE estoques (
                estoque_id      NUMERIC(38) NOT NULL,
                loja_id         NUMERIC(38) NOT NULL,
                produto_id      NUMERIC(38) NOT NULL,
                quantidade      NUMERIC(38) NOT NULL,

                -- Definindo a PK:
                    CONSTRAINT pk_estoques 
                    PRIMARY KEY (estoque_id)
            );
            -- Comentário da tabela:
                COMMENT ON TABLE estoques 
                IS 'Tabela intermediária que estabelece a relação N:N entre as tabelas "lojas" e "produtos". Mostra os estoques das lojas e seus produtos.';

            -- Comentários das colunas:
                COMMENT ON COLUMN estoques.estoque_id 
                IS 'Apresenta a chave primária da tabela estoques, funciona como identificador de cada estoque.';

                COMMENT ON COLUMN estoques.loja_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "lojas". Apresenta a loja na qual pertence o estoque.';

                COMMENT ON COLUMN estoques.produto_id 
                IS 'Chave estrangeira, faz referência á PK da tabela "produtos". Apresenta o produto que está em estoque.';

                COMMENT ON COLUMN estoques.quantidade 
                IS 'Apresenta a quantidade de produtos que estão em estoque.';

    /* Criando os relacionamentos entre as tabelas.*/
        -- Relacionamento não identificado entre as tabelas "clientes" e "pedidos":
            ALTER TABLE pedidos 
            ADD CONSTRAINT fk_clientes_pedidos
            FOREIGN KEY (cliente_id)
            REFERENCES clientes (cliente_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "clientes" e "envios":
            ALTER TABLE envios 
            ADD CONSTRAINT fk_clientes_envios
            FOREIGN KEY (cliente_id)
            REFERENCES clientes (cliente_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "produtos" e "estoques":
            ALTER TABLE estoques 
            ADD CONSTRAINT fk_produtos_estoques
            FOREIGN KEY (produto_id)
            REFERENCES produtos (produto_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "lojas" e "estoques":
            ALTER TABLE estoques 
            ADD CONSTRAINT fk_lojas_estoques
            FOREIGN KEY (loja_id)
            REFERENCES lojas (loja_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "lojas" e "envios":
            ALTER TABLE envios 
            ADD CONSTRAINT fk_lojas_envios
            FOREIGN KEY (loja_id)
            REFERENCES lojas (loja_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "lojas" e "pedidos":
            ALTER TABLE pedidos 
            ADD CONSTRAINT fk_lojas_pedidos
            FOREIGN KEY (loja_id)
            REFERENCES lojas (loja_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento não identificado entre as tabelas "envios" e "pedidos_itens":
            ALTER TABLE pedidos_itens 
            ADD CONSTRAINT fk_envios_pedidos_itens
            FOREIGN KEY (envio_id)
            REFERENCES envios (envio_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento identificado entre as tabelas "pedidos" e "pedidos_itens":
            ALTER TABLE pedidos_itens 
            ADD CONSTRAINT fk_pedidos_pedidos_itens
            FOREIGN KEY (pedido_id)
            REFERENCES pedidos (pedido_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

        -- Relacionamento identificado entre as tabelas "produtos" e "pedidos_itens":
            ALTER TABLE pedidos_itens 
            ADD CONSTRAINT fk_produtos_pedidos_itens
            FOREIGN KEY (produto_id)
            REFERENCES produtos (produto_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            NOT DEFERRABLE;

    /* Criando as constraints de checagem. */
        -- Constraints que limitam as situações de status:
            ALTER TABLE  pedidos
            ADD CONSTRAINT cc_pedidos_status
            CHECK( status in('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO') );

            ALTER TABLE  envios
            ADD CONSTRAINT cc_envios_status
            CHECK( status in('CRIADO','ENVIADO','TRANSITO','ENTREGUE') );

        -- Constraint que obriga o preenchimento de pelo menos uma forma de endereço:
            ALTER TABLE lojas
            ADD CONSTRAINT cc_lojas_endereco
            CHECK( endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);

        -- Constraints que impedem que os preços unitários sejam negativos:
            ALTER TABLE produtos
            ADD CONSTRAINT cc_produtos_preco_unitario
            CHECK( preco_unitario > 0 );

            ALTER TABLE pedidos_itens
            ADD CONSTRAINT cc_pedidos_itens_preco_unitario
            CHECK( preco_unitario > 0 );

        -- Constraints que impedem que as quantidades sejam negativas:
            ALTER TABLE pedidos_itens
            ADD CONSTRAINT cc_pedidos_itens_quantidade
            CHECK( quantidade > 0 );

            ALTER TABLE estoques
            ADD CONSTRAINT cc_estoques_quantidade
            CHECK( quantidade > 0 );

        -- Constraint que impede que telefones iguais sejam adicionados:
            ALTER TABLE clientes
            ADD CONSTRAINT cc_clientes_telefone
            CHECK( telefone1 <> telefone2 AND
                   telefone2 <> telefone3 AND 
                   telefone1 <> telefone3 );
