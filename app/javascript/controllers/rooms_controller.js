import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
    static targets = ['form'];

    submitForm(event) {
        let isValid = this.validateForm(this.element);
        let error = $('.form-error');

        if (!isValid) {
            event.preventDefault();

            error.addClass('form-error-show');
        } else {
            error.removeClass('form-error-show');
            this.clearForm();
            $('#newRoomModal').modal('hide');
        }

    }

    loadRoom() {
        const $body = $('body');
        const forms = $body.find('form');


        $(".emoji-picker__wrapper").remove();

        if (forms.length > 1) {
            $(forms[forms.length - 1]).remove();
        }

        setTimeout(() => {
            const messages = $('.messages');
            const messageForm = $('.new-message-form');

            messages.addClass('show');
            messageForm.addClass('show');

        }, 150);
    }

    validateForm() {
        let isValid = true;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();
                isValid = field.value.trim().length > 5;
            }
        });


        return isValid;
    }

    clearForm() {
        let fieldSelectors = 'input';
        let fields = this.element.querySelectorAll(fieldSelectors);

        fields.forEach((field) => {
            field.value = '';
        });
    }
}