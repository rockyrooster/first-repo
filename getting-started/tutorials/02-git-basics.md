# Tutorial 2: Git Basics

**Time**: 30 minutes
**Prerequisites**: Tutorial 1
**Goal**: Understand version control and learn basic git commands

---

## What is Git?

**Git** is a version control system - like "Track Changes" in Microsoft Word, but much more powerful.

### Without Git:
```
my-project.js
my-project-final.js
my-project-final-FINAL.js
my-project-final-FINAL-actually-final.js
my-project-final-v2.js
my-project-DO-NOT-DELETE.js
```

### With Git:
```
my-project.js
(All history saved automatically!)
```

## Why Use Git?

1. **Track Changes**: See what changed, when, and why
2. **Undo Mistakes**: Go back to any previous version
3. **Collaboration**: Work with others without conflicts
4. **Backup**: Your code is safely stored
5. **Experimentation**: Try new ideas without breaking working code

## GitHub vs Git

**Git** = The version control system (runs on your computer)
**GitHub** = Website to store git repositories online (like Google Drive for code)

Think of it like:
- **Git** = Camera
- **GitHub** = Instagram (where you share photos)

## Core Concepts

### 1. Repository (Repo)
A folder that git is tracking. Think of it as a project folder with superpowers.

### 2. Commit
A snapshot of your code at a point in time. Like a save point in a video game.

### 3. Branch
A separate version of your code. Like a parallel universe where you can experiment.

### 4. Remote
A version of your repo stored online (usually on GitHub).

## The Git Workflow

```
1. Make changes to files
   ↓
2. Stage changes (git add)
   ↓
3. Commit changes (git commit)
   ↓
4. Push to GitHub (git push)
```

## Essential Git Commands

### Check Status
See what's changed in your project
```bash
git status
```

**You'll use this ALL THE TIME.** It tells you:
- What files changed
- What's staged for commit
- What branch you're on

### Stage Files
Prepare files to be committed
```bash
git add filename.js          # Add one file
git add .                    # Add all changed files
git add folder/              # Add all files in a folder
```

Think of this as putting items in a shopping cart before checkout.

### Commit Changes
Save a snapshot with a message
```bash
git commit -m "Add user login feature"
```

**Good commit messages:**
- "Fix typo in homepage"
- "Add email validation"
- "Update README with installation steps"

**Bad commit messages:**
- "stuff"
- "changes"
- "asdfasdf"
- "fixed it"

### Push to GitHub
Upload your commits to GitHub
```bash
git push
```

### Pull from GitHub
Download latest changes from GitHub
```bash
git pull
```

### Clone a Repository
Download a repository from GitHub to your computer
```bash
git clone https://github.com/username/repository-name.git
```

## Your First Git Workflow

Let's walk through a complete example:

### Step 1: Check what's changed
```bash
git status
```
Output: `modified: index.html`

### Step 2: Stage the file
```bash
git add index.html
```

### Step 3: Commit with a message
```bash
git commit -m "Update homepage title"
```

### Step 4: Push to GitHub
```bash
git push
```

**Done!** Your changes are now on GitHub.

## Practical Example

Let's say you're building a website:

```bash
# Day 1: Create homepage
git add index.html
git commit -m "Create homepage structure"
git push

# Day 2: Add styling
git add style.css
git commit -m "Add CSS styling for homepage"
git push

# Day 3: Oops, broke something! Go back to Day 2
git log                    # See history
git checkout [commit-id]   # Go back in time
```

## Branches Explained

Branches let you work on new features without breaking the main code.

```
main branch:     A---B---C---D
                      \
feature branch:        E---F---G
```

### Common Branch Commands
```bash
git branch feature-name       # Create a new branch
git checkout feature-name     # Switch to that branch
git checkout -b feature-name  # Create and switch in one command

git branch                    # See all branches
git merge feature-name        # Merge branch into current branch
```

### When to Use Branches
- Trying a new feature
- Fixing a bug
- Experimenting with changes
- Working with others

**Main/Master branch**: Your stable, working code
**Feature branches**: Experimental or in-progress work

## The .gitignore File

Tell git to ignore certain files:

```
# .gitignore example
node_modules/          # Dependencies
.env                   # Secret keys
.DS_Store              # Mac system files
*.log                  # Log files
dist/                  # Build output
```

**Why?** Some files shouldn't be shared:
- Sensitive data (passwords, API keys)
- Generated files (can be recreated)
- Personal settings
- Large files

## Common Scenarios

### Scenario 1: Made a Mistake in Last Commit
```bash
# Fix the file, then:
git add fixed-file.js
git commit --amend -m "New commit message"
```

### Scenario 2: Want to Undo Changes (Not Committed)
```bash
git checkout -- filename.js    # Undo changes to one file
git checkout -- .              # Undo all changes
```

### Scenario 3: Need to See History
```bash
git log                        # See all commits
git log --oneline             # Compact view
```

### Scenario 4: Merge Conflict
When two people edit the same line:

```
<<<<<<< HEAD
Your changes
=======
Their changes
>>>>>>> branch-name
```

**Solution**:
1. Edit the file to keep what you want
2. Remove the `<<<<<<<`, `=======`, `>>>>>>>` markers
3. Save, add, commit

## Best Practices

### 1. Commit Often
Make small, focused commits. Better to have many small commits than one huge one.

```
✅ Good: "Add email validation", "Fix login button", "Update README"
❌ Bad: "Made lots of changes"
```

### 2. Write Clear Messages
Future you (and others) will thank you!

### 3. Pull Before You Push
Always get latest changes before pushing yours:
```bash
git pull
git push
```

### 4. Don't Commit Secrets
NEVER commit passwords, API keys, or sensitive data. Use `.gitignore` and environment variables.

### 5. Use Branches for Features
Keep main branch stable, develop in feature branches.

## Quick Reference

```bash
# Daily Commands (memorize these!)
git status                    # What's changed?
git add .                     # Stage all changes
git commit -m "message"       # Save snapshot
git push                      # Upload to GitHub
git pull                      # Download from GitHub

# Setup (one-time)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Branching
git checkout -b feature-name  # Create & switch to new branch
git checkout main             # Switch back to main
git merge feature-name        # Merge branch into current

# History
git log                       # See commit history
git log --oneline            # Compact history
```

## Common Errors & Solutions

### "fatal: not a git repository"
**Solution**: You're not in a git repository. Run `git init` or `cd` into your repo.

### "Your branch is ahead of 'origin/main'"
**Solution**: You have local commits not pushed yet. Run `git push`.

### "Your branch is behind 'origin/main'"
**Solution**: GitHub has changes you don't. Run `git pull`.

### "Merge conflict"
**Solution**: Edit the file, remove conflict markers, then add and commit.

## Practice Exercise

Try this yourself:

1. Create a new folder
```bash
mkdir my-first-repo
cd my-first-repo
```

2. Initialize git
```bash
git init
```

3. Create a file
```bash
echo "# My First Repo" > README.md
```

4. Check status
```bash
git status
```

5. Stage and commit
```bash
git add README.md
git commit -m "Initial commit"
```

6. Create a GitHub repo and push (follow GitHub's instructions)

## What You've Learned

- [ ] What version control is and why it matters
- [ ] Difference between Git and GitHub
- [ ] Basic workflow: add, commit, push
- [ ] How to check status and view history
- [ ] What branches are and when to use them
- [ ] How to write good commit messages
- [ ] What .gitignore is for

## Next Steps

1. Practice the basic workflow with a test project
2. Create a GitHub account if you haven't
3. Make your first commit to this repository!
4. Move on to Tutorial 3: Choosing Your Path

---

**Next Tutorial**: [03-web-basics.md](./03-web-basics.md) - Start building for the web

---

**Pro Tip**: Type `git status` after every command while learning. It helps you understand what each command does!

Remember: Git takes practice. Don't worry about memorizing everything - you'll use these commands so often they'll become second nature! 🚀
