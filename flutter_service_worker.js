'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4f709516afd1f356d2c49bae33e89313",
"assets/AssetManifest.bin.json": "bed6fb95855c84ac432de80222eca250",
"assets/AssetManifest.json": "74aa51ce4a6948251c96177cdee173ed",
"assets/assets/fonts/Poppins_Bold.ttf": "03213fbc7715346f48f37aeda3995d5e",
"assets/assets/fonts/Poppins_Light.ttf": "e54f4f6e09afbd0c9edf50e4eff51757",
"assets/assets/fonts/Poppins_Medium.ttf": "d2cc0d5e7654933133b0f6b4b89b03d9",
"assets/assets/fonts/Poppins_Regular.ttf": "27106a15a05c3ad623e4937b03a864a7",
"assets/assets/fonts/Poppins_SemiBold.ttf": "6faa1fc0a4b21e6be9dbbbb63466dbaf",
"assets/assets/images/markers/404_error.png": "40903f5c79fe40923c9dff5669b21ef5",
"assets/assets/images/markers/ic_hotel_marker.png": "b7ab52c4c53fc68dd23358df032afc83",
"assets/assets/images/markers/ic_hotel_marker_selected.png": "3cd534f96649f65b998f04b5f455ed28",
"assets/assets/images/markers/ic_tourist_marker.png": "fd251dc79139fdcac10a21823f31f6d5",
"assets/assets/images/svg/404_error.svg": "861214d32501eee4d31b49d118bd1827",
"assets/assets/images/svg/ic_address.svg": "08a18e903ef57f7609ebb73487cc2512",
"assets/assets/images/svg/ic_calendar.svg": "3bb2d09ca466f74ae8ba5df31d8927ef",
"assets/assets/images/svg/ic_cancel.svg": "bf076302a2a32bef17fbc03a5e37b3d5",
"assets/assets/images/svg/ic_chat.svg": "2c76e0e61f137453d42b12b0cc45134e",
"assets/assets/images/svg/ic_clock.svg": "504ebfcb6b8e50c857ff3822253dcc4c",
"assets/assets/images/svg/ic_copy.svg": "dc56a0b045687a64a534b8e4f6af9573",
"assets/assets/images/svg/ic_delete.svg": "fc4602708be49e24f120d2e2e09ac7f4",
"assets/assets/images/svg/ic_destination_address.svg": "181ff4049e6ae3a143283eb87cf5c71d",
"assets/assets/images/svg/ic_destination_phone.svg": "3f83441edda470ba79a2ebd396760b9a",
"assets/assets/images/svg/ic_edit.svg": "58e66f1363b3341c6fa0e92481f42f7b",
"assets/assets/images/svg/ic_filter.svg": "6c7f5fce9e79ab70b4407911052f7694",
"assets/assets/images/svg/ic_generate.svg": "aabd0e6e0ae1432e608251137d0772bd",
"assets/assets/images/svg/ic_home.svg": "c94daf4d7b52b065982c5ab6dcce1373",
"assets/assets/images/svg/ic_like.svg": "fbe3fa5f02228a73c8dbecb76c180f4e",
"assets/assets/images/svg/ic_logout.svg": "7d874074fab59d40dd73fd8e3acd38e8",
"assets/assets/images/svg/ic_marker.svg": "e8a144e94a6395c06e457a38b67a8af6",
"assets/assets/images/svg/ic_node.svg": "f66cccef57c7b7e06f903a7d0148319b",
"assets/assets/images/svg/ic_phone.svg": "07ba642a80f6dd7efae323ed7b7dde84",
"assets/assets/images/svg/ic_profile.svg": "372e79571d8f23aded38742335e0fb27",
"assets/assets/images/svg/ic_radius.svg": "9bc3febc7c0ed651ee9d3773c17f3abc",
"assets/assets/images/svg/ic_schedule.svg": "a4e0f51992f57b3c8fa90497bac1f29c",
"assets/assets/images/svg/ic_schedule_add.svg": "c650ef9446d93fdb236be9db843e14c5",
"assets/assets/images/svg/ic_search.svg": "735fe86f5e498cffdca71731add445c0",
"assets/assets/images/svg/ic_setting.svg": "464c79ca3eb9a5824c6f0d888c4fef0e",
"assets/assets/images/svg/ic_tag.svg": "19463d46b3e4f4a51ea4397892f3b086",
"assets/assets/images/svg/ic_time.svg": "103bd603adeeadf2e4a409c1b85bd049",
"assets/assets/images/svg/ic_user.svg": "8e19faec872fde2ee19231b9061885f8",
"assets/assets/images/svg/ic_vector.svg": "0dbe5c3b6ea8c834403aa35b5f29b0cb",
"assets/assets/images/svg/ic_warning.svg": "b9b6d048f0c7e9dcfc2aaeb333e8bb2b",
"assets/assets/images/svg/logo.svg": "b8e4183463d9be411e704d2c1f2a7ea4",
"assets/assets/images/tab_bar/notification.png": "956ca9057ca183c539b6d58f983de31e",
"assets/assets/images/tab_bar/notification_selected.png": "c968ff9e816c8f18adf4e4efefbb2411",
"assets/assets/images/tab_bar/person.png": "6f23e8165bbbfb10de38c548726ac512",
"assets/assets/images/tab_bar/person_selected.png": "153a768dafbff0d5daac267c3a065419",
"assets/assets/translations/en-US.json": "d93e3157e84a887d1f5bf320f0641a6d",
"assets/assets/translations/ko-KR.json": "393b3fb90d22beb9ae3f2862c2294dde",
"assets/assets/translations/vi-VN.json": "dfe4a4ad5885dfc332ddd0c6e07f611e",
"assets/FontManifest.json": "7e436d569bf0930354e7005e0c5dfecc",
"assets/fonts/MaterialIcons-Regular.otf": "289720565d3e1fc7f7fabee885abafce",
"assets/NOTICES": "606742a5db9c13ac5e8d5ddcbee7549f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "791ee73e5a3e39cd777692a15f09861a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "26b965582c39b62cce9be71a7816f0b9",
"/": "26b965582c39b62cce9be71a7816f0b9",
"main.dart.js": "9c06e13e953e2c507cb6950d88b74900",
"manifest.json": "6b1700bcf1e48a82d3ad07072c632f15",
"version.json": "db70266251870774b1e8f51ee8ded09f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
