# Global agent instructions

- Do not use `find` or `grep` for file discovery or text searching.
- Use `fd` (`fd-find`) for file discovery.
- Use `rg` (`ripgrep`) for text searching.
- Leave changes unstaged and do not commit unless explicitly told to.
- If committing, use a brief one- or two-sentence description of the changes; add a longer description only when needed. Brevity is valued.
Do not add agent-related metadata to commit messages.
- In projects, put agent skills in `.agents/skills` and project prompts in `AGENTS.md`, unless there's already `CLAUDE.md` or some other agent-specific config being used there; prefer generic agent config over Pi-specific repo config.

## Code writing tips

- Code should be idiomatic for the language its written in
- Do not write long comments. Add comments only when necessary to clear up confusion, and keep them as brief as possible.
Do not comment on obvious code. Public doc comments are allowed, but do not state the obvious; if the function is self-describing, keep the description very short. \
Assume readers can see the function signature, surrounding patterns, package APIs, and other doc comments. Avoid repeating the same information across comments.
- Code should be simple and intelligible. Collapse unnecessary complexity and unneeded abstractions.
- Match the convention of the surrounding codebase
