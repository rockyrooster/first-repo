# 📝 Documentation

Central hub for project documentation, guides, and architecture decisions.

## What Goes Here

This folder is for documentation that helps you (and others) understand your projects:
- Setup guides
- Architecture decisions
- API documentation
- Development workflows
- Project guidelines

## Folder Structure

```
docs/
├── guides/           ← How-to guides and tutorials
├── architecture/     ← System design and decisions
└── README.md         ← You are here
```

## Why Document?

### For Future You
In 6 months, you'll forget why you built something a certain way. Documentation helps you remember.

### For Collaboration
If others join your projects, they need to understand how things work.

### For Learning
Writing explanations helps you understand concepts better.

### For Debugging
Good docs help you troubleshoot faster.

## What to Document

### Setup Instructions
How to get a project running:
```markdown
# Project Setup

## Prerequisites
- Node.js 18+
- Git
- VS Code (recommended)

## Installation
1. Clone the repository
2. Run `npm install`
3. Copy `.env.example` to `.env`
4. Run `npm start`
```

### Architecture Decisions
Why you made certain choices:
```markdown
# Architecture Decision: Using React

## Context
Need to build an interactive dashboard

## Decision
Use React instead of vanilla JavaScript

## Reasoning
- Component reusability
- Large ecosystem
- Good for SPAs

## Consequences
- Larger bundle size
- Need to learn JSX
- Better developer experience
```

### API Documentation
How to use your APIs:
```markdown
# API Endpoints

## GET /api/users
Returns list of users

**Response:**
```json
{
  "users": [
    {"id": 1, "name": "Alice"},
    {"id": 2, "name": "Bob"}
  ]
}
```
```

### Coding Standards
Your personal style guide:
```markdown
# Coding Standards

## Naming Conventions
- Variables: camelCase
- Constants: UPPER_CASE
- Components: PascalCase
- Files: kebab-case.js

## Code Style
- Use async/await over promises
- Add comments for complex logic
- Keep functions under 50 lines
```

## Document Templates

### Project README Template
Every project should have a README:

```markdown
# Project Name

Brief description of what it does.

## Features
- Feature 1
- Feature 2

## Tech Stack
- Frontend: React
- Backend: Node.js
- Database: PostgreSQL

## Getting Started
[Installation steps]

## Usage
[How to use it]

## Screenshots
[Add images if relevant]

## Contributing
[If applicable]

## License
MIT
```

### Architecture Decision Record (ADR)

```markdown
# ADR-001: [Decision Title]

**Date**: YYYY-MM-DD
**Status**: Accepted | Rejected | Superseded

## Context
What's the situation and the problem?

## Decision
What did you decide?

## Consequences
What are the implications?

## Alternatives Considered
What else did you consider?
```

## Documentation Best Practices

### 1. Keep It Simple
Write for beginners (including future you). Use simple language.

### 2. Use Examples
Code examples are worth a thousand words.

```javascript
// Good: Clear example
const user = getUserById(123);

// Instead of just saying "call getUserById with an ID"
```

### 3. Keep It Updated
Outdated docs are worse than no docs. Update when code changes.

### 4. Use Visuals
Diagrams, screenshots, and flowcharts help understanding.

### 5. Be Specific
"Run npm install" is better than "install dependencies"

## Markdown Tips

### Headers
```markdown
# H1 - Main Title
## H2 - Section
### H3 - Subsection
```

### Code Blocks
````markdown
```javascript
const greeting = "Hello World";
```
````

### Lists
```markdown
- Unordered item
- Another item

1. Ordered item
2. Another item
```

### Links
```markdown
[Link text](https://example.com)
[Internal link](../path/to/file.md)
```

### Images
```markdown
![Alt text](./images/screenshot.png)
```

### Tables
```markdown
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |
```

## Common Documentation Files

### In Project Roots
- `README.md` - Overview and setup
- `CONTRIBUTING.md` - How to contribute
- `CHANGELOG.md` - Version history
- `LICENSE` - License information

### In docs/
- `setup-guide.md` - Detailed setup
- `api-reference.md` - API documentation
- `architecture.md` - System design
- `troubleshooting.md` - Common issues

## Documentation Checklist

For each project, ask:
- [ ] Does it have a README?
- [ ] Can someone else set it up from the README?
- [ ] Are complex parts explained?
- [ ] Is the API documented?
- [ ] Are there examples?
- [ ] Is it up to date?

## Tools for Better Docs

### Markdown Editors
- VS Code (with Markdown Preview)
- Typora
- MarkText

### Diagram Tools
- [Excalidraw](https://excalidraw.com/) - Hand-drawn style
- [Draw.io](https://app.diagrams.net/) - Flowcharts
- [Mermaid](https://mermaid.js.org/) - Text-based diagrams

### Screenshot Tools
- Built-in OS tools (Cmd+Shift+4 on Mac, Win+Shift+S on Windows)
- Annotate with Preview/Paint

## Example Documentation Structure

```
my-web-app/
├── README.md                  ← Start here
├── docs/
│   ├── setup-guide.md         ← Detailed setup
│   ├── architecture.md        ← How it's built
│   ├── api.md                 ← API docs
│   ├── deployment.md          ← How to deploy
│   └── troubleshooting.md     ← Common issues
├── src/
│   └── [code with inline comments]
└── tests/
    └── [test files that document behavior]
```

## When to Write Documentation

### Write Before Coding
- Requirements
- Architecture decisions
- API design

### Write While Coding
- Inline comments for complex logic
- Function/class documentation
- TODO comments

### Write After Coding
- README
- Setup guides
- Usage examples

## Remember

> "Code tells you how, comments tell you why, docs tell you what."

Good documentation is a gift to your future self and others. It doesn't have to be perfect - something is better than nothing!

Start small: add a README to your next project. Then build from there. 📚
