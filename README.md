# ISO19139 Metadata Profile schema plugin for non-spatial datasets

ISO19139 Metadata Profile

## GeoNetwork versions to use with this plugin

**Use this branch with GeoNetwork 3.12.x**

## Installing the plugin in GeoNetwork

### Adding to an existing installation

 * Download or clone this repository 
 * Copy `src/main/plugin/iso19139.nonspatial` to `INSTALL_DIR/geonetwork/WEB_INF/data/config/schema_plugins/iso19139.nonspatial` in your installation.
 * Copy `target/schema-iso19139.nonspatial-3.12-SNAPSHOT.jar` to `INSTALL_DIR/geonetwork/WEB_INF/lib`
 * Restart GeoNetwork
 * Check that the schema is registered by visiting Admin Console -> Metadata and Templates -> Standards in GeoNetwork. If you do not see iso19139.nonspatial then it is not correctly deployed. Check your GeoNetwork log files for errors.

### Adding the plugin to the source code prior to compiling GeoNetwork

The best approach is to add the plugin as a submodule. Use https://github.com/geonetwork/core-geonetwork/blob/3.12.x/add-schema.sh for automatic deployment:

```
.\add-schema.sh iso19139.nonspatial http://github.com/astuntechnology/iso19139.nonspatial 3.12.x
```

#### Building the application 

See https://geonetwork-opensource.org/manuals/trunk/en/install-guide/installing-from-source-code.html. 

Once the application is built `web/target/geonetwork.war` will contain GeoNetwork with the non-spatial schema plugin included.