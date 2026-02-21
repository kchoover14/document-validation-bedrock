CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id VARCHAR(255),
    document_type VARCHAR(50),
    ai_status VARCHAR(20), -- 'PASS' or 'FAIL'
    ai_reasoning TEXT,
    raw_data JSONB
);