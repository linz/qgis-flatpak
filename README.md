# Flatpak QGIS packaging QT6 & Parquet

Custom flatpak packaging for QGIS, (QT6+Parquet)

Forked from https://github.com/flathub/org.qgis.qgis with QT6 & Parquet additions

## Building

```shell
flatpak-builder --force-clean --disable-updates --ccache --user --sandbox --install ./build --repo=linz --install-deps-from=flathub nz.govt.linz.qgis.json
```

Bundle into flatpak

```shell
QGIS_COMMIT=$(cat nz.govt.linz.qgis.json | jq '.modules[0].sources[0].commit' -r)
flatpak build-bundle --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo linz qgis-linz_${QGIS_COMMIT}.flatpak nz.govt.linz.qgis
```