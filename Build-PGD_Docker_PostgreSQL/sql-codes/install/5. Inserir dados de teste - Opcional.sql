-- Descomentar as 3 linhas abaixo somente se as tabelas já estejam populadas --
--DELETE FROM dbo."Pessoa";
--DELETE FROM dbo."Unidade";
--DELETE FROM dbo."TipoFuncao";

INSERT INTO dbo."TipoFuncao" 
VALUES 
  (1, 'Servidor', '', 0);

INSERT INTO dbo."TipoFuncao" 
VALUES 
  (2, 'Diretor', '101.5', 1);

INSERT INTO dbo."TipoFuncao" 
VALUES 
  (
    3, 'Coordenador-Geral', '101.4', 1
  );

INSERT INTO dbo."TipoFuncao" 
VALUES 
  (4, 'Coordenador', '101.3', 1);

-- SUSEP INTEGER DEFAULT 1;
-- DEAFI INTEGER DEFAULT 4;
-- DETIC INTEGER DEFAULT 3;
-- COGEP INTEGER DEFAULT 2;
-- COGET INTEGER DEFAULT 5;
-- ASDEN INTEGER DEFAULT 6;
-- COPROJ INTEGER DEFAULT 7;
-- COARQ INTEGER DEFAULT 8;
-- USUARIOGESTOR INTEGER DEFAULT 1;
INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'SUSEP', 'Superintendência de Seguros Privados', 
    NULL, 13, 1, 'RJ', 1, NULL, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'DEAFI', 'Departamento de Administração e Finanças', 
    1, 2, 1, 'RJ', 2, null, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'DETIC', 'Departamento de tecnologia da informação', 
    1, 2, 1, 'RJ', 2, null, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'COGEP', 'Coordenação de Gestão e Desenvolvimento de Pessoal', 
    4, 4, 1, 'RJ', 3, 1, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'COGET', 'Coordenação de Apoio à Gestão Estratégica', 
    4, 4, 1, 'RJ', 3, 5, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'ASDEN', 'Assessoria de Desenvolvimento de Sistemas', 
    3, 3, 1, 'RJ', 3, null, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'COPROJ', 'Coordenação de Projetos de Tecnologia', 
    6, 4, 1, 'RJ', 4, null, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Unidade"(
  "undSigla", "undDescricao", "unidadeIdPai", 
  "tipoUnidadeId", "situacaoUnidadeId", 
  "ufId", "undNivel", "tipoFuncaoUnidadeId", 
  "Email", "undCodigoSIORG", "pessoaIdChefe", 
  "pessoaIdChefeSubstituto"
) 
VALUES 
  (
    'COARQ', 'Departamento de tecnologia da informação', 
    6, 4, 1, 'RJ', 4, null, 'susep.rj@susep.gov.br', 
    null, null, null
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Gestor', 
    '08056275029', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    2, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Servidor', 
    '08152972541', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    1, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Servidor 1', 
    '59516301002', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    2, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Servidor 2', 
    '18761704091', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    2, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Servidor 3', 
    '07721701007', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    2, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Servidor 4', 
    '51884275087', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    3, 
    7, 
    null, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria", 
  "situacaoPessoaId", "tipoVinculoId"
) 
VALUES 
  (
    'Usuário Coordenador', 
    '25715446597', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    4, 
    7, 
    2, 
    8
  );

UPDATE 
  dbo."Unidade" 
set 
  "pessoaIdChefe" = 2 
where 
  "unidadeId" = 7;

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "situacaoPessoaId", "tipoVinculoId", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria"
) 
VALUES 
  (
    'Usuário CG', 
    '95387502500', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    1, 
    6, 
    3, 
    8
  );

UPDATE 
  dbo."Unidade" 
set 
  "pessoaIdChefe" = 2 
where 
  "unidadeId" = 6;
INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "situacaoPessoaId", "tipoVinculoId", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria"
) 
VALUES 
  (
    'Usuário COGET', 
    '43321040565', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    1, 
    5, 
    4, 
    8
  );

INSERT INTO dbo."Pessoa"(
  "pesNome", "pesCPF", "pesDataNascimento", 
  "pesMatriculaSiape", "pesEmail", 
  "situacaoPessoaId", "tipoVinculoId", 
  "unidadeId", "tipoFuncaoId", "cargaHoraria"
) 
VALUES 
  (
    'Usuário Diretor', 
    '39178470510', 
    (
      select 
        CURRENT_DATE
    ), 
    '111', 
    'EMAILPESSOA@ORGAO.GOV.BR', 
    1, 
    1, 
    3, 
    null, 
    8
  );

UPDATE 
  dbo."Unidade" 
set 
  "pessoaIdChefe" = 2 
where 
  "unidadeId" = 3;
DELETE FROM 
  dbo."CatalogoDominio" 
WHERE 
  "classificacao" = 'GestorSistema';
  
INSERT INTO dbo."CatalogoDominio" 
VALUES 
  (10001, 'GestorSistema', 1, 1);
  
INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-1-1', 1, 'Confraternização universal', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-1-20', 1, 'São Sebastião', 
    'RJ'
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-4-21', 1, 'Tiradentes', null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-4-23', 1, 'São Jorge', 'RJ'
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-5-1', 1, 'Dia do Trabalho', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-6-24', 1, 'São João', 'BA'
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-9-7', 1, 'Independência do Brasil', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-10-12', 1, 'Nossa Senhora Aparecida', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  ('2020-11-2', 1, 'Finados', null);
INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-11-15', 1, 'Proclamação da República', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-11-20', 1, 'Dia da consciência negra', 
    'RJ'
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-11-20', 1, 'Dia da consciência negra', 
    'SP'
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  ('2020-12-25', 1, 'Natal', null);

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  ('2020-2-24', 0, 'Carnaval', null);

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  ('2020-2-25', 0, 'Carnaval', null);

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-2-26', 0, 'Sem Expediente', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-4-10', 0, 'Sexta-feira Santa', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-6-11', 0, 'Corpus Christi', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-10-28', 0, 'Dia do Servidor Público', 
    null
  );

INSERT INTO dbo."Feriado"(
  "ferData", "ferFixo", "ferDescricao", 
  "ufId"
) 
VALUES 
  (
    '2020-10-12', 1, 'Dia da Nossa Senhora Aparecida', 
    null
  );
