# xavier maso's website

[!["builds.sr.ht status"](https://builds.sr.ht/~pamplemousse/xaviermaso.com.svg)](https://builds.sr.ht/~pamplemousse/xaviermaso.com)

* powered by [expressjs](http://expressjs.com/) and [elm](http://elm-lang.org/)
* running live at [xaviermaso.com](https://www.xaviermaso.com/)

## development

```bash
# development environment is provided using `nix`
nix develop

# install dependencies
npm install
elm make

# run the app in dev mode
npm run dev

# build the front
npm run build

# syntax checking and formatting
npm run check
```

## run the app

```bash
podman run \
  --name xaviermaso.com \
  -e NODE_ENV=production \
  -p 8080:8000 \
  pamplemousse/xaviermaso.com
```
