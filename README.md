# Challenges

This is where I track miscellaneous programming challenges I've played with:

- Individual challenges have their own dedicated subfolders, ex [`toy-robot`](https://github.com/christhekeele/challenges/tree/latest/toy-robot).
  - Each challenge has a `README.md` describing the problem.
  - Each challenge contains a project seed as a starting point, described in the `README.md`.
- The `latest` branch contains only the project seeds, so you can try to solve them yourself without peeking at my answer!
- Each project has a dedicated branch named after its subfolder, ex `toy-robot`, where I check in my own attempts at solutions.

### Try them yourself!

There are two quick ways to get try these challenges:

1. Fork this repository

   This has the advantage of letting you try all of them, follow any updates I make to the project, and compare your answer with others.

   When you start a challenge, be sure to follow the convention of making your commits to an individual project in a branch named after the project!

2. Clean copies

   If you want to get a clean seed of a single project, without pre-existing git history of my attempts, you can perform a shallow checkout of just a desired challenge.
   For example, to get the just the `toy-robot` challenge:

   ```sh
   export CHALLENGE="toy-robot" # or whatever branch your solution lives in

   git clone --depth 1 --filter=blob:none --sparse https://github.com/christhekeele/challenges.git christhekeele-challenges
   cd christhekeele-challenges
   git sparse-checkout add $CHALLENGE
   cd ..
   mv christhekeele-challenges/$CHALLENGE .
   rm -rf christhekeele-challenges
   cd $CHALLENGE
   git init
   git add -A
   git commit -m "Initial commit."
   ```

### Share your solution!

If you want to show off your solution, submit a PR from your fork that adds a link to your solution in the challenge's `SOLUTIONS.md` file!

A nice way to showcase your implementation is to generate a link to a github comparison. For example, if you have solved `toy-robot`:

```sh
export REMOTE="origin"                     # or whatever you named your fork's remote
export CHALLENGE="toy-robot"               # or whatever branch your solution lives in
export GH_USERNAME="@your-github-username"

# Ensure your fork is up-to-date
git checkout $CHALLENGE && git push $REMOTE $CHALLENGE
# Add your fork's upstream in a remote named "source"
git remote add source https://github.com/christhekeele/challenges.git
# Ensure source history is up-to-date
git checkout latest && git pull
# Find where your solution diverged from the project seed
export LAST_COMMON_COMMIT=$(git merge-base --octopus latest $CHALLENGE)
# Add a link to your solution comparison in SOLUTIONS.md
echo "- [$GH_USERNAME](https://github.com/christhekeele/challenges/compare/$LAST_COMMON_COMMIT...$GH_USERNAME:$CHALLENGE)" >> $(git rev-parse --show-toplevel)/$CHALLENGE/SOLUTIONS.md
#
```

## Index of Challenges

- **[`toy-robot`](https://github.com/christhekeele/challenges/tree/latest/toy-robot)**

  Parse a series of commands to drive a toy robot around.

  Project seed comes with a setup to develop your solution as an Elixir CLI, and even a TUI should you wish!

  My solution [here](https://github.com/christhekeele/challenges/compare/toy-robot).
