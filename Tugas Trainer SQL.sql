--create table mahasiswa
create table mahasiswa(
nim varchar(50) not null, 
nama varchar(50) not null,
alamat varchar (50)not null,
primary key("nim")
);

--create table buku
create table buku(
id_buku varchar(50) not null,
judul varchar (50) not null,
penerbit varchar(50) not null,
pengarang varchar(50) not null,
tahun_terbit varchar(50) not null, 
primary key ("id_buku")
);

--create table member
create table member(
id_member varchar(50) not null,
nama varchar(50) not null,
jurusan varchar(50) not null,
primary key ("id_member")
);

-- create table peminjaman
create table peminjaman(
id_peminjaman varchar(50) not null,
id_buku varchar(50) not null,
id_member varchar(50) not null,
tgl_pinjam date not null,
tgl_kembali date not null,
primary key ("id_peminjaman"),
	constraint fk_buku
		foreign key("id_buku")
			references "buku"("id_buku"),
	constraint fk_member
		foreign key("id_member")
			references "member"("id_member")
);

--insert data table mahasiswa 
insert into mahasiswa 
values
('1901','Ann','Batu'),
('1902','Widya','Malang'),
('1903','Tanta','Batu'),
('1904','Romi',	'Probolinggo'),
('1905','Alfian','Lamongan'),
('1906','Faris','Blitar'),
('1907','Naufal','Bojonegoro'),
('1908','Ihsan','Riau'),
('1909','Nijar','Blitar'),
('1910','Aisyah','Malang');

-- insert data table buku 
insert into buku 
values
('1011','Matahari','Rlangga','Dona','2005'),
('1012','Bulan','Gramedia','Doni','2003'),
('1013','Bintang','Amazon','Dona','2017'),
('1014','Bumi','Pena','Donu','2018'),
('1015','Mars','Amazon','Dono','2012'),
('1016','Asteroid','Grasindo','Dona','2017'),
('1017','Jupiter','Amazon','Doni','2018'),
('1018','Saturnus','Pena','Dono','2017'),
('1019','Uranus','Grasindo','Dona','2011'),
('1020','Neptunus','Pena','Dono','2016');

--insert data table member
insert into "member"  
values
('3001','Ann','Fisika'),
('3002','Alfian','Kimia'),
('3003','Tanta','Biologi'),
('3004','Romi','Fisika'),
('3005','Widya','Matematika'),
('3006','Faris','Biologi'),
('3007','Naufal','Matematika'),
('3008','Ihsan','Matematika'),
('3009','Nijar','Matematika'),
('3010','Aisyah','Fisika');

--insert data table peminjaman 
insert into peminjaman 
values
('1','1011','3001','02/02/2020','09/02/2020'),
('2','1012','3002','03/02/2020','19/02/2020'),
('3','1013','3003','04/02/2020','11/02/2020'),
('4','1014','3004','05/02/2020','12/02/2020'),
('5','1015','3005','06/02/2020','17/02/2020'),
('6','1016','3006','07/02/2020','17/02/2020'),
('7','1017','3007','08/02/2020','15/02/2020'),
('8','1018','3008','09/02/2020','23/02/2020'),
('9','1019','3009','10/02/2020','24/02/2020'),
('10','1020','3010','11/02/2020','20/02/2020');

--1. Tentukan siapa member perpustakaan yang berada di jurusan fisika, kimia dan mamtematika
select nama, jurusan 
from "member" m 
where jurusan not in ('Biologi')

--2. Tentukan buku apa saja yang terbit di amazon dan tahun terbitnya!
select judul, penerbit, tahun_terbit 
from buku b 
where penerbit = 'Amazon'

--3. Hitung dan urutkan pengarang buku dari yang paling banyak!
select pengarang, count(pengarang) as banyak_buku
from peminjaman p 
left join buku b on
p.id_buku = b.id_buku 
group by pengarang
order by banyak_buku desc;

--4. Tentukan nama dan alamat mahasiswa yang mengembalikan buku pada tanggal 17/02/2022!
select m.nama, mhs.alamat, p.tgl_kembali 
from "member" m 
left join mahasiswa mhs on
m.nama = mhs.nama 
left join peminjaman p on
m.id_member = p.id_member 
where p.tgl_kembali = '2020-02-17'

--5. Tentukan denda setiap mahasiswa pada member perpustakaan!
select m.nama,m.jurusan,p.tgl_pinjam, p.tgl_kembali, 
abs(date_part('day', p.tgl_pinjam::timestamp - p.tgl_kembali::timestamp)) *500 - 3500 as denda 
from peminjaman p 
left join "member" m on
p.id_member = m.id_member


