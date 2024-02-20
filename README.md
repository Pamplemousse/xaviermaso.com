# xavier maso's website

![Known Vulnerabilities](https://snyk.io/test/github/Pamplemousse/xaviermaso.com/badge.svg?targetFile=package.json)

* powered by [expressjs](http://expressjs.com/) and [elm](http://elm-lang.org/)
* running live at [xaviermaso.com](https://www.xaviermaso.com/)

## development

```bash
# install dependencies
yarn install
elm make

# run the app in dev mode
npm run dev

# build the front
npm run build

# syntax checking and formatting
npm run check
```

*Note: [this docker image](https://hub.docker.com/r/pamplemousse/nodejs/) should contain all the tools to run and build the app.*

```bash
docker run --rm -it \
    -v $(pwd):/app -w /app \
    -u 1000:1000 \
    --net host -p 8000:8000 -p 8080:8080 \
    pamplemousse/nodejs
    ...
```

## run the app

```bash
docker run \
  --name xaviermaso.com \
  -e NODE_ENV=production \
  -p 8080:8000 \
  pamplemousse/xaviermaso.com
```
