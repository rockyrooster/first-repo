# 🔧 Shared Resources

Code, configurations, and utilities that you reuse across multiple projects.

## What Goes Here

This folder contains resources that are useful across different projects:
- Configuration files
- Reusable code snippets
- Templates
- Scripts and utilities
- Documentation

## Folder Structure

```
shared/
├── configs/
│   ├── model-configs/    ← AI model configurations
│   ├── linting/          ← Code quality tools config
│   └── testing/          ← Test configurations
├── templates/            ← Reusable project templates
├── scripts/              ← Utility scripts
├── docs/                 ← Shared documentation
└── README.md             ← You are here
```

## Why Use Shared Resources?

### Don't Repeat Yourself (DRY)
Write once, use everywhere. If you find yourself copying code between projects, put it here.

### Consistency
Use the same configurations and patterns across all projects.

### Efficiency
Spend less time on setup, more time on building.

## What to Put Here

### ✅ Good Candidates for Shared/
- Linting configs (ESLint, Prettier)
- Git ignore templates
- Testing configurations
- CI/CD pipeline templates
- Common utility functions
- Project starter templates
- Documentation templates

### ❌ Don't Put Here
- Project-specific code
- Sensitive data (passwords, keys)
- Large dependencies
- Temporary/experimental code

## configs/ Directory

Store configuration files for tools you use:

### model-configs/
Configuration for AI models:
- Claude Sonnet settings
- Claude Opus settings
- Claude Haiku settings
- Prompt templates

### linting/
Code quality configurations:
- `.eslintrc.json` - JavaScript linting
- `.prettierrc` - Code formatting
- `.pylintrc` - Python linting

### testing/
Test framework configurations:
- Jest config
- Pytest config
- Testing best practices

## templates/ Directory

Starter templates for quick project setup:
- Basic web app
- React app starter
- Node.js API
- README templates

## scripts/ Directory

Automation scripts you use across projects:
- Deployment scripts
- Build automation
- Data processing
- Backup utilities

## docs/ Directory

Documentation that applies to multiple projects:
- Coding standards
- Git workflow
- Deployment processes
- API documentation templates

## Example: Reusable Code Pattern

If you notice you're writing this in every project:

```javascript
// Fetch data with error handling
async function fetchData(url) {
    try {
        const response = await fetch(url);
        if (!response.ok) throw new Error('Network error');
        return await response.json();
    } catch (error) {
        console.error('Fetch failed:', error);
        return null;
    }
}
```

**Put it in shared/** so you can import it anywhere!

## How to Use Shared Resources

### Option 1: Copy
Copy the file into your project and customize.

### Option 2: Link
Create a symbolic link to use the shared file directly.

### Option 3: Import
If you're using a module system, import from shared.

## Best Practices

### 1. Document Everything
Every file should have comments explaining what it does and how to use it.

### 2. Keep It Generic
Shared code should work in multiple contexts, not be project-specific.

### 3. Version Control
Track changes to shared resources carefully - changes affect all projects.

### 4. Test Before Sharing
Make sure it works before making it shared.

### 5. Maintain
Regularly update and improve shared resources.

## Getting Started

1. **Start simple**: Don't over-architect. Add things here as you discover patterns.
2. **Extract, don't predict**: Move code here when you've used it 2-3 times, not before.
3. **Document well**: Future you will forget why you created something.
4. **Iterate**: Improve shared resources based on real usage.

## Common Shared Configs

### .gitignore Template
```
# Dependencies
node_modules/
venv/

# Environment variables
.env
.env.local

# Build output
dist/
build/
*.pyc

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
```

### .prettierrc (Code Formatting)
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

### ESLint Config (.eslintrc.json)
```json
{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": 12
  }
}
```

## Next Steps

1. Add your first shared config (maybe a .gitignore)
2. As you work on projects, identify reusable patterns
3. Extract them here for future use
4. Document how to use them

**Remember**: Good developers don't reinvent the wheel - they build a library of wheels to reuse! 🚀
