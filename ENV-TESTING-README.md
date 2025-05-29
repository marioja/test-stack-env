# Environment Variable Testing Documentation

## Overview
This Docker Compose stack provides focused testing of 5 key environment variable patterns across 4 different sources commonly used in Docker Compose and Portainer deployments.

## Environment Variable Sources

### 1. `.env` (Root Directory)
- **File**: `.env`
- **Loading**: Automatically loaded by Docker Compose from project root
- **Test Variables**: `dotenv_sub`, `dotenv_hard`, `dotenv_undeclared`

### 2. `stack.env` 
- **File**: `stack.env`
- **Loading**: Explicitly loaded via `env_file` directive
- **Test Variables**: `stackenv_sub`, `stackenv_hard`, `stackenv_undeclared`

### 3. `env/staging.env`
- **File**: `env/staging.env`
- **Loading**: Test if it is loaded in any automatic way by portainer
- **Test Variables**: `stagingenv_sub`, `stagingenv_hard`, `stagingenv_undeclared`

### 4. Portainer UI Variables
- **Files**: `portainer-simulation.env` (for copy/paste into the Portainer UI)
- **Loading**: Simulates variables set via Portainer UI or loaded from portainer-simulation.env
- **Test Variables**: `portainer_sub`, `portainer_hard`, `portainer_undeclared`

## Test Patterns

Each source tests exactly 4 patterns, plus 1 global missing test:

### Pattern 1: Empty Value
Variables defined with no value to test Docker Compose empty value handling:
- `dotenv_empty:`
- `stackenv_empty:`
- `stagingenv_empty:`
- `portainer_empty:`

### Pattern 2: Variable Substitution
Variables using `${variable}` substitution from source files:
- `dotenv_sub: "${dotenv_sub}"`
- `stackenv_sub: "${stackenv_sub}"`
- `stagingenv_sub: "${stagingenv_sub}"`
- `portainer_sub: "${portainer_sub}"`

### Pattern 3: Hard-Coded Values
Variables with literal string values set directly in compose file:
- `dotenv_hard: "hard"`
- `stackenv_hard: "hard"`
- `stagingenv_hard: "hard"`
- `portainer_hard: "hard"`

### Pattern 4: Undeclared but Defined
Variables that exist in source files but are NOT declared in environment section:
- `dotenv_undeclared` (in .env only)
- `stackenv_undeclared` (in stack.env only)
- `stagingenv_undeclared` (in staging.env only)
- `portainer_undeclared` (in portainer files only)

### Pattern 5: Missing Variable (Global Test)
One test for variables missing from ALL sources:
- `missing_test: "${missing_var}"` (missing_var not defined anywhere)

## Running the Test

### Local Development
```bash
# Run with specific environment  
EIAB_ENV=staging docker-compose up

# Run with production environment
EIAB_ENV=prod docker-compose up
```

### Portainer Deployment
1. Copy variables from `portainer-simulation.env`
2. Paste into Portainer stack environment variables section
3. Deploy the stack

## Expected Output Format

```
=== .env file tests ===
dotenv_empty=[]
dotenv_sub=[dotenv-sub-value]
dotenv_hard=[hard]
dotenv_undeclared=[dotenv-undeclared-value] (exists in .env but not in environment section)

=== stack.env file tests ===
stackenv_empty=[]
stackenv_sub=[stackenv-sub-value]
stackenv_hard=[hard]
stackenv_undeclared=[stackenv-undeclared-value] (exists in stack.env but not in environment section)

=== env/staging.env file tests ===
stagingenv_empty=[]
stagingenv_sub=[stagingenv-sub-value]
stagingenv_hard=[hard]
stagingenv_undeclared=[stagingenv-undeclared-value] (exists in staging.env but not in environment section)

=== Portainer UI simulation tests ===
portainer_empty=[]
portainer_sub=[portainer-sub-value]
portainer_hard=[hard]
portainer_undeclared=[portainer-undeclared-value] (exists in portainer-simulation.env but not in environment section)

=== Missing variable test ===
missing_test=[] (missing_var not defined in any source)
```

## Key Testing Insights

- **Empty values** show how Docker Compose handles unset environment variables
- **Substitution** tests variable resolution from different file sources
- **Hard-coded** values demonstrate compose-level overrides
- **Undeclared** variables reveal env_file vs environment section behavior
- **Missing** variables show error handling for undefined references

## Variable Naming Convention

- Format: `source_purpose` (e.g., `dotenv_sub`, `stackenv_hard`)
- Same variable names used in both source files and docker-compose environment section
- Simple, consistent naming across all tests
