# Flatpak QGIS packaging QT6 & Parquet

Custom flatpak packaging for QGIS, (QT6+Parquet)

Forked from https://github.com/flathub/org.qgis.qgis with QT6 & Parquet additions

## Building

```shell
flatpak-builder \
  --force-clean \
  --state-dir=.flatpak-state \
  --disable-updates \
  --ccache \
  --user \
  --sandbox \
  --install ./build \
  --repo=linz \
  --install-deps-from=flathub \
  nz.govt.linz.qgis.json
```

Bundle into flatpak

```shell
QGIS_COMMIT=$(cat nz.govt.linz.qgis.json | jq '.modules[0].sources[0].commit' -r)
flatpak build-bundle \
  --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo \
  linz \
  qgis-linz_${QGIS_COMMIT}.flatpak \
  nz.govt.linz.qgis
```

## Perf:

set a larger cache
```bash
ccache --max-size 100G
```

Set a shared cache location
```bash
mkdir $HOME/.cache/flatpak-builder-ccache
export CCACHE_DIR=$HOME/.cache/flatpak-builder-ccache
```

## Caching

To prevent re-downloading files on every build (especially when using `--force-clean`), you can specify a persistent state directory using `--state-dir`.

```shell
# Create a directory for the cache
mkdir -p .flatpak-state
```

When using `--state-dir`, the `--force-clean` option only cleans the build artifacts within that state directory, but preserves the `downloads` subdirectory, effectively caching the source files.