-- Cria login se não existir
IF NOT EXISTS(SELECT principal_id FROM sys.server_principals WHERE name = 'admin') BEGIN
    CREATE LOGIN [admin] WITH PASSWORD=N'Sql@server2019Express', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Português (Brasil)], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
    -- Função do servidor para conceder ao usuário privilégios de segurança em todo servidor
    ALTER SERVER ROLE [dbcreator] ADD MEMBER [admin]
    ALTER SERVER ROLE [serveradmin] ADD MEMBER [admin]
    ALTER SERVER ROLE [setupadmin] ADD MEMBER [admin]
    ALTER SERVER ROLE [processadmin] ADD MEMBER [admin]
END
GO

-- Cria banco de dados se não existir
IF NOT EXISTS(SELECT case when name is not null then 1 else 0 end from master.sys.databases where name = 'pgd_susep') BEGIN
    CREATE DATABASE [pgd_susep] WITH CATALOG_COLLATION = DATABASE_DEFAULT

    IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
    begin
    EXEC [pgd_susep].[dbo].[sp_fulltext_database] @action = 'enable'
    end

    -- BD Produção
    ALTER DATABASE [pgd_susep] SET ANSI_NULL_DEFAULT OFF 
    ALTER DATABASE [pgd_susep] SET ANSI_NULLS OFF 
    ALTER DATABASE [pgd_susep] SET ANSI_PADDING OFF 
    ALTER DATABASE [pgd_susep] SET ANSI_WARNINGS OFF 
    ALTER DATABASE [pgd_susep] SET ARITHABORT OFF 
    ALTER DATABASE [pgd_susep] SET AUTO_CLOSE ON 
    ALTER DATABASE [pgd_susep] SET AUTO_SHRINK OFF 
    ALTER DATABASE [pgd_susep] SET AUTO_UPDATE_STATISTICS ON 
    ALTER DATABASE [pgd_susep] SET CURSOR_CLOSE_ON_COMMIT OFF 
    ALTER DATABASE [pgd_susep] SET CURSOR_DEFAULT  GLOBAL 
    ALTER DATABASE [pgd_susep] SET CONCAT_NULL_YIELDS_NULL OFF 
    ALTER DATABASE [pgd_susep] SET NUMERIC_ROUNDABORT OFF 
    ALTER DATABASE [pgd_susep] SET QUOTED_IDENTIFIER OFF 
    ALTER DATABASE [pgd_susep] SET RECURSIVE_TRIGGERS OFF 
    ALTER DATABASE [pgd_susep] SET ENABLE_BROKER 
    ALTER DATABASE [pgd_susep] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
    ALTER DATABASE [pgd_susep] SET DATE_CORRELATION_OPTIMIZATION OFF 
    ALTER DATABASE [pgd_susep] SET TRUSTWORTHY OFF 
    ALTER DATABASE [pgd_susep] SET ALLOW_SNAPSHOT_ISOLATION OFF 
    ALTER DATABASE [pgd_susep] SET PARAMETERIZATION SIMPLE 
    ALTER DATABASE [pgd_susep] SET READ_COMMITTED_SNAPSHOT OFF 
    ALTER DATABASE [pgd_susep] SET HONOR_BROKER_PRIORITY OFF 
    ALTER DATABASE [pgd_susep] SET RECOVERY FULL 
    ALTER DATABASE [pgd_susep] SET MULTI_USER 
    ALTER DATABASE [pgd_susep] SET PAGE_VERIFY CHECKSUM  
    ALTER DATABASE [pgd_susep] SET DB_CHAINING OFF 
    ALTER DATABASE [pgd_susep] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
    ALTER DATABASE [pgd_susep] SET TARGET_RECOVERY_TIME = 60 SECONDS 
    ALTER DATABASE [pgd_susep] SET DELAYED_DURABILITY = DISABLED 
    ALTER DATABASE [pgd_susep] SET ACCELERATED_DATABASE_RECOVERY = OFF  
    ALTER DATABASE [pgd_susep] SET QUERY_STORE = OFF
    ALTER DATABASE [pgd_susep] SET  READ_WRITE 
    ALTER AUTHORIZATION ON DATABASE::[pgd_susep] TO [admin]
    ALTER DATABASE [pgd_susep] SET COMPATIBILITY_LEVEL = 100

    -- BD Staging
    CREATE DATABASE pgd_staging
    ALTER DATABASE [pgd_staging] SET COMPATIBILITY_LEVEL = 100
    ALTER AUTHORIZATION ON DATABASE::[pgd_staging] TO [admin]

    -- BD Treinamento
    CREATE DATABASE pgd_train
    ALTER DATABASE [pgd_train] SET COMPATIBILITY_LEVEL = 100
    ALTER AUTHORIZATION ON DATABASE::[pgd_train] TO [admin]
END
GO

-- Banco de dados padrão do logon
ALTER LOGIN [admin] WITH DEFAULT_DATABASE=[pgd_susep], DEFAULT_LANGUAGE=[Português], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

-- -- Associação à função de banco de dados
-- ALTER ROLE [db_backupoperator] ADD MEMBER [admin]
-- GO
-- ALTER ROLE [db_datareader] ADD MEMBER [admin]
-- GO
-- ALTER ROLE [db_datawriter] ADD MEMBER [admin]
-- GO
-- ALTER ROLE [db_owner] ADD MEMBER [admin]
-- GO

USE [pgd_susep]
GO
-- Criação e mapeamento do usuário para o logon
CREATE USER [admin] FOR LOGIN [admin]
GO

ALTER AUTHORIZATION ON DATABASE::[pgd_susep] TO [admin]
GO
