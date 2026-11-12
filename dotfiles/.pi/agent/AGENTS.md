# Global agent instructions

- Do not use `find` or `grep` for file discovery or text searching.
- Use `fd` (`fd-find`) for file discovery.
- Use `rg` (`ripgrep`) for text searching.
- Leave changes unstaged and do not commit unless explicitly told to.
- If committing, use a brief one- or two-sentence description of the changes; add a longer description only when needed. Brevity is valued.
Do not add agent-related metadata to commit messages.
- In projects, put agent skills in `.agents/skills` and project prompts in `AGENTS.md`, unless there's already `CLAUDE.md` or some other agent-specific config being used there; prefer generic agent config over Pi-specific repo config.
- Keep commands simple. For example, if you can run a `terraform` command with many flags that perfectly scopes the action to what you ask, versus running a more commonly run terraform command with less flags. Default towards the less flags.
You should have the least flags/complexity in the command as needed, because less complexity improves readability. Of course, if flags are needed, use them. If performance or security (like scoping a command to not read a private directory) is an issue, then use flags.
But using flags to save a few seconds, but increasing complexity is not worth it. Know that increased complexity/poor understandability carries a cost just like performance and security. 
- Do not read or manipulate secrets. Writing/reading secret parsing code is fine, but don't read raw secrets/passwords. This can end up in your training data or be leaked. Ask for approval very explicitly if needed. 
Generating secrets using an external command, but you can't/won't read the output is okay. The goal is to prevent secrets from getting sent anywhere besides the intended destination, including to the servers that run the AI. 

## Code writing tips

- Code should be idiomatic for the language its written in
- Do not write long comments. Add comments only when necessary to clear up confusion, and keep them as brief as possible.
Do not comment on obvious code. Public doc comments are allowed, but do not state the obvious; if the function is self-describing, keep the description very short. \
Assume readers can see the function signature, surrounding patterns, package APIs, and other doc comments. Avoid repeating the same information across comments.
- Code should be simple and intelligible. Collapse unnecessary complexity and unneeded abstractions.
- Match the convention of the surrounding codebase
- When testing, you should focus on maintaining branch coverage. Certainly there are more checks that could be done. For example, something like an integer overflow error wouldn't be covered under branch coverage.
But start from a place of branch coverage and ask yourself why more cases need to be added. What kind of future change to the codebase could cause this test to fail. If that change is already covered by other tests in the unit, no need to add it.
Too many tests can overindex and make refactoring more difficult. 


### The smallest complete change (from https://github.com/DietrichGebert/ponytail/blob/main/skills/ponytail/SKILL.md)
Take the first option that fully works:

1. Does it need to exist? Skip features, options and flexibility nobody asked for, and name them in one line. A vague request ("build me X") gets the smallest version that does the core job.
2. Already in this codebase (a helper, component, service, pattern)? Use it the way the surrounding code does.
3. Standard library or a platform feature? Use it, unless the project has its own. A house component beats a native widget.
4. An installed dependency? Use it. Never add a dependency for a few lines.
5. Can it be one line a reader gets at a glance? One line.
6. Otherwise: the minimum code that works. 
7. Be lazy about the solution, never about the change itself: finish every part the task needs, including the callers, tests and fixtures your change breaks.
8. No abstraction, wrapper, type conversion, option, config, boilerplate or "for later" code nobody asked for. Keep values in the form the platform already gives you. Deletion beats addition. Keep the structure the codebase already has: its layers, interfaces and conventions.
9. The shortest working diff wins, once you know everything it must touch. A one-liner that needs decoding is not short.
10. Comment only the what the code cannot show.
11. Bug fix: fix the root cause once in the shared code. You can search for callers of the function you touch, but keep in mind when code crosses team/organizational boundaries.
Some code is not under the author's control and can cause extra friction to get approved/merged. Call this out. 
12. Code you move or merge keeps its error handling and validation.
13. Between options of equal size, take the one that is correct on edge cases.
14. Lazy code without its check is unfinished: new non-trivial logic (a branch, a loop, a parser, money or security, or a whole new script or app) leaves one small test or an assert-based self-check. Trivial changes need none.
15. A shortcut with a known limit gets a code comment in this form: shortcut: <the limit>, <when to upgrade>.
16. Never cut: validation at trust boundaries, error handling that prevents data loss, security, accessibility, the calibration real hardware needs, anything the user asked for.


