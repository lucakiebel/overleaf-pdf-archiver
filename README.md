# Overleaf PDF Archiver

This is a Docker-based utility that automatically scans the compiled output files of a self-hosted Overleaf instance and archives them for public access. The archived PDFs are served via Nginx and can be accessed using a public URL (e.g., through a Cloudflare Tunnel).

---

## ✨ Features

- Automatically copies every `output.pdf` file from Overleaf's internal compile directory.
- Saves them as `<PROJECT_ID>.pdf` into a permanent archive directory.
- Serves them via a minimal Nginx server on a configurable port.
- Fully configurable via `.env`.

---

## 📦 Usage

### 1. Clone this repository

```bash
git clone https://github.com/yourusername/overleaf-pdf-archiver.git
cd overleaf-pdf-archiver
```

### 2. Configure `.env`

Copy and modify the `.env` file to set up your paths and ports:

```dotenv
# .env
OVERLEAF_COMPILE_DIR=/absolute/path/to/your/overleaf/compiles
SCAN_INTERVAL_SECONDS=120
NGINX_PORT=8012
```

> 🔍 **How to find `OVERLEAF_COMPILE_DIR`**
>
> After compiling a document in Overleaf, look for a file called `output.pdf` on your host machine.
>
> If you installed Overleaf via Docker Compose or the Overleaf Toolkit, it is usually in:
>
> ```
> /path/to/overleaf/data/compiles/<PROJECT_ID>/output.pdf
> ```
>
> For example:
>
> ```
> /home/youruser/docker/overleaf-toolkit/data/overleaf/data/compiles
> ```
>
> The `OVERLEAF_COMPILE_DIR` is the directory that contains all these `<PROJECT_ID>` folders.

### 3. Build and start the containers

```bash
docker-compose up -d --build
```

---

## 🔗 Accessing the PDFs

Once running, archived PDFs will be available at:

```
http://localhost:8012/<PROJECT_ID>.pdf
```

Only files that have been compiled and archived will be available.

---

## 📁 Directory Structure

* `archive/`: Permanent storage for the archived PDFs.
* `logs/`: Log files showing archiving activity.
* `nginx.conf`: Nginx config for serving the archive.
* `archive_overleaf_pdfs.sh`: Main script that does the copying.
* `Dockerfile`: Container setup for the archiver script.
* `docker-compose.yml`: Project orchestration.
* `.env`: Configuration file (not committed to Git).

---

## 🛠️ Troubleshooting

* Make sure Overleaf has been used to compile a project at least once so that `output.pdf` exists.
* Verify your paths and permissions — the archiver must have read access to Overleaf's compile directory.

---

## 📜 License

See [LICENSE](./LICENSE).