# Challenges

> **_Various programming challenges._**

## Synopsis

This is where I track miscellaneous programming challenges I've played with:

- Individual challenges have their own dedicated subfolders, ex [`toy-robot`](https://github.com/christhekeele/challenges/tree/latest/toy-robot).
  - Each challenge has a `README.md` describing the problem.
  - Each challenge contains a project seed as a starting point, described in the `README.md`.
- The `latest` branch contains only the project seeds, so you can try to solve them yourself without peeking at my answer!
- Each project has a dedicated branch named after its subfolder, ex `toy-robot`, where I check in my own attempts at solutions.

If you want to get a clean project seed without any history of my attempts, you can perform a shallow checkout of just a desired challenge.
For example, to get the just the `toy-robot` challenge:

```sh
export CHALLENGE=toy-robot
git clone --depth 1 --filter=blob:none --sparse https://github.com/christhekeele/challenges.git christhekeele-challenges
cd christhekeele-challenges
git sparse-checkout add $CHALLENGE
cd ..
mv christhekeele-challenges/$CHALLENGE .
rm -rf christhekeele-challenges
```

## List of Challenges

- **[`toy-robot`](https://github.com/christhekeele/challenges/tree/latest/toy-robot)**

  Parse a series of commands to drive a toy robot around.

  Project seed comes with a setup to develop your solution as an Elixir CLI, and even a TUI should you wish!
