// ==UserScript==
// @name         dev-script
// @version      0.3
// @author       You
// @match        https://nhentai.net/search/*
// @match        https://nhentai.net/tag/*
// @match        https://nhentai.net/group/*
// @match        https://nhentai.net/artist/*
// @match        https://nhentai.net/character/*
// @match        https://nhentai.net/parody/*
// @match        https://nhentai.net/g/*
// @match        https://nhentai.net/
// @match        https://nhentai.net/?page=*
// @updateURL	 http://localhost:8080/addon-nh4.user.js
// @downloadURL  http://localhost:8080/addon-nh4.user.js
// @grant       GM.xmlHttpRequest
// ==/UserScript==
let port = "5000";


if (window.location.href.includes("/g/")) {

    let id = window.location.href.split("/g/")[1].split("/")[0]
    let title = document.querySelector("h1.title").textContent;

    (async () => {

        GM.xmlHttpRequest({
            method: "GET",
            url: "http://localhost:" + port + "/addVisitedManga?id=" + id + "&title=" + encodeURI(title),
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
            console.log(mangas);
            let knownMangaIds = mangas.map(m => m.id);
            unsafeWindow.knownMangaIds = JSON.stringify(knownMangaIds);
            highlightMangas(mangas, covers, showKnown);
        },
        ontimeout: function () {
            console.log("server offline");
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


    var baseURL = "https://nhentai.net/search/?q="

    if (window.location.href.includes("/tag/")) {
        baseURL += "tag%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }
    if (window.location.href.includes("/character/")) {
        baseURL += "character%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }
    if (window.location.href.includes("/group/")) {
        baseURL += "gourp%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }
    if (window.location.href.includes("/artist/")) {
        baseURL += "artist%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }
    if (window.location.href.includes("/parody/")) {
        baseURL += "parody%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }

    if (window.location.href.includes("/language/")) {
        baseURL += "language%3A" + window.location.href.split("/")[4]
        window.location.href = baseURL
    }

    function getActiveCategories() {
        var params = document.location.href.split("q=")
        if (params !== undefined) {
            params = params[0].split("+")
            var categories = {"tags": [], "artist": null, "characters": [], "parody": null, language: null}
            params.forEach(
                e => {
                    let category = e.split("%3A")[0]
                    let entry = e.split("%3A")[1]
                    if (category === "tag") categories.tags.push(entry)
                    if (category === "character") categories.characters.push(entry)
                    if (category === "group") categories.group = entry
                    if (category === "parody") categories.parody = entry
                    if (category === "artist") categories.artist = entry
                    if (category === "language") categories.language = entry
                })
            return categories
        }
        return {"tags": [], "artist": null, "characters": [], "parody": null, language: null}
    }


    function addCategoriesToBar(categories, isActive) {
        if (categories.artist != undefined) addItemToBar("a", categories.artist, isActive)
        if (categories.parody != undefined) addItemToBar("p", categories.parody, isActive)
        if (categories.group != undefined) addItemToBar("g", categories.group, isActive)
        if (categories.language != undefined) addItemToBar("l", categories.language, isActive)
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
            var categoryAndContent = href.split("q=")[1].split("&")[0].split("+").find(x => x.includes(text));
            item.href = href.replace("+" + categoryAndContent, "").replace(categoryAndContent, "")
        }

        if (!isActive) {
            //deactive Href
            // https://nhentai.net/search/?q=tag%3Asole-male+tag%3Afull-color
            var href = document.location.href
            if (cat === "") item.href = href + "+tag%3A" + text
            if (cat === "p") item.href = href + "+parody%3A" + text
            if (cat === "g") item.href = href + "+group%3A" + text
            if (cat === "l") item.href = href + "+language%3A" + text
            if (cat === "c") item.href = href + "+character%3A" + text
            if (cat === "a") item.href = href + "+artist%3A" + text
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

    let activeCats = getActiveCategories()
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
//
// unsafeWindow.setCookie = exportFunction(setCookie, unsafeWindow);
// unsafeWindow.getCookie = exportFunction(getCookie, unsafeWindow);