/**
 * Speak when opencode asks to run something.
 *
 * The counterpart of the Claude Code Notification hook: Zundamon says a short
 * phrase whenever a permission prompt appears, so you notice it without
 * watching the terminal.
 *
 * Deliberately uses Bun.spawn rather than the plugin's `$` shell. Bun Shell has
 * no `command` builtin, which is exactly the trap that makes opencode-tts
 * report "No audio player found" on Linux -- no reason to walk into it here.
 *
 * The speak command is detached and never awaited: a permission prompt must not
 * wait on audio. Failures are swallowed on purpose -- TTS must never interfere
 * with answering a prompt.
 */
const SPEAK = `${process.env.HOME}/.local/bin/claude-tts-speak`
const PHRASE = process.env.OPENCODE_TTS_ASK_PHRASE ?? "コマンドの確認をお願いするのだ。"

export const ZundamonPermission = async () => ({
  "permission.ask": async (_input, _output) => {
    // NOTE: _output.status is intentionally left alone. Writing to it would
    // auto-answer the prompt; this hook only announces it.
    try {
      Bun.spawn([SPEAK, "--text", PHRASE], {
        stdin: "ignore",
        stdout: "ignore",
        stderr: "ignore",
      }).unref()
    } catch {
      // no audio is fine; blocking the prompt is not
    }
  },
})
