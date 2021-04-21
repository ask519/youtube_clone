// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("hls.js")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {

    // Get all "navbar-burger" elements
    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

    // Check if there are any navbar burgers
    if ($navbarBurgers.length > 0) {

        // Add a click event on each of them
        $navbarBurgers.forEach( el => {
            el.addEventListener('click', () => {

                // Get the target from the "data-target" attribute
                const target = el.dataset.target;
                const $target = document.getElementById(target);

                // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
                el.classList.toggle('is-active');
                $target.classList.toggle('is-active');

            });
        });
    }

});

document.addEventListener('DOMContentLoaded', () => {
    // 1. Display file name when select file
    let fileInputs = document.querySelectorAll('.file.has-name')
    for (let fileInput of fileInputs) {
        let input = fileInput.querySelector('.file-input')
        let name = fileInput.querySelector('.file-name')
        input.addEventListener('change', () => {
            let files = input.files
            if (files.length === 0) {
                name.innerText = 'No file selected'
            } else {
                name.innerText = files[0].name
            }
        })
    }

    // 2. Remove file name when form reset
    let forms = document.getElementsByTagName('form')
    for (let form of forms) {
        form.addEventListener('reset', () => {
            console.log('a')
            let names = form.querySelectorAll('.file-name')
            for (let name of names) {
                name.innerText = 'No file selected'
            }
        })
    }
})