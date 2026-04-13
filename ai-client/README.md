# ai-client

Simple containerized AI client environment for working with attached repositories.

---


## Environment variables

Before running the container, create a `.ai_env` file in the project root.

Example:

```bash
ANTHROPIC_API_KEY=your_api_key_here
```

This variable is required for the AI client to work correctly.

---

## Project structure

```text
.
├── bin/
│   ├── build      # build docker image
│   └── run        # run container
├── attach/        # place repositories here
├── .ai_env           # environment variables
└── README.md
```

---

## How to run

### 1. Create `.ai_env`

Create a `.ai_env` file:

```bash
echo "ANTHROPIC_API_KEY=your_api_key_here" > .ai_env
```

---

### 2. Build the image

Run:

```bash
bin/build
```

This builds the Docker image used by the AI client.

---

### 3. Add repositories

Put any repositories or project folders you want to work with inside:

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

Start the container with:

```bash
bin/run
```

This launches the AI client container with attached repositories and environment variables loaded from `.ai_env`.

---

## Typical workflow

```bash
echo "ANTHROPIC_API_KEY=your_api_key_here" > .ai_env
bin/build
cp -r ~/my-project attach/
bin/run
```

---

## Notes

* Keep `.ai_env` out of Git
* Add `.ai_env` to `.gitignore`
* Keep repositories inside `attach/`
* Do not commit API keys
