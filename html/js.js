function updateFps(fps) {
    var val  = document.getElementById("fpsVal");
    var bar  = document.getElementById("perfBar");
    var pp   = document.getElementById("perfPct");
    var lbl  = document.getElementById("fpsLabel");
    var ring = document.querySelector(".fps-ring-spin");

    if (!val) return;

    var pct = Math.min(100, Math.round((fps / 144) * 100));
    if (bar) bar.style.width = pct + "%";
    if (pp)  pp.textContent  = pct + "%";

    var c = fps < 30 ? "#c03a2b" : fps < 60 ? "#c9a98e" : "#967969";
    if (ring) ring.style.borderTopColor = c;

    val.textContent = fps;
    val.style.color = c;

    if (lbl) {
        lbl.textContent = fps < 30 ? "CRITICAL" : fps < 60 ? "WARNING" : "STABLE";
        lbl.style.color = c;
    }
}

function setSetting(el, name) {
    document.querySelectorAll("#dGrid .xb:not(.red)").forEach(function(b) {
        b.classList.remove("active");
    });
    if (el) el.classList.add("active");

    var s = document.getElementById("activeSetting");
    if (s) s.textContent = name || "—";
}

function setFpsMode(el, name) {
    document.querySelectorAll("#fGrid .xb").forEach(function(b) {
        b.classList.remove("active");
    });
    if (el) el.classList.add("active");
}

function setActiveButton(index, name) {
    var buttons = document.querySelectorAll("#dGrid .xb:not(.red)");
    buttons.forEach(function(b) { b.classList.remove("active"); });

    if (index && index >= 1 && index <= 4) {
        var target = buttons[index - 1];
        if (target) target.classList.add("active");
    }

    var s = document.getElementById("activeSetting");
    if (s) s.textContent = name || (index ? "PRESET " + index : "NONE");
}

$(document).ready(function () {

    window.addEventListener("message", function (event) {

        // 🔹 OPEN UI
        if (event.data.action === "display") {
            $("body").css("display", "flex");

            var sn  = document.getElementById("serverName");
            var sub = document.getElementById("subName");
            var ver = document.getElementById("ver");

            if (sn)  sn.textContent  = event.data.ServerName || "SERVER";
            if (sub) sub.textContent = event.data.SubName    || "FPS CONTROL UNIT";
            if (ver) ver.textContent = event.data.Version    || "";

            $("#discord").text(event.data.Discord || "");
            $("#web").text(event.data.Web || "");
            $("#ping").text((event.data.Ping || "--") + " ms");
            $("#files").text(event.data.Files || "--");

            var fps = parseInt(event.data.Fps) || 60;
            updateFps(fps);

            var activeSetting = parseInt(event.data.ActiveSetting) || 0;
            var activeName    = event.data.ActiveName || "NONE";
            setActiveButton(activeSetting, activeName);
        }

        // 🔹 CLOSE UI
        if (event.data.action === "hide") {
            $("body").css("display", "none");
        }

        // 🔹 FPS LIVE UPDATE
        if (event.data.action === "fps-update") {
            var fps = parseInt(event.data.Fps) || 0;
            updateFps(fps);
        }

        // 🔹 ✅ PING LIVE UPDATE (FIXED)
        if (event.data.action === "ping-update") {
            $("#ping").text(event.data.Ping + " ms");
        }

    });

});

$(document).on("keydown", function (event) {
    if (event.keyCode === 27) {
        $("body").css("display", "none");
        $.post("https://zx_fpsmenu/close");
    }
});

function fpschanger(id) {
    $.post("https://zx_fpsmenu/fpschanger", JSON.stringify({ id: id }));
}

function advancedchanger(id) {
    $.post("https://zx_fpsmenu/advancedchanger", JSON.stringify({ id: id }));
}

function resetAdvanced() {
    document.querySelectorAll("#dGrid .xb:not(.red)").forEach(function(b) {
        b.classList.remove("active");
    });

    var s = document.getElementById("activeSetting");
    if (s) s.textContent = "NONE";

    $.post("https://zx_fpsmenu/advancedchanger", JSON.stringify({ id: 4 }));
}

function reset() {
    document.querySelectorAll("#dGrid .xb:not(.red), #fGrid .xb").forEach(function(b) {
        b.classList.remove("active");
    });

    var s = document.getElementById("activeSetting");
    if (s) s.textContent = "NONE";

    updateFps(60);
    $.post("https://zx_fpsmenu/reset");
}

// 🔹 INIT
$("body").css("display", "none");
updateFps(60);