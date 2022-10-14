DELETE FROM [dbo].[Pessoa]
DELETE FROM [dbo].[Unidade]
DELETE FROM [dbo].[TipoFuncao]

INSERT INTO [dbo].[TipoFuncao] VALUES (2, 'Diretor', '101.5', 1)
INSERT INTO [dbo].[TipoFuncao] VALUES (3, 'Coordenador-Geral', '101.4', 1)
INSERT INTO [dbo].[TipoFuncao] VALUES (4, 'Coordenador', '101.3', 1)

DECLARE @SUSEP INT
DECLARE @DEAFI INT
DECLARE @DETIC INT
DECLARE @COGEP INT
DECLARE @COGET INT
DECLARE @ASDEN INT
DECLARE @COPROJ INT
DECLARE @COARQ INT
DECLARE @USUARIOGESTOR INT

INSERT INTO [dbo].[Unidade] VALUES ('SUSEP', 'Superintendência de Seguros Privados', NULL, 13, 1, 'RJ', 1, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @SUSEP = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('DEAFI', 'Departamento de Administração e Finanças', @SUSEP, 2, 1, 'RJ', 2, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @DEAFI = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('DETIC', 'Departamento de tecnologia da informação', @SUSEP, 2, 1, 'RJ', 2, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @DETIC = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('COGEP', 'Coordenação de Gestão e Desenvolvimento de Pessoal', @DEAFI, 4, 1, 'RJ', 3, 1, 'susep.rj@susep.gov.br', '', null, null)
SET @COGEP = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('COGET', 'Coordenação de Apoio à Gestão Estratégica', @DEAFI, 4, 1, 'RJ', 3, 5, 'susep.rj@susep.gov.br', '', null, null)
SET @COGET = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('ASDEN', 'Assessoria de Desenvolvimento de Sistemas', @DETIC, 3, 1, 'RJ', 3, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @ASDEN = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('COPROJ', 'Coordenação de Projetos de Tecnologia', @ASDEN, 4, 1, 'RJ', 4, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @COPROJ = @@IDENTITY

INSERT INTO [dbo].[Unidade] VALUES ('COARQ', 'Departamento de tecnologia da informação', @ASDEN, 4, 1, 'RJ', 4, NULL, 'susep.rj@susep.gov.br', '', null, null)
SET @COARQ = @@IDENTITY

INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Gestor', '08056275029', getdate(), '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COPROJ, NULL, 8)
SET @USUARIOGESTOR = @@IDENTITY


INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Servidor', '08152972541', getdate(), '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COPROJ, NULL, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Servidor 1', '59516301002', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COARQ, NULL, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Servidor 2', '18761704091',  getdate(), '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COARQ, NULL, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Servidor 3', '07721701007', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COPROJ, NULL, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Servidor 4', '51884275087', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COPROJ, NULL, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Coordenador', '25715446597', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR',1, 1,  @COPROJ, 2, 8)
update [dbo].[Unidade] set pessoaIdChefe = @@IDENTITY where unidadeid = @COPROJ

INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário CG', '95387502500', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @ASDEN, 3, 8)
update [dbo].[Unidade] set pessoaIdChefe = @@IDENTITY where unidadeid = @ASDEN

INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário COGET', '43321040565', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @COGET, 4, 8)
INSERT INTO [dbo].[Pessoa] (pesNome, pesCPF, pesDataNascimento, pesMatriculaSiape, pesEmail, situacaoPessoaId, tipoVinculoId, unidadeid, tipoFuncaoId, cargaHoraria) VALUES ('Usuário Diretor', '39178470510', getdate(),  '111', 'EMAILPESSOA@ORGAO.GOV.BR', 1, 1, @DETIC, NULL, 8)
update [dbo].[Unidade] set pessoaIdChefe = @@IDENTITY where unidadeid = @DETIC

DELETE FROM [dbo].[CatalogoDominio] WHERE classificacao = 'GestorSistema'
INSERT INTO [dbo].[CatalogoDominio] VALUES(10001, 'GestorSistema', @USUARIOGESTOR, 1)


SET IDENTITY_INSERT [dbo].[Feriado] ON 
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (90, CAST(N'2022-01-01T00:00:00.000' AS DateTime), 1, N'Confraternização universal', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (91, CAST(N'2022-01-20T00:00:00.000' AS DateTime), 1, N'São Sebastião', N'RJ')
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (92, CAST(N'2022-04-21T00:00:00.000' AS DateTime), 1, N'Tiradentes', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (93, CAST(N'2022-04-23T00:00:00.000' AS DateTime), 1, N'São Jorge', N'RJ')
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (94, CAST(N'2022-05-01T00:00:00.000' AS DateTime), 1, N'Dia do Trabalho', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (95, CAST(N'2022-06-24T00:00:00.000' AS DateTime), 1, N'São João', N'BA')
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (96, CAST(N'2022-09-07T00:00:00.000' AS DateTime), 1, N'Independência do Brasil', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (97, CAST(N'2022-10-12T00:00:00.000' AS DateTime), 1, N'Nossa Senhora Aparecida', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (98, CAST(N'2022-11-02T00:00:00.000' AS DateTime), 1, N'Finados', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (99, CAST(N'2022-11-15T00:00:00.000' AS DateTime), 1, N'Proclamação da República', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (100, CAST(N'2022-11-20T00:00:00.000' AS DateTime), 1, N'Dia da consciência negra', N'RJ')
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (101, CAST(N'2022-11-20T00:00:00.000' AS DateTime), 1, N'Dia da consciência negra', N'SP')
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (102, CAST(N'2022-12-25T00:00:00.000' AS DateTime), 1, N'Natal', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (103, CAST(N'2022-02-24T00:00:00.000' AS DateTime), 0, N'Carnaval', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (104, CAST(N'2022-02-25T00:00:00.000' AS DateTime), 0, N'Carnaval', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (105, CAST(N'2022-02-26T00:00:00.000' AS DateTime), 0, N'Sem Expediente', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (106, CAST(N'2022-04-10T00:00:00.000' AS DateTime), 0, N'Sexta-feira Santa', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (107, CAST(N'2022-06-11T00:00:00.000' AS DateTime), 0, N'Corpus Christi', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (108, CAST(N'2022-10-28T00:00:00.000' AS DateTime), 0, N'Dia do Servidor Público', NULL)
GO
INSERT [dbo].[Feriado] ([feriadoId], [ferData], [ferFixo], [ferDescricao], [ufId]) VALUES (109, CAST(N'2022-10-12T00:00:00.000' AS DateTime), 1, N'Nossa Senhora Aparecida', NULL)
GO
