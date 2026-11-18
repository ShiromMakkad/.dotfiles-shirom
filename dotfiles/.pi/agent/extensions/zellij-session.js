import { execFileSync } from "node:child_process";

export default function (pi) {
  pi.on("session_start", (_event, ctx) => {
    const paneId = process.env.ZELLIJ_PANE_ID;
    const sessionFile = ctx.sessionManager.getSessionFile();
    if (!process.env.ZELLIJ || !paneId || !ctx.hasUI || !sessionFile) return;

    execFileSync("zellij", [
      "action", "set-resurrect-command", "--pane-id", paneId,
      "--cwd", ctx.cwd, "--", "bash", "-c",
      '"$@"; "${SHELL:-/bin/bash}"; zellij action close-pane --pane-id "$ZELLIJ_PANE_ID"', "zellij-resume",
      "pi", "--session", sessionFile,
    ]);
  });
}
