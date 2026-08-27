# Global agent instructions

- Do not use `find` or `grep` for file discovery or text searching.
- Use `fd` (`fd-find`) for file discovery.
- Use `rg` (`ripgrep`) for text searching.
- Leave changes unstaged and do not commit unless explicitly told to.
- If committing, use a brief one- or two-sentence description of the changes; add a longer description only when needed. Brevity is valued.
- Do not add agent-related metadata to commit messages.
- In projects, put agent skills in `.agents/skills` and project prompts in `AGENTS.md`, unless there's already `CLAUDE.md` or some other agent-specific config being used there; prefer generic agent config over Pi-specific repo config.
