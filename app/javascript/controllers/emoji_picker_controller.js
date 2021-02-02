import { Controller } from "stimulus"
import {EmojiButton} from '@joeattardi/emoji-button'

export default class extends Controller {
    static targets = [ "button", "input" ]

    connect() {
        this.picker = new EmojiButton()
        this.picker.on('emoji', selection => {
            console.log(selection);

            this.buttonTarget.innerHTML = `<i class="emoji">${selection.emoji}</i>`
            this.inputTarget.value +=  selection.emoji;
        })
    }

    toggle(event) {
        event.preventDefault()
        this.picker.togglePicker(event.target)
    }
}