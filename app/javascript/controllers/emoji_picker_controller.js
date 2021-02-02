import { Controller } from "stimulus"
import {EmojiButton} from '@joeattardi/emoji-button'

export default class extends Controller {
    static targets = [ "button", "input" ]

    connect() {
        this.picker = new EmojiButton()
        this.picker.on('emoji', selection => {
            this.buttonTarget.innerHTML = selection.emoji
            this.inputTarget.value = selection.emoji
        })
    }

    toggle(event) {
        event.preventDefault()
        this.picker.togglePicker(event.target)
    }
}