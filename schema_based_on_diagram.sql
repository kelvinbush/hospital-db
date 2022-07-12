create table patients
(
    id            serial primary key,
    name          varchar(25),
    date_of_birth date
);

create table medical_histories
(
    id          serial primary key,
    admitted_at timestamp,
    status      varchar(25)
);

create table invoices
(
    id           serial primary key,
    total_amount decimal,
    generated_at timestamp,
    payed_at     timestamp
);

create table invoice_items
(
    id          serial primary key,
    unit_price  decimal,
    quantity    int,
    total_price decimal
);

create table treatments
(
    id   serial primary key,
    name varchar(25),
    type varchar(25)
);

create table histories_treatments
(
    id                 serial primary key,
    medical_history_id int,
    treatment_id       int,
    constraint fk_history FOREIGN KEY (medical_history_id) references medical_histories (id),
    constraint fk_treatment FOREIGN KEY (treatment_id) references treatments (id)
);

ALTER TABLE invoice_items
    ADD COLUMN treatment_id INT;
ALTER TABLE invoice_items
    ADD CONSTRAINT fk_treatments
        FOREIGN KEY (treatment_id) REFERENCES treatments (id);

ALTER TABLE invoice_items
    ADD COLUMN invoice_id INT;
ALTER TABLE invoice_items
    ADD CONSTRAINT fk_invoice
        FOREIGN KEY (invoice_id) REFERENCES invoices (id);

ALTER TABLE invoices
    ADD COLUMN medical_history_id INT;
ALTER TABLE invoices
    ADD CONSTRAINT fk_histories
        FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);

ALTER TABLE medical_histories
    ADD COLUMN patient_id INT;
ALTER TABLE medical_histories
    ADD CONSTRAINT fk_patient
        FOREIGN KEY (patient_id) REFERENCES patients (id);