create DATABASE Hospital; 
 
Use Hospital; 

create table pessoas ( 

	id int not null primary key identity, 

	data_nascimento date not null, 

	genero char(15) not null, 

	estado_civil char (15), 

	rg char(9) not null, 
); 


--4)

Alter table pessoas 

add nome char(15); 


--2) e 5)

insert into pessoas values ('1999-05-29', 'Masculino', 'Solteiro', '426907698', 'João'); 

insert into pessoas values ('1975-08-25', 'Feminino', 'Viúva', '365987421', 'Lana'); 

insert into pessoas values ('1990-12-10', 'Masculino', 'Casado', '748963263', 'Davi'); 

insert into pessoas values ('1988-05-20', 'Feminino', 'Casada', '851263879', 'Priscila'); 

insert into pessoas values ('1970-09-12', 'Masculino', 'Divorciado', '659875426', 'Paulo'); 


create table medicos ( 

	id_pessoa int not null primary key, 

	crm char(15) not null, 

	foreign key (id_pessoa) references pessoas (id) 
); 


insert into medicos (id_pessoa, crm) values (1, 'CRM-SP546986'); 

insert into medicos (id_pessoa, crm) values (2, 'CRM-SP968748'); 

insert into medicos (id_pessoa, crm) values (3, 'CRM-SP659832');

insert into medicos (id_pessoa, crm) values (4, 'CRM-SP621478');

insert into medicos (id_pessoa, crm) values (5, 'CRM-SP495682');


create table pacientes ( 

	id_pessoa int not null primary key, 

	convenio char (15) not null, 

	foreign key (id_pessoa) references pessoas (id) 
); 


insert into pacientes (id_pessoa, convenio) values (2, 'Plano A'); 

insert into pacientes (id_pessoa, convenio) values (4, 'Plano B'); 

insert into pacientes (id_pessoa, convenio) values (6, 'Plano Plus'); 

insert into pacientes (id_pessoa, convenio) values (8, 'Plano Vintage');

insert into pacientes (id_pessoa, convenio) values (10, 'Plano Dark');


create table consultas ( 

	id int not null primary key identity, 

	data date not null, 

	diagnostico char(15) not null, 

	id_medico int not null, 

	id_paciente int not null, 

	foreign key (id_medico) references medicos (id_pessoa), 

	foreign key (id_paciente) references pacientes (id_pessoa) 
); 


insert into consultas (data, diagnostico, id_medico, id_paciente) values ('2023-08-25', 'Covid', 1, 2); 

insert into consultas (data, diagnostico, id_medico, id_paciente) values ('2023-09-15', 'Gripe', 3, 4); 

insert into consultas (data, diagnostico, id_medico, id_paciente) values ('2024-01-08', 'Alergia', 1, 5); 

insert into consultas (data, diagnostico, id_medico, id_paciente) values ('2024-02-06', 'Fratura', 1, 2); 

insert into consultas (data, diagnostico, id_medico, id_paciente) values ('2024-02-19', 'Febre', 3, 4); 


create table exames ( 

	id int not null primary key identity, 

	id_consulta int not null, 

	data date not null, 

	exame char (15), 

	foreign key (id_consulta) references consultas (id) 

); 


insert into exames (id_consulta, data, exame) values (1, '2023-09-05', 'Teste de Covid'); 

insert into exames (id_consulta, data, exame) values (2, '2023-12-24', 'Sangue'); 

insert into exames (id_consulta, data, exame) values (3, '2024-03-01', 'Alérgeno'); 

insert into exames (id_consulta, data, exame) values (4, '2024-04-10', 'Raio-x'); 

insert into exames (id_consulta, data, exame) values (5, '2024-04-17', 'Sangue'); 


create table telefones ( 

	id_pessoa int not null, 

	ddd int not null, 

	telefone int not null, 

	primary key (id_pessoa, ddd, telefone), 

	foreign key (id_pessoa) references pessoas (id) 

); 


insert into telefones (id_pessoa, ddd, telefone) values (1, 11, 963587491); 

insert into telefones (id_pessoa, ddd, telefone) values (2, 21, 996874952); 

insert into telefones (id_pessoa, ddd, telefone) values (3, 31, 949563214); 

insert into telefones (id_pessoa, ddd, telefone) values (4, 41, 949875632); 

insert into telefones (id_pessoa, ddd, telefone) values (5, 51, 944554189); 


create table enderecos ( 

	id int not null identity, 

	id_pessoa int not null, 

	logradouro char (15), 

	numero int not null, 

	cep int not null, 

	bairro varchar (30) not null, 

	cidade varchar (30) not null, 

	estado varchar (30) not null, 

	primary key (id, id_pessoa), 

	foreign key (id_pessoa) references pessoas (id) 
); 


insert into enderecos (id_pessoa, logradouro, numero, cep, bairro, cidade, estado) 

VALUES  

(1, 'Rua A', 100, '12345678', 'Centro', 'São Paulo', 'SP'), 

(2, 'Rua B', 200, '54321876', 'Centro', 'Rio de Janeiro', 'RJ'), 

(3, 'Rua C', 300, '98765432', 'Centro', 'Belo Horizonte', 'MG'), 

(4, 'Rua D', 400, '56789012', 'Centro', 'João Pessoa', 'PB'), 

(5, 'Rua E', 500, '21098765', 'Centro', 'Teresina', 'PI'); 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from pessoas
select * from medicos
select * from pacientes
select * from consultas
select * from exames
select * from telefones
select * from enderecos

--6)
DECLARE @id_medico INT = 1; 

select * from consultas 
WHERE id_medico = 1; 

--7)
Declare @id_consulta int = 3; 
  
select * from exames 
where id_consulta = 3; 

--8)
Declare @id_pessoa int = 2; 

select * from telefones 
where id_pessoa = 2; 

--9)
select * 
from pessoas
INNER JOIN pacientes ON pessoas.id = pacientes.id_pessoa;

--10)
select *
from pessoas
INNER Join medicos ON pessoas.id = medicos.id_pessoa;