# Buildpack for Node.js

This is a [buildpack](https://www.cloudcontrol.com/dev-center/Platform%20Documentation#buildpacks-and-the-procfile) for
Node.js / io.js apps, powered by [npm](https://npmjs.org/).


## Usage

The buildpack will use npm to install your dependencies, vendoring a copy of
the Node.js / io.js into your web container.

This is our default buildpack for Node.js / io.js applications. In case you
want to introduce custom changes, fork the buildpack,
apply changes and test them via the [custom buildpack feature](https://www.cloudcontrol.com/dev-center/Guides/Third-Party%20Buildpacks/Third-Party%20Buildpacks).


## Node.js / io.js and npm versions

You can specify the versions of Node.js / io.js and npm your application
requires using `package.json`.

### Node.js

```
{
  "name": "myapp",
  "version": "0.1.0",
  "engines": {
    "node": "~0.12.3",
    "npm": "~2.11.0"
  }
}
```

### io.js

```
{
  "name": "myapp",
  "version": "0.1.0",
  "engines": {
    "iojs": "~2.0.2",
    "npm": "~2.11.0"
  }
}
```
