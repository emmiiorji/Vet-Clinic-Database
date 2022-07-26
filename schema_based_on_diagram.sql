CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL
  CONSTRAINT vet_date_of_birth_check CHECK(date_of_birth < CURRENT_DATE + 1)
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP DEFAULT NOW(),
  patient_id INT REFERENCES patients(id),
  status VARCHAR(100) NOT NULL
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type VARCHAR(100) NOT NULL,
  name VARCHAR(100) NOT NULL
);

CREATE TABLE  invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL DEFAULT 0.0,
  generated_at TIMESTAMP DEFAULT NOW(),
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT REFERENCES medical_histories(id) NOT NULL UNIQUE
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id)
)

CREATE TABLE medical_histories_treatments (
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
)