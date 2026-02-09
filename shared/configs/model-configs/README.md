# AI Model Configurations

Configuration and notes for different Claude models to help you choose the right one for your task.

## Available Models

### Claude Sonnet 4.5
**Best for**: Most development tasks
- ⚖️ Balanced performance and speed
- 💰 Cost-effective for regular use
- ⚡ Fast responses
- 🎯 Good for: General coding, debugging, code reviews

**When to use:**
- Daily development work
- Code reviews and refactoring
- Learning and tutorials
- Most web development tasks

### Claude Opus 4.6
**Best for**: Complex problems and deep thinking
- 🧠 Most capable model
- 🎯 Best reasoning and problem-solving
- ⏱️ Slower but more thorough
- 💎 Premium option

**When to use:**
- Complex architecture decisions
- Difficult bugs that stump other models
- System design and planning
- When you need the best possible answer

### Claude Haiku 4.5
**Best for**: Quick, simple tasks
- ⚡ Fastest responses
- 💰 Most cost-effective
- ✅ Great for straightforward tasks
- 🎯 Good for: Simple edits, quick questions

**When to use:**
- Simple code edits
- Quick questions
- Repetitive tasks
- When speed matters most

## Model Comparison

| Feature | Haiku | Sonnet | Opus |
|---------|-------|--------|------|
| Speed | ⚡⚡⚡ | ⚡⚡ | ⚡ |
| Cost | 💰 | 💰💰 | 💰💰💰 |
| Capability | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Best for | Simple | General | Complex |

## Usage Tips

### Start with Sonnet
Unless you know you need something else, Sonnet is the best default choice.

### Switch to Opus when:
- Sonnet struggles with a problem
- You need very high-quality code
- Architecture and design decisions
- Complex debugging

### Switch to Haiku when:
- Making simple edits
- Asking quick questions
- Doing repetitive tasks
- Working with tight budgets

## How to Switch Models

In Claude Code, you can specify the model when creating tasks or use the default for your session.

## Examples by Task Type

### Web Development
- **Simple HTML/CSS changes**: Haiku
- **React component creation**: Sonnet
- **Complex state management**: Opus

### Backend Development
- **CRUD endpoints**: Sonnet
- **API design**: Opus
- **Simple database queries**: Haiku

### Debugging
- **Syntax errors**: Haiku
- **Logic bugs**: Sonnet
- **Complex system issues**: Opus

### Learning
- **Quick syntax questions**: Haiku
- **Tutorial following**: Sonnet
- **Deep concept explanation**: Opus

## Cost Optimization

### Be Strategic
- Use Haiku for simple tasks (saves money)
- Use Sonnet for most work (best value)
- Reserve Opus for when you really need it

### Batch Similar Tasks
Group similar simple tasks together and use Haiku for all of them.

### Learn to Prompt
Better prompts get better results from less capable models, saving you money.

## Experiment!

Use the `experiments/model-testing/` folder to try the same task with different models and see which works best for your needs.

## Remember

The "best" model is the one that:
- ✅ Solves your problem
- ✅ Does it in reasonable time
- ✅ Fits your budget

Don't overthink it - you can always try a different model if one isn't working well! 🚀
