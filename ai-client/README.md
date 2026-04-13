# ai-client

Simple containerized AI client environment for working with attached repositories.

---

## Environment variables

Before running the container:

1. Create a `.ai_env` file in the project root
2. Add the required variables, especially `ANTHROPIC_API_KEY`

Example:

```bash
ANTHROPIC_API_KEY=your_api_key_here
```

This variable is required for the AI client to work correctly.

### Optional: export globally in your shell

If you want to make the key available in your host shell as well, run:

```bash
export ANTHROPIC_API_KEY=your_api_key_here
```

To make it persistent across terminal sessions:

Linux
```bash
echo 'export ANTHROPIC_API_KEY=your_api_key_here' >> ~/.bashrc
source ~/.bashrc
```
Mac
```bash
echo 'export ANTHROPIC_API_KEY=your_api_key_here' >> ~/.zshrc
source ~/.zshrc
```

---

## Project structure

```text
.
├── bin/
│   ├── build      # build docker image
│   └── run        # run container
├── attach/        # place repositories here
├── .ai_env        # environment variables
└── README.md
```

---

## How to run

### 1. Create `.ai_env`

```bash
echo "TEST=test" > .ai_env
```

---

### 2. Build the image

```bash
bin/build
```

Builds the Docker image used by the AI client.

---

### 3. Add repositories

Put any repositories or project folders inside:

```text
attach/
```

Example:

```text
attach/
├── repo-one/
├── repo-two/
└── test-project/
```

These repositories will be available inside the container.

---

### 4. Run the container

```bash
bin/run
```

This launches the AI client container with attached repositories and environment variables loaded from `.ai_env`.

---

## Typical workflow

```bash
echo "TEST=test" > .ai_env
bin/build
cp -r ~/my-project attach/
bin/run
```

---

## Notes

* Keep `.ai_env` out of Git
* Add `.ai_env` to `.gitignore`
* Keep repositories inside `attach/`
* Never commit API keys
