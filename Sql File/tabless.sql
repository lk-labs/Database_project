CREATE database PROJECT_rev;

USE PROJECT_rev;
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

-- Creating Drivers Table
CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    national_id VARCHAR(20) UNIQUE,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255) UNIQUE
);

-- Creating Buses Table
CREATE TABLE buses (
    bus_id INT AUTO_INCREMENT PRIMARY KEY,
    reg_number VARCHAR(50) UNIQUE,
    max_passengers INT,
    driver_id INT,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- Creating Routes Table
CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT,
    from_location VARCHAR(255),
    to_location VARCHAR(255),
    max_passengers INT,
    route_name VARCHAR(255),
    route_cost FLOAT,
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
    UNIQUE (from_location, to_location)
);


-- Creating Booking Tickets Table
CREATE TABLE booking_tickets (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    route_id INT,
    date DATE,
    time TIME,
    price DECIMAL(10, 2),
    seat_number VARCHAR(10),
    unique(seat_number),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

-- Creating Payment Option Table
CREATE TABLE payment_option (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    booking_id INT,
    payment_date DATETIME,
    payment_status ENUM('confirmed', 'pending', 'failed'),
    mpesa_receipt_no VARCHAR(255),
    MerchantRequestID VARCHAR(222),
    CheckoutRequestID VARCHAR(222),
    FOREIGN KEY (booking_id) REFERENCES booking_tickets(booking_id)
);

-- Creating User Booking History Table
CREATE TABLE user_booking_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    booking_id INT,
    day DATE,
    time TIME,
    payment_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES booking_tickets(booking_id),
    FOREIGN KEY (payment_id) REFERENCES payment_option(payment_id)
);

-- Creating User Cancellations Table
CREATE TABLE user_cancellations (
    cancellation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    booking_id INT,
    cancellation_date DATE,
    cancellation_time TIME,
    payment_id INT,
    cancellation_status ENUM('Cancelled', 'Pending'),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES booking_tickets(booking_id),
    FOREIGN KEY (payment_id) REFERENCES payment_option(payment_id)
);

-- Creating Booked Trips Table
CREATE TABLE booked_trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    route_id INT,
    bus_id INT,
    driver_id INT,
    trip_date DATE,
    trip_time TIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- Creating Admin Table
CREATE TABLE admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name varchar(25),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

-- Creating Seat Reservations Table
CREATE TABLE seat_reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seat_number VARCHAR(10),
    foreign key (seat_number) references booking_tickets(seat_number),
    FOREIGN KEY (booking_id) REFERENCES booking_tickets(booking_id)
);

-- Creating Audit Logs Table
CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type ENUM('booking', 'cancellation', 'payment', 'update', 'login', 'logout'),
    user_id INT,
    action_details TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Creating Feedback Table
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    bus_id INT,
    rating INT,
    comments VARCHAR(255),
    feedback_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (bus_id) REFERENCES buses(bus_id)
);
