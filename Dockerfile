FROM ghcr.io/linz/action-kart:v0.3.0

# Copy the extracted flatpak files to /usr/ (merging bin, lib, share, etc.)
COPY build-dir/files/ /usr/

# Many flatpak binaries are hardcoded to look for files in /app
# We create a symlink from /app to /usr to satisfy these references
RUN ln -s /usr /app

ENV LD_LIBRARY_PATH="/usr/lib:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="/usr/share/qgis/python:/usr/lib/python3.12/site-packages:${PYTHONPATH}"

# QGIS often needs to know its installation prefix
ENV QGIS_PREFIX_PATH="/usr"

# Ensure QGIS runs headless offscreen platform
ENV QT_QPA_PLATFORM="offscreen"

# Set locale to UTF-8 to suppress Qt warnings
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

WORKDIR /app

RUN qgis --version
