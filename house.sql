-- Drop tables if restarting
DROP TABLE IF EXISTS household_barrier_log;
DROP TABLE IF EXISTS opportunity_resources;
DROP TABLE IF EXISTS households;
DROP TABLE IF EXISTS income_brackets;
DROP TABLE IF EXISTS neighborhood_benchmarks;

CREATE TABLE neighborhood_benchmarks (
  zip TEXT PRIMARY KEY, -- Primary key that will get ref later 
  area_average_income REAL NOT NULL -- REAL tells this database to store dec num. NOT NULL means its required 
  ); 
 -- First bubble up above ALTER
 
 CREATE TABLE income_brackets (
   bracket_id INTEGER PRIMARY KEY AUTOINCREMENT, -- autoincrements just automaticlalu updates the ID ALTER
   bracket_name TEXT NOT NULL,
   min_income REAL NOT NULL, 
   max_income REAL NOT NULL, 
   is_median_threshold BOOLEAN DEFAULT 0 
  ); 
  
  CREATE TABLE households (
    household_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    bracket_id INTEGER, 
    zip TEXT, 
    annual_income REAL NOT NULL, 
    household_size INTEGER NOT NULL, 
    credit_score INTEGER NOT NULL, 
    FOREIGN KEY (bracket_id) REFERENCES income_brackets(bracket_id), 
    FOREIGN KEY (zip) REFERENCES neighborhood_benchmarks(zip)
   ); 
   
   CREATE TABLE opportunity_resources (
     opportunity_id INTEGER PRIMARY KEY AUTOINCREMENT, 
     resource_name TEXT NOT NULL, 
     category TEXT NOT NULL, 
     income_cutoff REAL NOT NULL, 
     min_credit_score INTEGER NOT NULL, 
     barrier_description TEXT NOT NULL 
   ); 
    
   CREATE TABLE household_barrier_log (
     log_id INTEGER PRIMARY KEY AUTOINCREMENT,
     household_id INTEGER, 
     opportunity_id INTEGER,
     access_status TEXT NOT NULL,
     FOREIGN KEY (household_id) REFERENCES households(household_id),
     FOREIGN KEY (opportunity_id) REFERENCES opportunity_resources(opportunity_id) 
    );
    
    SELECT * FROM households
