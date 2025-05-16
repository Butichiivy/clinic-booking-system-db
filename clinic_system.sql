-- Clinic Booking System Database SQL Script

-- Drop database if it exists to start fresh
DROP DATABASE IF EXISTS clinicDB;

-- Create the database
CREATE DATABASE clinicDB;
USE clinicDB;

-- Table: patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Table: doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Table: rooms
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    doctor_id INT UNIQUE, -- one-to-one with doctor
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table: appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table: prescriptions
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medicine VARCHAR(255),
    dosage VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Table: payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Insurance'),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
