-- Table: lca_program.employer

-- DROP TABLE lca_program.employer;

CREATE TABLE lca_program.employer
(
    e_id uuid NOT NULL,
    e_name character varying(60) COLLATE pg_catalog."default",
    e_total_workers integer,
    e_h1b_dependent boolean,
    e_wilful_violator boolean,
    ea_id uuid,
    CONSTRAINT "EMPLOYER_pkey" PRIMARY KEY (e_id),
    CONSTRAINT ea_id FOREIGN KEY (ea_id)
        REFERENCES lca_program.employer_address (ea_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employer
    OWNER to postgres;

COMMENT ON CONSTRAINT ea_id ON lca_program.employer
    IS 'employer address id';


-- Table: lca_program.employer_address

-- DROP TABLE lca_program.employer_address;

CREATE TABLE lca_program.employer_address
(
    ea_id uuid NOT NULL,
    ea_address character varying(60) COLLATE pg_catalog."default",
    ea_city character varying(15) COLLATE pg_catalog."default",
    ea_county character varying(15) COLLATE pg_catalog."default",
    ea_state character varying(3) COLLATE pg_catalog."default",
    ea_postal integer,
    ea_province character varying(10) COLLATE pg_catalog."default",
    ea_phone integer,
    ea_phone_ext integer,
    CONSTRAINT employer_address_pkey PRIMARY KEY (ea_id)
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employer_address
    OWNER to postgres;


-- Table: lca_program.employer_attorney

-- DROP TABLE lca_program.employer_attorney;

CREATE TABLE lca_program.employer_attorney
(
    a_id uuid NOT NULL,
    a_name character varying(15) COLLATE pg_catalog."default",
    a_city character varying(15) COLLATE pg_catalog."default",
    a_state character varying(10) COLLATE pg_catalog."default",
    e_id uuid,
    CONSTRAINT employer_attorney_pkey PRIMARY KEY (a_id),
    CONSTRAINT e_id FOREIGN KEY (e_id)
        REFERENCES lca_program.employer (e_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employer_attorney
    OWNER to postgres;
COMMENT ON TABLE lca_program.employer_attorney
    IS 'employer attorney';

COMMENT ON CONSTRAINT e_id ON lca_program.employer_attorney
    IS 'employer id';


-- Table: lca_program.employment

-- DROP TABLE lca_program.employment;

CREATE TABLE lca_program.employment
(
    em_id character varying(30) COLLATE pg_catalog."default" NOT NULL,
    e_id uuid,
    em_start_date date,
    em_end_date date,
    em_job_title character varying(20) COLLATE pg_catalog."default",
    em_soc_code character varying(20) COLLATE pg_catalog."default",
    em_naics_code integer NOT NULL,
    em_decision_date date,
    em_submitted_date date,
    em_year_belongs_to integer,
    em_case_status character varying(15) COLLATE pg_catalog."default",
    em_visa_class character varying(10) COLLATE pg_catalog."default",
    em_fulltime_position boolean,
    CONSTRAINT employment_pkey PRIMARY KEY (em_id),
    CONSTRAINT e_id FOREIGN KEY (e_id)
        REFERENCES lca_program.employer (e_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_naics_code FOREIGN KEY (em_naics_code)
        REFERENCES lca_program.naics (naics_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employment
    OWNER to postgres;
COMMENT ON TABLE lca_program.employment
    IS 'Employment. case_id is mapped to em_id';

COMMENT ON CONSTRAINT e_id ON lca_program.employment
    IS 'employer id ';
COMMENT ON CONSTRAINT em_naics_code ON lca_program.employment
    IS 'naics code';


-- Table: lca_program.employment_address

-- DROP TABLE lca_program.employment_address;

CREATE TABLE lca_program.employment_address
(
    ema_id uuid NOT NULL,
    em_id character varying(20) COLLATE pg_catalog."default",
    e_id uuid,
    ema_city character varying(20) COLLATE pg_catalog."default",
    ema_state character varying(15) COLLATE pg_catalog."default",
    ema_postal_code integer,
    CONSTRAINT employment_address_pkey PRIMARY KEY (ema_id),
    CONSTRAINT e_id FOREIGN KEY (e_id)
        REFERENCES lca_program.employer (e_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT em_id FOREIGN KEY (em_id)
        REFERENCES lca_program.employment (em_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employment_address
    OWNER to postgres;
COMMENT ON TABLE lca_program.employment_address
    IS 'employment or worksite address';

COMMENT ON CONSTRAINT e_id ON lca_program.employment_address
    IS 'employer id';
COMMENT ON CONSTRAINT em_id ON lca_program.employment_address
    IS 'employment id';



-- Table: lca_program.employment_wage

-- DROP TABLE lca_program.employment_wage;

CREATE TABLE lca_program.employment_wage
(
    ew_id uuid NOT NULL,
    em_id character varying COLLATE pg_catalog."default",
    ew_prevailing_wage real,
    ew_prevailing_wage_unit_pay character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_from real,
    ew_wage_pay_from_unit character varying(10) COLLATE pg_catalog."default",
    ew_wage_pay_to real,
    ew_wage_pay_to_unit character varying(10) COLLATE pg_catalog."default",
    ew_normalized_wage real,
    CONSTRAINT employment_wage_pkey PRIMARY KEY (ew_id),
    CONSTRAINT em_id FOREIGN KEY (em_id)
        REFERENCES lca_program.employment (em_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE lca_program.employment_wage
    OWNER to postgres;

COMMENT ON CONSTRAINT em_id ON lca_program.employment_wage
    IS 'employment id';



-- Table: lca_program.naics

-- DROP TABLE lca_program.naics;

CREATE TABLE lca_program.naics
(
    naics_id uuid NOT NULL,
    naics_code integer NOT NULL,
    naics_title character varying(60) COLLATE pg_catalog."default",
    CONSTRAINT naics_pkey PRIMARY KEY (naics_id),
    CONSTRAINT naics_code_unique UNIQUE (naics_code)

)

TABLESPACE pg_default;

ALTER TABLE lca_program.naics
    OWNER to postgres;
COMMENT ON TABLE lca_program.naics
    IS 'naics ';