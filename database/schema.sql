CREATE TABLE IF NOT EXISTS users(
 id SERIAL PRIMARY KEY,email TEXT UNIQUE NOT NULL,password_hash TEXT NOT NULL,role TEXT DEFAULT 'owner',created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS factories(
 id SERIAL PRIMARY KEY,name TEXT NOT NULL,location TEXT,created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS machines(
 id SERIAL PRIMARY KEY,factory_id INT REFERENCES factories(id) ON DELETE CASCADE,
 machine_code TEXT UNIQUE NOT NULL,name TEXT NOT NULL,type TEXT,status TEXT DEFAULT 'Stopped',
 production INT DEFAULT 0,downtime_minutes INT DEFAULT 0,cycle_time_seconds INT DEFAULT 0,
 controller TEXT,updated_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS machine_readings(
 id BIGSERIAL PRIMARY KEY,machine_id INT REFERENCES machines(id) ON DELETE CASCADE,
 status TEXT,production INT,downtime_minutes INT,cycle_time_seconds INT,alarm TEXT,created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS alerts(
 id BIGSERIAL PRIMARY KEY,machine_id INT REFERENCES machines(id) ON DELETE CASCADE,
 level TEXT,message TEXT,resolved BOOLEAN DEFAULT FALSE,created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS subscriptions(
 id SERIAL PRIMARY KEY,factory_id INT REFERENCES factories(id) ON DELETE CASCADE,
 plan TEXT NOT NULL,status TEXT DEFAULT 'active',machine_limit INT DEFAULT 10,
 started_at TIMESTAMP DEFAULT NOW(),expires_at TIMESTAMP
);
CREATE TABLE IF NOT EXISTS payments(
 id SERIAL PRIMARY KEY,subscription_id INT REFERENCES subscriptions(id) ON DELETE SET NULL,
 amount NUMERIC(12,2),currency TEXT DEFAULT 'INR',status TEXT DEFAULT 'demo',
 provider TEXT DEFAULT 'demo',created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO factories(name,location) SELECT 'ABC Manufacturing','Hisar, Haryana'
WHERE NOT EXISTS(SELECT 1 FROM factories);
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'CNC-01','CNC-01','CNC','Running',248,18,42,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='CNC-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'CNC-02','CNC-02','CNC','Running',231,24,45,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='CNC-02');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'VMC-01','VMC-01','VMC','Idle',196,37,51,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='VMC-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'Lathe-01','Lathe-01','Lathe','Running',312,12,31,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='Lathe-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'Press-01','Press-01','Press','Stopped',154,68,62,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='Press-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'Welding-01','Welding-01','Welding','Running',289,21,38,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='Welding-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'Injection-01','Injection-01','Injection','Alarm',173,55,73,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='Injection-01');
INSERT INTO machines(factory_id,machine_code,name,type,status,production,downtime_minutes,cycle_time_seconds,controller)
SELECT 1,'Compressor-01','Compressor-01','Compressor','Running',0,9,0,'Demo PLC Gateway'
WHERE NOT EXISTS(SELECT 1 FROM machines WHERE machine_code='Compressor-01');
INSERT INTO subscriptions(factory_id,plan,machine_limit)
SELECT 1,'Business',50 WHERE NOT EXISTS(SELECT 1 FROM subscriptions WHERE factory_id=1);
