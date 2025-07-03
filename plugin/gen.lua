require('gen').setup({
  host = os.getenv("OLLAMA_ENDPOINT") or "localhost",
  model = "devstral:24b",
  display_mode = "vertical-split",
  show_prompt = true,
  file = true,
  no_auto_cose = true
})
