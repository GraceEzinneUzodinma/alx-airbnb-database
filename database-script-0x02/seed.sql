-- Use the airbnb database
USE airbnb_db;

-- Insert sample users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Doe', 'john.doe@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', '+1234567890', 'guest', '2024-01-15 10:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Jane', 'Smith', 'jane.smith@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz234567', '+1234567891', 'host', '2024-01-16 11:30:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Michael', 'Johnson', 'michael.j@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz345678', '+1234567892', 'host', '2024-01-17 09:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emily', 'Williams', 'emily.w@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz456789', '+1234567893', 'guest', '2024-01-18 14:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Admin', 'User', 'admin@airbnb.com', '$2a$10$abcdefghijklmnopqrstuvwxyz567890', '+1234567894', 'admin', '2024-01-10 08:00:00');

-- Insert sample properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Cozy Beach House', 'Beautiful beach house with stunning ocean views. Perfect for families and couples looking for a relaxing getaway.', 'Malibu, California', 250.00, '2024-02-01 10:00:00', '2024-02-01 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'Downtown Loft', 'Modern loft in the heart of downtown. Walking distance to restaurants, shops, and entertainment.', 'New York, New York', 180.00, '2024-02-02 11:30:00', '2024-02-02 11:30:00'),
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 'Mountain Cabin Retreat', 'Rustic cabin nestled in the mountains. Great for hiking enthusiasts and nature lovers.', 'Aspen, Colorado', 200.00, '2024-02-03 09:15:00', '2024-02-03 09:15:00'),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', 'Luxury Villa with Pool', 'Spacious villa with private pool and garden. Ideal for large groups and special occasions.', 'Miami, Florida', 400.00, '2024-02-04 14:20:00', '2024-02-04 14:20:00');

-- Insert sample bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2024-06-01', '2024-06-05', 1000.00, 'confirmed', '2024-05-15 10:00:00'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', '2024-07-10', '2024-07-13', 540.00, 'confirmed', '2024-06-20 14:30:00'),
('750e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '2024-08-15', '2024-08-20', 1000.00, 'confirmed', '2024-07-10 09:00:00'),
('750e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', '2024-09-01', '2024-09-04', 1200.00, 'pending', '2024-08-15 16:45:00'),
('750e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004', '2024-05-20', '2024-05-23', 750.00, 'canceled', '2024-04-10 11:20:00'),
('750e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '2024-10-05', '2024-10-08', 540.00, 'confirmed', '2024-09-01 13:00:00');

-- Insert sample payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 1000.00, '2024-05-15 10:30:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', 540.00, '2024-06-20 15:00:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 1000.00, '2024-07-10 09:30:00', 'stripe'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', 1200.00, '2024-08-15 17:00:00', 'credit_card'),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', 750.00, '2024-04-10 11:45:00', 'paypal'),
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440006', 540.00, '2024-09-01 13:30:00', 'stripe');

-- Insert sample reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('950e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 5, 'Amazing beach house! The views were spectacular and the host was very accommodating. Highly recommend!', '2024-06-06 10:00:00'),
('950e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 4, 'Great location and modern amenities. The loft was clean and comfortable. Only minor issue was some street noise at night.', '2024-07-14 11:30:00'),
('950e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 5, 'Perfect mountain getaway! The cabin was cozy and the hiking trails nearby were beautiful. Will definitely return.', '2024-08-21 14:20:00'),
('950e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004', 3, 'Nice property but the photos were a bit misleading. Still had a good time overall.', '2024-05-24 09:15:00'),
('950e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 5, 'Exceeded expectations! Jane was an excellent host and the loft was even better than advertised.', '2024-10-09 16:45:00'),
('950e8400-e29b-41d4-a716-446655440006', '650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', 4, 'Beautiful villa with an amazing pool. Great for families. Would have given 5 stars but check-in process was a bit confusing.', '2024-09-05 12:30:00'),
('950e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', 5, 'Absolutely loved this cabin! Perfect for a peaceful retreat. The host provided excellent recommendations for local trails.', '2024-08-25 10:00:00'),
('950e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 4, 'Great beach access and lovely interior. Minor maintenance issues but host addressed them quickly.', '2024-06-10 15:20:00');

-- Insert sample messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('a50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Hi Jane, I am interested in booking your beach house for June. Is it available?', '2024-05-10 09:00:00'),
('a50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! Yes, the beach house is available for those dates. I would be happy to host you!', '2024-05-10 10:30:00'),
('a50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', 'Hello! Does the mountain cabin have WiFi? I need to work remotely during my stay.', '2024-07-05 14:20:00'),
('a50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', 'Yes, we have high-speed WiFi available. Perfect for remote work!', '2024-07-05 15:45:00'),
('a50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Thank you for a wonderful stay! The beach house was perfect for our family vacation.', '2024-06-06 11:00:00');