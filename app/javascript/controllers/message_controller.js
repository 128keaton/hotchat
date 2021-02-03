import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {

    _shouldNotify = false;
    _prevType = null;

    initialize() {
        document.getElementById('silence').play();

        const self = this;

        $(window).on("blur focus", function (e) {
            if (self._prevType !== e.type) {
                switch (e.type) {
                    case "blur":
                        self._shouldNotify = true;
                        break;
                    case "focus":
                        self._shouldNotify = false;
                        break;
                }
            }

            self._prevType = e.type;
            $(window.document.body).data('should-notify', self._shouldNotify);
        });
    }

    connect() {
        const currentUserID = $('#current_room').data('local-user-id');
        const messageUserID = $(this.element).data('sender-id');

        if (currentUserID === messageUserID) {
            $(this.element).addClass('self-message');
        }

        setTimeout(() => {
            $(this.element).addClass('show');
        }, 100);


        if (this.shouldNotify()) {
            this.notify();
        }
    }

    notify() {
        document.getElementById('silence').pause();
        document.getElementById('notify').play().then(() => {
            document.getElementById('silence').play();
        })
    }

    shouldNotify() {
        return $(window.document.body).data('should-notify')
    }
}