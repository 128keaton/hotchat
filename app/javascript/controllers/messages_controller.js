import {Controller} from "stimulus"
import $ from "jquery"

export default class extends Controller {

    scrolled = false;
    messages = $('#messages');
    messageForm = $('.new-message-form');

    reset() {
        this.element.reset();
        $(this.element).find(':submit').removeAttr('disabled');

        setTimeout(() => {
            this.messages.scrollTop(this.messages[0].scrollHeight);
        }, 200);
    }

    updateScroll() {
        if (!this.scrolled) {
            this.messages.scrollTop(this.messages[0].scrollHeight);
        }
    }

    connect() {
        this.updateScroll();
        const self = this;
        setInterval(() => {
            self.updateScroll()
        }, 1000);
        this.messages.on('scroll', () => {
            this.scrolled = !(this.messages[0].scrollHeight - this.messages.scrollTop() === this.messages.outerHeight());
        });

        setTimeout(() => {
            this.messages.addClass('show');
            this.messageForm.addClass('show');
            $('#send').focus();
        }, 150);
    }

}