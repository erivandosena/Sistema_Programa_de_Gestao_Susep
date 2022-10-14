ALTER TABLE 
  "ProgramaGestao"."ItemCatalogo" ALTER COLUMN "entregasEsperadas" TYPE VARCHAR (2000), 
  ALTER COLUMN "entregasEsperadas" 
DROP 
  NOT NULL;

ALTER TABLE 
  "ProgramaGestao"."ItemCatalogo" ALTER COLUMN "titulo" TYPE VARCHAR (500), 
  ALTER COLUMN "titulo" 
SET 
  NOT NULL;

ALTER TABLE 
  "ProgramaGestao"."PactoTrabalhoAtividade" 
ADD 
  "modalidadeExecucaoId" INT NULL;

ALTER TABLE 
  dbo."Unidade" 
ADD 
  COLUMN "pessoaIdChefe" bigint NULL, 
ADD 
  COLUMN "pessoaIdChefeSubstituto" bigint NULL;
CREATE TABLE dbo."SituacaoPessoa"(
  "situacaoPessoaId" bigint NOT NULL, 
  "spsDescricao" varchar(50) NOT NULL, 
  CONSTRAINT "PK_SituacaoPessoa" PRIMARY KEY ("situacaoPessoaId")
);

insert into dbo."SituacaoPessoa" 
values 
  (1, 'Ativa');
insert into dbo."SituacaoPessoa" 
values 
  (4, 'Cedida');
insert into dbo."SituacaoPessoa" 
values 
  (5, 'Desligada');
insert into dbo."SituacaoPessoa" 
values 
  (2, 'Falecida');
insert into dbo."SituacaoPessoa" 
values 
  (3, 'Inativa');
CREATE TABLE dbo."TipoVinculo"(
  "tipoVinculoId" bigint NOT NULL, 
  "tvnDescricao" varchar(150) NOT NULL, 
  CONSTRAINT "PK_TipoVinculo" PRIMARY KEY ("tipoVinculoId"), 
  CONSTRAINT "UQ_TipoVinculo_tvnDescricao" UNIQUE ("tvnDescricao")
);

ALTER TABLE 
  dbo."Pessoa" 
ADD 
  COLUMN "situacaoPessoaId" bigint NULL, 
ADD 
  COLUMN "tipoVinculoId" bigint NULL;