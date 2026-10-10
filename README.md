Home-cookinng
===============

Repository for SQL Server schema and example queries for a simple home-cooking app.

Contents
- /sql/schema/CreateTables.sql — example CREATE TABLE scripts (edit before running)
- /sql/queries/ExampleQueries.sql — example SELECTs, joins, aggregates, paging

Notes
- These scripts contain DDL and should NOT be executed on a production server without review.
- Replace placeholder values (license owner, timestamps) before publishing.

Quick local setup (PowerShell)
1. Initialize git repository:
   git init
   git add .
   git commit -m "Initial commit: SQL schema and examples"

2a. Create a remote and push using GitHub CLI (recommended):
   # install gh and authenticate: gh auth login
   gh repo create Home-cookinng --public --source . --remote origin --push

2b. Or create remote manually on GitHub and push:
   git remote add origin https://github.com/UsagiDirt/Home-cookinng.git
   git branch -M main
   git push -u origin main

This README uses `UsagiDirt` as the repository owner in the example remote URL.
