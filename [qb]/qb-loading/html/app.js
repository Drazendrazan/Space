const { ref } = Vue

// Customize language for dialog menus and carousels here

const load = Vue.createApp({
  setup () {
    return {
      CarouselText1: 'You can add/remove items, vehicles, jobs & gangs through the shared folder.',
      CarouselSubText1: 'Photo captured by: Markyoo#8068',
      CarouselText2: 'Adding additional player data can be achieved by modifying the qb-core player.lua file.',
      CarouselSubText2: 'Photo captured by: ihyajb#9723',
      CarouselText3: 'All server-specific adjustments can be made in the config.lua files throughout the build.',
      CarouselSubText3: 'Photo captured by: FLAPZ[INACTIV]#9925',
      CarouselText4: 'For additional support please join our community at discord.gg/qbcore',
      CarouselSubText4: 'Photo captured by: Robinerino#1312',

      DownloadTitle: 'Downloading QBCore Server',
      DownloadDesc: "Hold tight while we begin downloading all the resources/assets required to play on QBCore Server. \n\nAfter download has been finished successfully, you'll be placed into the server and this screen will disappear. Please don't leave or turn off your PC. ",

      SettingsTitle: 'Settings',
      AudioTrackDesc1: 'When disabled the current audio-track playing will be stopped.',
      AutoPlayDesc2: 'When disabled carousel images will stop cycling and remain on the last shown.',
      PlayVideoDesc3: 'When disabled video will stop playing and remain paused.',

      KeybindTitle: 'Touche Default',
      Keybind1: 'Ouvrir inventaire',
      Keybind2: 'Cercle de proximiter',
      Keybind3: 'Ouvrir son telephone',
      Keybind4: 'm etre sa ceinture',
      Keybind5: 'Ouvrir sont menue',
      Keybind6: 'Menue radial',
      Keybind7: 'Ouvrir le HUD',
      Keybind8: 'Parler a la Radio',
      Keybind9: 'Ouvrir Menue des Scores',
      Keybind10: 'Verrouiller sont Vehicle',
      Keybind11: 'etteindre sont moteur et l allumer',
      Keybind12: 'Pointer',
      Keybind13: 'raccourcis case',
      Keybind14: 'main en l air',
      Keybind15: 'Utiliser l objet de case selectionner',
      Keybind16: 'touche de balade',

      firstap: ref(true),
      secondap: ref(true),
      thirdap: ref(true),
      firstslide: ref(1),
      secondslide: ref('1'),
      thirdslide: ref('5'),
      audioplay: ref(true),
      playvideo: ref(true),
      download: ref(true),
      settings: ref(false),
    }
  }
})

load.use(Quasar, { config: {} })
load.mount('#loading-main')

var audio = document.getElementById("audio");
audio.volume = 0.05;

function audiotoggle() {
    var audio = document.getElementById("audio");
    if (audio.paused) {
        audio.play();
    } else {
        audio.pause();
    }
}

function videotoggle() {
    var video = document.getElementById("video");
    if (video.paused) {
        video.play();
    } else {
        video.pause();
    }
}

let count = 0;
let thisCount = 0;

const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (data.idx / count) * 100 + "%";
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;

        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (thisCount / count) * 100 + "%";
    },
};

window.addEventListener("message", function (e) {
    (handlers[e.data.eventName] || function () {})(e.data);
});
