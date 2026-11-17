## R and Quarto Workflow
- This repository contains R scripts and Quarto (`.qmd`) documents.
- Use the `r-mcptools` MCP server to execute R code, verify data transformations, and run tests (`testthat::test_local()`).
- Use the `quarto-cli` MCP server (or `quarto render` in the terminal) to verify that `.qmd` files render without errors before finalizing a pull request.
