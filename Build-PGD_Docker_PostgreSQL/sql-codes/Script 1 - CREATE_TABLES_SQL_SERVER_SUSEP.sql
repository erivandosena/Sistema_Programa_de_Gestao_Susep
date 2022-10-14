CREATE TABLE tb_pessoa
(
    id_pessoa bigserial NOT NULL,
    ds_nome character varying(250),
    nr_cpf character varying(14),
    st_registro character varying(25),
    CONSTRAINT "PK_TBPESSOA" PRIMARY KEY (id_pessoa)
);

CREATE TABLE tb_usuario
(
	id_usuario bigserial NOT NULL, 
	id_pessoa int NULL , 
	ds_email varchar(100) NULL , 
	co_senha varchar(200) NULL , 
	st_registro varchar(25) NULL , 
	CONSTRAINT "PK_TBUSUARIO" PRIMARY KEY (id_usuario), 
	CONSTRAINT "FK_TBUSUARIO_PESSOA" FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa (id_pessoa)
);

CREATE INDEX id_pessoa ON tb_usuario (id_pessoa ASC);
 
CREATE TABLE tb_perfil
(
	id_perfil bigserial NOT NULL, 
	ds_perfil varchar(100) NULL , 
	ds_detalhe text NULL, 
	st_registro varchar(25) NULL , 
	CONSTRAINT "PK_TBPERFIL" PRIMARY KEY (id_perfil)
);

CREATE TABLE tb_funcao
(
	id_funcao bigserial NOT NULL, 
	ds_funcao varchar(200) NULL , 
	ds_detalhe text NULL, 
	ds_pagina_acesso varchar(200) NULL , 
	st_registro varchar(25) NULL , 
	CONSTRAINT "PK_TBFUNCAO" PRIMARY KEY (id_funcao)
);

CREATE TABLE rl_perfil_funcao
(
	id_perfil bigserial NOT NULL, 
	id_funcao bigserial NOT NULL, 
	st_alterar varchar(25) NULL , 
	st_cadastrar varchar(25) NULL , 
	st_excluir varchar(25) NULL , 
	st_visualizar varchar(25) NULL , 
	st_registro varchar(25) NULL , 
	CONSTRAINT "PK_RLPF" PRIMARY KEY (id_funcao, id_perfil), 
	CONSTRAINT "FK_RLPF_PERFIL" FOREIGN KEY (id_perfil) REFERENCES tb_perfil (id_perfil), 
	CONSTRAINT "FK_RLPF_FUNCAO" FOREIGN KEY (id_funcao) REFERENCES tb_funcao (id_funcao)
);

CREATE INDEX id_perfil_perfil ON rl_perfil_funcao (id_perfil ASC);
 
CREATE TABLE rl_usuario_perfil
(
	id_usuario bigserial NOT NULL, 
	id_perfil bigserial NOT NULL, 
	CONSTRAINT "PK_RLUP" PRIMARY KEY (id_usuario, id_perfil), 
	CONSTRAINT "PK_RLUP_USUARIO" FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_usuario), 
	CONSTRAINT "PK_RLUP_PERFIL" FOREIGN KEY (id_perfil) REFERENCES tb_perfil (id_perfil)
);

CREATE INDEX id_perfil_usuario ON rl_usuario_perfil (id_perfil ASC);
 
CREATE TABLE tb_log
(
	id_log bigserial NOT NULL, 
	id_usuario int NULL , 
	ds_acao text NULL, 
	ds_tipo_acao varchar(200) NULL , 
	dt_acao timestamp(0) NULL , 
	ds_nivel_acao varchar(200) NULL , 
	CONSTRAINT "PK_TBLOG" PRIMARY KEY (id_log), 
	CONSTRAINT "FK_TBLOG_USUARIO" FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_usuario)
);

CREATE INDEX id_usuario ON tb_log (id_usuario ASC);
 
CREATE TABLE tb_parametro
(
	ds_chave varchar(50) NOT NULL, 
	ds_valor varchar(200) NULL , 
	CONSTRAINT "PK_TBPARAM" PRIMARY KEY (ds_chave)
);

INSERT INTO tb_pessoa (ds_nome, nr_cpf, st_registro) 
VALUES ('Usuário de Sistema - API PGD SUSEP', '000.000.000-00', 'ATIVO');

INSERT INTO tb_pessoa (ds_nome, nr_cpf, st_registro) 
VALUES ('Henrique Alves', '111.111.111-11', 'ATIVO');

INSERT INTO tb_perfil (ds_perfil, ds_detalhe, st_registro) 
VALUES ('ROLE_ADMIN', 'Administrador do Sistema', 'ATIVO');

INSERT INTO tb_perfil (ds_perfil, ds_detalhe, st_registro) 
VALUES ('ROLE_USUARIO', 'Usuário do Sistema', 'ATIVO');

INSERT INTO tb_perfil (ds_perfil, ds_detalhe, st_registro) 
VALUES ('ROLE_USUARIO_AVANCADO', 'Usuário Avançado do Sistema', 'ATIVO');

INSERT INTO tb_usuario (id_pessoa, ds_email, co_senha, st_registro) 
VALUES (1, 'usapipg@economia.gov.br', NULL, 'ATIVO');

INSERT INTO tb_usuario (id_pessoa, ds_email, co_senha, st_registro) 
VALUES (2, 'henrique.alves@economia.gov.br', NULL, 'ATIVO');

INSERT INTO rl_usuario_perfil (id_usuario, id_perfil) VALUES (1, 2);

INSERT INTO rl_usuario_perfil (id_usuario, id_perfil) VALUES (2, 1);

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Painel de Funcionalidades', 'Painel de funcionalidades disponíveis na API PG.Cade.', 'PAINEL_FUNCIONALIDADES', 'ATIVO'); 

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Funções', 'Funcionalidade que permite ao usuário manter (pesquisar, cadastrar, alterar e excluir) as funções da API PG.Cade.', 'MANTER_FUNCOES', 'ATIVO');  

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Perfis', 'Funcionalidade que permite ao usuário manter (pesquisar, cadastrar, alterar e excluir) os perfis da API PG.Cade.', 'MANTER_PERFIS', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Usuários', 'Funcionalidade que permite ao usuário manter (pesquisar, cadastrar, alterar e excluir) os usuários da API PG.Cade.', 'MANTER_USUARIOS', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Logs', 'Funcionalidade que permite ao usuário consultar os logs gerados pela API PG.Cade.', 'MANTER_LOGS', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('API PG.Cade - Enviar Planos', 'Funcionalidade da API PG.Cade que permite ao usuário enviar os planos de trabalho cadastrados no Sistema PG.Cade para a Plataforma do Programa de Gestão - PGD do Ministério da Economia (ME).', 'PAINEL_API_PG_CADE', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('API PG.Cade - Planos Enviados', 'Funcionalidade da API PG.Cade que permite ao usuário consultar os planos de trabalho enviados para a Plataforma do Programa de Gestão - PGD do Ministério da Economia (ME).', 'PAINEL_API_PLANOS_ENVIADOS', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Parâmetros do Sistema', 'Funcionalidade que permite ao usuário manter (pesquisar, cadastrar, alterar e excluir) os parâmetros da API PG.Cade.', 'PAINEL_PARAMETROS', 'ATIVO');

INSERT INTO tb_funcao (ds_funcao, ds_detalhe, ds_pagina_acesso, st_registro)
VALUES ('Agendamento do Envio de Planos', 'Funcionalidade que permite ao usuário agendar o envio de planos de trabalhos da API PG.Cade.', 'PAINEL_AGENDAMENTO', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 1, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 2, 'SIM', 'SIM', 'SIM', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 3, 'SIM', 'SIM', 'SIM', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 4, 'SIM', 'SIM', 'SIM', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 5, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 6, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 7, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 8, 'SIM', 'SIM', 'SIM', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (1, 9, 'SIM', 'SIM', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (2, 1, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (2, 9, 'SIM', 'SIM', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (3, 1, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (3, 6, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (3, 7, 'NAO', 'NAO', 'NAO', 'SIM', 'ATIVO');

INSERT INTO rl_perfil_funcao (id_perfil, id_funcao, st_alterar, st_cadastrar, st_excluir, st_visualizar, st_registro) 
VALUES (3, 9, 'SIM', 'SIM', 'NAO', 'SIM', 'ATIVO');

INSERT INTO tb_log (id_usuario, ds_acao, ds_tipo_acao, dt_acao, ds_nivel_acao) 
VALUES (1, '0 0 0 1 * *', 'LOG_CRON_AGENDAMENTO', '2021-06-23', 'NIVEL_USUARIO');

INSERT INTO tb_parametro (ds_chave, ds_valor) 
VALUES ('DS_AGENDAMENTO_ENVIO_PLANOS', '0 0 0 * * *');

INSERT INTO tb_parametro (ds_chave, ds_valor) 
VALUES ('ST_AGENDAMENTO_ENVIO_PLANOS', 0);
