Create database FichaMedica;

Use FichaMedica;

Create table Paciente(
	nro_paciente int not null IDENTITY primary key,
	nome VARCHAR (30) not null,
	data_nascimento DATETIME not null,
	genero VARCHAR (10) not null,
	convenio VARCHAR (15) not null, 
	estado_civil VARCHAR (10) not null,
	rg VARCHAR (15) not null, 
	telefone VARCHAR (11)  not null,
	endereco VARCHAR (20) not null
);

Create table Medico (
	CRM VARCHAR (10) primary key,
	nome VARCHAR (15) not null
);

create table Consulta (
	num_consulta int not null identity primary key,
	nro_paciente int  not null,
	CRM VARCHAR (10) not null,
	data datetime not null,
	diagnóstico VARCHAR (20) not null,
	foreign key (nro_paciente) references Paciente (nro_paciente),
	foreign key (CRM) references Medico(CRM)
);

create table Exame (
	ID_exame int not null,
	Num_consulta int not null,
	exame VARCHAR (10) not null,
	data datetime not null,
	primary key (ID_exame, Num_consulta),
	foreign key (Num_consulta) references Consulta(Num_consulta)
);