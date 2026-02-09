# Git Cheatsheet

Quick reference for common git commands. Print this out or keep it handy!

## Daily Commands (Use These All The Time)

```bash
git status                  # What's changed?
git add .                   # Stage all changes
git commit -m "message"     # Save snapshot
git push                    # Upload to GitHub
git pull                    # Download from GitHub
```

## Setup (One-Time)

```bash
# Configure your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Check configuration
git config --list

# Initialize a new repository
git init

# Clone existing repository
git clone https://github.com/username/repo.git
```

## Staging Changes

```bash
git add filename.txt        # Stage one file
git add .                   # Stage all changes
git add *.js               # Stage all .js files
git add folder/            # Stage entire folder

git reset filename.txt     # Unstage a file
git reset                  # Unstage everything
```

## Committing

```bash
git commit -m "message"              # Commit with message
git commit -am "message"             # Add & commit (tracked files only)
git commit --amend -m "new message"  # Change last commit message

# Multi-line commit
git commit -m "Title" -m "Description line 1" -m "Line 2"
```

## Viewing Information

```bash
git status                 # Current state
git log                    # Commit history
git log --oneline         # Compact history
git log --graph           # Visual branch history
git diff                  # Changes not staged
git diff --staged         # Changes staged
git show                  # Last commit details
```

## Branches

```bash
git branch                    # List branches
git branch feature-name       # Create branch
git checkout feature-name     # Switch to branch
git checkout -b feature-name  # Create & switch
git branch -d feature-name    # Delete branch (safe)
git branch -D feature-name    # Force delete

git merge feature-name        # Merge branch into current
```

## Remote Operations

```bash
git remote -v                          # List remotes
git remote add origin <url>            # Add remote
git push origin main                   # Push to main
git push -u origin feature-name        # Push new branch
git pull origin main                   # Pull from main
git fetch                              # Download without merging
```

## Undoing Changes

```bash
# Discard changes (not committed)
git checkout -- filename.txt   # Undo changes to one file
git checkout -- .             # Undo all changes

# Undo commits
git reset --soft HEAD~1       # Undo last commit, keep changes
git reset --hard HEAD~1       # Undo last commit, discard changes
git revert <commit-id>        # Create new commit that undoes changes

# Unstage
git reset HEAD filename.txt   # Unstage a file
git reset                     # Unstage all
```

## Stashing (Temporary Save)

```bash
git stash                     # Save changes temporarily
git stash list                # List stashes
git stash pop                 # Apply and remove last stash
git stash apply               # Apply last stash, keep it
git stash drop                # Delete last stash
git stash clear               # Delete all stashes
```

## Viewing Differences

```bash
git diff                      # Changes not staged
git diff --staged             # Changes staged for commit
git diff main feature         # Compare branches
git diff <commit1> <commit2>  # Compare commits
```

## GitHub Specific

```bash
# First time pushing to GitHub
git remote add origin https://github.com/user/repo.git
git branch -M main
git push -u origin main

# Pull request workflow
git checkout -b feature-branch
# Make changes
git add .
git commit -m "Add feature"
git push -u origin feature-branch
# Then create PR on GitHub
```

## Useful Aliases

Add these to make git easier:

```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'

# Now you can use:
git co main        # instead of git checkout main
git st             # instead of git status
```

## .gitignore Patterns

```
# Ignore specific file
secret.txt

# Ignore all files with extension
*.log

# Ignore folder
node_modules/

# Ignore folder contents but not folder
folder/*
!folder/.gitkeep

# Ignore in all directories
**/*.log
```

## Common Workflows

### Starting a New Project
```bash
mkdir my-project
cd my-project
git init
echo "# My Project" > README.md
git add README.md
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/user/my-project.git
git push -u origin main
```

### Daily Development
```bash
git pull                    # Get latest changes
# Make your changes
git status                  # See what changed
git add .                   # Stage changes
git commit -m "message"     # Commit
git push                    # Push to GitHub
```

### Feature Branch Workflow
```bash
git checkout main
git pull
git checkout -b feature-name
# Make changes
git add .
git commit -m "Add feature"
git push -u origin feature-name
# Create pull request on GitHub
# After PR merged:
git checkout main
git pull
git branch -d feature-name
```

### Fixing a Mistake
```bash
# Made changes, haven't committed
git checkout -- .           # Discard all changes

# Committed but haven't pushed
git reset --soft HEAD~1     # Undo commit, keep changes
# Fix the changes
git add .
git commit -m "corrected message"

# Already pushed (be careful!)
git revert <commit-id>      # Creates new commit that undoes
git push
```

## Emergency Commands

### Abort a Merge
```bash
git merge --abort
```

### Recover Deleted Branch (recent)
```bash
git reflog                  # Find the commit
git checkout -b branch-name <commit-id>
```

### Undo git add
```bash
git reset
```

## Tips

### Check Before You Commit
```bash
git status                  # What will be committed?
git diff --staged          # Review exact changes
```

### Good Commit Messages
```
✅ Good:
- "Fix login button alignment"
- "Add user profile page"
- "Update README with setup steps"

❌ Bad:
- "stuff"
- "changes"
- "fix"
- "Update"
```

### When to Commit
- After completing a logical unit of work
- Before trying something risky
- At the end of your work session
- When tests pass

## Getting Help

```bash
git help <command>          # Full help
git <command> --help        # Same as above
git <command> -h            # Quick help
```

## Remember

- **Commit often**: Small commits are better than big ones
- **Pull before push**: Always get latest changes first
- **Branch for features**: Keep main/master stable
- **Write clear messages**: Future you will thank present you

---

**Print this out or bookmark it!** You'll reference this constantly when starting out. 📄✨
