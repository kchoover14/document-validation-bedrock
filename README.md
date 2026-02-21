# LLM-Powered Document Validation and Auditing via AWS Bedrock

This project implements a serverless AI auditing pipeline that uses Claude 3 Haiku (via Amazon Bedrock) to detect fraudulent or anomalous entries in biometric document metadata before they are committed to a permanent record. A Lambda function retrieves unaudited JSON records from a PostgreSQL database and passes them to Claude acting as a forensic document auditor, which returns a structured PASS/FAIL verdict with natural language reasoning. Three prompting strategies (minimal zero-shot, schema-driven, chain-of-thought) were compared on structured output reliability, response time, and anomaly detection accuracy. Schema-driven prompting achieved 100% JSON parse success and 100% anomaly detection -- up from 67% and 0% with minimal prompting -- at 1.6s average response time. Cost modeling supports a hybrid architecture: rule-based processing handles bulk volume, LLM review is reserved for flagged cases (10--20% of records) where semantic validation justifies the 8x cost premium.

## Tools & Tech Stack

- **Languages:** Python 3.12
- **Cloud:** AWS Lambda, AWS Bedrock (Claude 3 Haiku), Amazon RDS (PostgreSQL 17)
- **Packages:** `pg8000`, `boto3`, `faker`, `pandas`, `matplotlib`

## What This Demonstrates

Designing and evaluating AI integration architectures under real-world constraints -- not just whether a technology works, but when, for whom, and at what cost.

## Portfolio Page

Full narrative, methodology, results, and architecture recommendation: [kchoover14.github.io/document-validation-bedrock](https://kchoover14.github.io/document-validation-bedrock)

## How to Run

1. Run `schema.sql` to initialize the `audit_logs` table in PostgreSQL
2. Run the mock generator script to create test records (8 valid, 2 flagged)
3. Trigger the Lambda function to process unaudited records and write results back to RDS
4. View audit outcomes in the `audit_logs` table or via the performance visualization script

> **Note on Lambda-to-RDS networking:** Connecting Lambda outside a VPC to a publicly accessible RDS instance will produce `InterfaceError` timeouts. For production, place Lambda inside the same private VPC as RDS and use a NAT Gateway or VPC Endpoints to maintain Bedrock API access.
