delete * from mdm_deployment;
insert into mdm_deployment (id, name, version, host, port, tenant_count, create_time, update_time) values
("1", "Local Mdm", "v3.2", "localhost", 8080, 0, now(), now()),
("2", "Dev Mdm", "v3.2", "192.168.10.26", 9100, 0, now(), now()),
("3", "Ebag Mdm", "v3.2", "192.168.10.82", 9100, 0, now(), now());
