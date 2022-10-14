CREATE TABLE dbo."PessoaAlocacaoTemporaria"(
  "pessoaAlocacaoTemporariaId" uuid NOT NULL, 
  "pessoaId" bigint NOT NULL, 
  "unidadeId" bigint NOT NULL, 
  "dataInicio" date NOT NULL, 
  "dataFim" date NULL, 
  CONSTRAINT "PK_PessoaAlocacaoTemporaria" PRIMARY KEY ("pessoaAlocacaoTemporariaId")
);

ALTER TABLE 
  dbo."PessoaAlocacaoTemporaria" 
ADD 
  CONSTRAINT "FK_PessoaAlocacaoTemporaria_Pessoa" FOREIGN KEY("pessoaId") REFERENCES dbo."Pessoa" ("pessoaId");
  
ALTER TABLE 
  dbo."PessoaAlocacaoTemporaria" 
ADD 
  CONSTRAINT "FK_PessoaAlocacaoTemporaria_Unidade" FOREIGN KEY("unidadeId") REFERENCES dbo."Unidade" ("unidadeId");
