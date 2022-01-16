//gamerz_eno,moz-extension://21de1b5d-f5f3-4da7-ab95-aa399d25dae1/src/content/edit-user-script.html#0d8385bc-7ea6-499d-b03e-88d344254414
//surf_eno,moz-extension://031e13cb-941a-469d-b8f4-86a4a1a8f83c/src/content/edit-user-script.html#ffad375e-0b4e-49d0-8a6d-6ddb5b9d1e68
// ==UserScript==
// @name         dev-script
// @version      0.3
// @author       dev@michmue.de
// @match        https://nhentai.net/search/*
// @match        https://nhentai.net/g/*
// @match        https://nhentai.net/
// @match        https://nhentai.net/?page=*
// @updateURL	 http://localhost:8080/addon-nh4.user.js
// @downloadURL  http://localhost:8080/addon-nh4.user.js
// @grant       GM.xmlHttpRequest
// ==/UserScript==
// @match        https://nhentai.net/tag/*
// @match        https://nhentai.net/group/*
// @match        https://nhentai.net/artist/*
// @match        https://nhentai.net/character/*
// @match        https://nhentai.net/parody/*

//TODO  v2
//      - find duplicated through language:translated, author & title
//        or find the original /g/id by -language:translated
//      - find duplicated through picture comparison machine learning

//TODO replace href's to /search/*, so no reload is necessary
//TODO fix SearchParams when page > 1, params will be added behind page parameter and will not be recognized

var TagManager = {
        getTagsFromURL: function () {
            let urlParams = new URLSearchParams(window.location.search);
            //get all params from the q= parameter
            let parsedQParams = new Map()
            let parsedQParams2 = {
                tags:[],
                artist:undefined,
                languages:[],
                characters:[],
                parody:undefined,
                group:undefined
            }
            parsedQParams.set("tag", [])
            parsedQParams.set("language", [])
            parsedQParams.set("character", [])

            if (urlParams.has("q")) {
                let q = urlParams.get("q");
                let qParams = q.split(" ");
                qParams.forEach(qp => {
                    let keyVal = qp.split(":")
                    let key = keyVal[0]
                    let val = keyVal[1]

                    switch (key) {
                        case "character": parsedQParams2.characters.push(val); break;
                        case "language": parsedQParams2.languages.push(val); break;
                        case "tag": parsedQParams2.tags.push(val); break;
                        case "group": parsedQParams2.group = val; break;
                        case "parody": parsedQParams2.parody = val; break;
                        case "artist": parsedQParams2.artist = val; break;
                    }
                    // if (parsedQParams.has(key)) {
                    //     parsedQParams.get(key).push(val)
                    // } else {
                    //     parsedQParams.set(key, val)
                    // }
                });
            }

            return parsedQParams2;
        },
        // getTagsFromSession: {tags:[]},
    };
//
// console.log(TagManager.getTagsFromURL());
// console.log(TagManager.getTagsFromURL().get("tag"));

function relocateLinksToSearch(){
    let aNodes = document.querySelectorAll("section#tags a");
    aNodes.forEach(a => {
        let parts = a.href.split("/");
        let linkDst = parts[3];
        let linkVal = parts[4];
        switch (linkDst) {
            case "tag": a.href = a.href.replace("/tag/", "/search/?q=").replace(linkVal, "tag%3A" + linkVal).slice(0,-1); break;
            case "group": a.href = a.href.replace("/group/", "/search/?q=").replace(linkVal, "group%3A" + linkVal).slice(0,-1); break;
            case "artist": a.href = a.href.replace("/artist/", "/search/?q=").replace(linkVal, "artist%3A" + linkVal).slice(0,-1); break;
            case "language": a.href = a.href.replace("/language/", "/search/?q=").replace(linkVal, "language%3A" + linkVal).slice(0,-1); break;
            case "parody": a.href = a.href.replace("/parody/", "/search/?q=").replace(linkVal, "parody%3A" + linkVal).slice(0,-1); break;
        }
    });
}
relocateLinksToSearch();

// console.log("TagManager.getTagsFromURL()");

let port = "5000";

let isMangaDetailsPage = window.location.href.includes("/g/");
if (isMangaDetailsPage) {

    let id = window.location.href.split("/g/")[1].split("/")[0]
    let title = document.querySelector("h1.title").textContent;

    (async () => {

        GM.xmlHttpRequest({
            method: "GET",
            timeout: 500,
            url: "http://localhost:" + port + "/addVisitedManga?id=" + id + "&title=" + encodeURI(title),
            ontimeout: function () {
                injectServerOfflineIndecator()
            },
            onload: function (response) {
                //alert(response.responseText);
            }
        });
    })()


} else {

    let showKnown = getCookie("show_known", false);
    // let showKnown = false;

    addBarKnownHidden(showKnown);
    let GET_MANGAS = "http://localhost:" + port + "/mangas?id=";
    let covers = document.querySelectorAll("div > a.cover[href*='/g/']");
    let ids = Array.from(covers).map(cover => cover.href.split("/")[4]).join(",");

    GM.xmlHttpRequest({
        method: "GET",
        url: GET_MANGAS + ids,
        timeout: 1000,
        onload: function (response) {
            let mangas = JSON.parse(response.response);
            let knownMangaIds = mangas.map(m => m.id);
            unsafeWindow.knownMangaIds = JSON.stringify(knownMangaIds);
            highlightMangas(mangas, covers, showKnown);
        },
        ontimeout: function () {
            injectServerOfflineIndecator()
        },
    });


    function highlightMangas(mangas, covers, showKnown) {
        let knownMangaIds = mangas.map(m => m.id);
        covers.forEach(c => {
            let cId = c.href.split("/")[4];
            let found = knownMangaIds.find(id => id == cId);
            if ((found != undefined && showKnown == "false") || found != undefined && !showKnown) {
                c.parentElement.style.display = 'none';
            } else if (showKnown) {
                c.parentElement.style.display = 'inline-block';
            }
        })
    }


    function addCategoriesToBar(categories, isActive) {
        if (categories.artist) addItemToBar("a", categories.artist, isActive)
        if (categories.parody) addItemToBar("p", categories.parody, isActive)
        if (categories.group) addItemToBar("g", categories.group, isActive)
        if (categories.language) addItemToBar("l", categories.language, isActive)
        if (categories.characters.length > 0) addItemsToBar("c", categories.characters, isActive)
        if (categories.tags.length > 0) addItemsToBar("", categories.tags, isActive)
    }

    function addItemsToBar(prefix, items, isActive) {
        items.forEach(i => addItemToBar(prefix, i, isActive))
    }


    var bar = document.querySelector(".sort")
    var itemContainer = document.createElement("div")
    itemContainer.style = "font-size: 14px;margin-bottom:15px"
    itemContainer.className = "sort-type"

    function addItemToBar(cat, text, isActive) {
        var item = document.createElement("a")
        if (!isActive) item.style = "background-color: " + "#662121";
        if (isActive) item.style = "background-color: " + "rgb(33, 102, 50)";

        if (cat === "") item.text = text
        if (cat !== "") item.text = cat + ": " + text


        if (isActive) {
            //deactive Href
            // https://nhentai.net/search/?q=tag%3Asole-male+tag%3Afull-color
            var href = document.location.href
            let strings = href.split("q=");
            var categoryAndContent = strings[1]
                .split("&")[0]
                .split("+")
                .find(x => x.includes(text));
            item.href = href.replace("+" + categoryAndContent, "").replace(categoryAndContent, "")
        }

        if (!isActive) {
            //deactive Href
            // https://nhentai.net/search/?q=tag%3Asole-male+tag%3Afull-color
            var href = document.location.href
            switch (cat) {
                case "": item.href = href + "+tag%3A" + text; break;
                case "p": item.href = href + "+parody%3A" + text; break;
                case "g": item.href = href + "+group%3A" + text; break;
                case "l": item.href = href + "+language%3A" + text; break;
                case "c": item.href = href + "+character%3A" + text; break;
                case "a": item.href = href + "+artist%3A" + text; break;
            }
        }
        itemContainer.appendChild(item)
        bar.appendChild(itemContainer)
    }

    function getDeactivatedCategories(activeCats, touchedCats) {
        var deactivCategories = {"tags": [], "artist": null, "characters": [], "parody": null, language: null}

        //if (activeCats.artist != undefined && activeCats.artist !== activeCats.touched) addItemToBar("a: ", categories.artist)
        //if (categories.parody != undefined) addItemToBar("p: ", categories.parody)
        //if (categories.group != undefined) addItemToBar("g: ", categories.group)
        //if (categories.characters.length > 0) addItemsToBar("c: ", categories.characters)


        touchedCats.characters.forEach(touched => {
            if (undefined === activeCats.characters.find(active => active === touched)) {
                deactivCategories.characters.push(touched)
            }
        })

        touchedCats.tags.forEach(touched => {
            if (undefined === activeCats.tags.find(active => active === touched)) {
                deactivCategories.tags.push(touched)
            }
        })

        if (!activeCats.language) {
            deactivCategories.language = "english"
        }

        return deactivCategories
    }

    function addDeactivatedCategories(categories) {
        addCategoriesToBar(categories, false)
    }

    function saveCategoriesToCookies(categories) {
        let previousCats = getCookieCategories()
        let allTouchedCats = mergeCategories(previousCats, categories)
        document.cookie = "cats=" + JSON.stringify(categories) + ";";
    }

    function mergeCategories(previousCats, categories) {
        let mergedCats = {"tags": [], "artist": null, "characters": [], "parody": null, language: "english"}
        mergedCats.tags = [...new Set(previousCats.tags.concat(categories.tags).concat("full-color"))]
        mergedCats.characters = [...new Set(previousCats.characters.concat(categories.characters))]
        mergedCats.artist = categories.artist || previousCats.artist
        mergedCats.group = categories.group || previousCats.group
        mergedCats.parody = categories.parody || previousCats.parody
        mergedCats.language = "english"
        return mergedCats
    }

    function getCookieCategories() {
        let cats = document.cookie.split(";")
            .find(cookie => cookie.startsWith("cats="))
        if (cats) return mergeCategories(JSON.parse(cats.split('=')[1]), activeCats)
        return mergeCategories({
            "tags": ["full-color"],
            "artist": null,
            "characters": [],
            "parody": null,
            language: "english"
        }, activeCats);
    }

    let activeCats = TagManager.getTagsFromURL();
    //let activeCats = getActiveCategories()
    //console.log(activeCats);
    console.log(activeCats);
    //activeTags2 = Object.fromEntries(activeTags2)
    addCategoriesToBar(activeCats, true)

    let cookieCats = getCookieCategories()

    let deactivatedCategories = getDeactivatedCategories(activeCats, cookieCats);
    addDeactivatedCategories(deactivatedCategories)

    let newCookies = mergeCategories(activeCats, cookieCats)
    saveCategoriesToCookies(newCookies)


    function addBarKnownHidden(isHidden) {
        var divOuterHtml = '';
        if (isHidden) {

            var script = `
function setCookie(key, val) {
    document.cookie = key + "=" + val;
}

function getCookie(key, defaultValue) {
    var cookie = document.cookie.split("; ").find(item => item.includes(key + "="));
    debugger;
    if (cookie != undefined) return cookie.split("=")[1]
    return defaultValue
}`
            divOuterHtml = `<div class="sort">
                                    <div class="sort-type">
                                        <span class="sort-name" onclick="setCookie('show_known', getCookie('show_known', false));">Known: Hidden</span>
                                    </div>
                                </div>`;

        } else {
            divOuterHtml = `<div class="sort">
                                <div class="sort-type">
                                    <span class="sort-name" onclick="setCookie('show_known', getCookie('show_known', false));">Known: Visible</span>
                                </div>
                            </div>`
        }
        let div = document.querySelector("div#content");

        let htmlScriptElement = document.createElement("script");
        // htmlScriptElement.innerHTML = script;
        div.insertBefore(htmlScriptElement, div.firstChild);
        var sortDiv = document.createElement("div");
        div.insertBefore(sortDiv, div.firstChild)
        sortDiv.outerHTML = divOuterHtml;
    }

}

function setCookie(key, val) {
    document.cookie = key + "=" + val;
}

function getCookie(key, defaultValue) {
    let cookie = document.cookie.split("; ").find(item => item.includes(key + "="));
    if (cookie != undefined) return cookie.split("=")[1]
    return defaultValue
}

function injectServerOfflineIndecator() {
    let div = document.querySelector("div#content");
    var offlineDiv = document.createElement("div");
    offlineDiv.innerHTML = `
        <div class="none" style="position: fixed;top:55px; left:0; background-color: red;z-index: 999999;">
            <span onclick='navigator.clipboard.writeText("py C:/projects/win-backup/scripts/nh-server/nh-server.py")'>offline</span>    
        </div>
    `;
    div.insertBefore(offlineDiv, div.firstChild)
}

function main() {
    let settings = {
        itemsSelector: "div > a.cover[href*='/g/']",
        onVisitedMangesLoad: function (visitedMangas) {}
    }

    let FavoriteManager = {
        settings: settings,

        run: function () {
            let mangaElements = Array.from(document.querySelectorAll(this.settings.itemsSelector));
        },
        onVisitedMangesLoad: function () {
            this.settings.onVisitedMangesLoad();
        }

    };

    FavoriteManager.run();
    var TagManager = {
        getTagsFromURL: function () {
            let urlParams = new URLSearchParams(window.location.search);
            let params = new Map();
            urlParams.forEach(((value, key) => {
                let queryParam = value.split(" ");
                let categories = {}
                queryParam.forEach(p => {
                    let split = p
                    // .split(":");
                    // let cat = split[0];
                    // let val = split[1];
                    // console.log("cat:" + cat +"  |  val:"+val)
                    // let propExists = categories.getProperty(cat) !== undefined
                    // if (propExists) {
                    //     categories.setProperty(cat, val);
                    // }
                })
                // params.set(key, categories)

            }))
        },
        getTagsFromSession: {tags:[]},
    };
    TagManager.sessionTags2()
    FavoriteManager.injectFilterToPage();
    sessionStorage.setItem("categories", JSON.stringify())

}