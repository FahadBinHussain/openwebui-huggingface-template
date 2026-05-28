---
title: Open WebUI Hugging Face Template
sdk: docker
app_port: 7860
license: mit
---

# Open WebUI Hugging Face Template

Thin wrapper around the official Open WebUI Docker image.

[Live Space](https://bequietambient-ai.hf.space/) · [Hugging Face repo](https://huggingface.co/spaces/bequietambient/ai)

- Upstream Open WebUI stays untouched.
- Hugging Face uses the same wrapper files as local Docker.
- Secrets stay in environment variables, not in this repo.
- Runtime data defaults to `/data/open-webui`, which fits Hugging Face persistent storage.
- LiteLLM can be attached through Open WebUI's OpenAI-compatible connection env vars.

## Local

Build the wrapper image:

```powershell
docker build -t openwebui-huggingface-template .
```

Run it locally:

```powershell
docker run --rm -p 3000:7860 --env-file .env.local openwebui-huggingface-template
```

Keep `.env.local` uncommitted. Use it for values such as `WEBUI_SECRET_KEY`, `OPENAI_API_BASE_URLS`, and `OPENAI_API_KEYS`.

## Hugging Face

Upload this folder to a Docker Space:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:\Users\Admin\Downloads\mainframe\hf-account.ps1 run bequietambient@gmail.com upload bequietambient/ai . --type space
```

Set secrets and variables in the Space settings. At minimum, set a stable `WEBUI_SECRET_KEY`; without persistent storage, generated keys and SQLite data will not survive rebuilds.

This Space mounts the private bucket `hf://buckets/bequietambient/ai-data:/data`, so Open WebUI state under `/data/open-webui` survives normal restarts and rebuilds.

The live Space is connected to the LiteLLM Hugging Face proxy through Open WebUI's OpenAI-compatible variables:

```text
OPENAI_API_BASE_URLS=https://awdafw-litellm-huggingface-template.hf.space/v1
OPENAI_API_KEYS=sk-placeholder
```

The placeholder key is intentional for the current LiteLLM Space because the proxy is not enforcing a `LITELLM_MASTER_KEY`.

For a fresh instance, keep `ENABLE_SIGNUP=true` until the first account is created. Open WebUI promotes the first account to admin, then signup can be disabled from the admin panel or by changing the Space variable.

## Notes

Open WebUI's official Docker examples expose container port `8080`; this wrapper sets `PORT=7860` so Hugging Face can route the Space directly. The wrapper still starts Open WebUI through its upstream `/app/backend/start.sh`.
