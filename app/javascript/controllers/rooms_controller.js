import {Controller} from 'stimulus';
import $ from 'jquery';

const nameGenerator = require('@afuggini/namegenerator');

export default class extends Controller {
    static targets = ['form'];


    initialize() {
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    }

    submitForm(event) {
        const errorStatus = this.validateForm(this.element);

        const tooLongError = $('.form-error-long');
        const tooShortError = $('.form-error-short');
        const invalidCharactersError = $('.form-error-invalid-characters');


        tooLongError.removeClass('form-error-show');
        tooShortError.removeClass('form-error-show');
        invalidCharactersError.removeClass('form-error-show');

        if (Object.values(errorStatus).find(e => e)) {
            // Error found
            event.preventDefault();

            if (errorStatus.invalidCharacters) {
                invalidCharactersError.addClass('form-error-show');
                return;
            }

            if (errorStatus.tooLong) {
                tooLongError.addClass('form-error-show');
                return;
            }

            if (errorStatus.tooShort) {
                tooShortError.addClass('form-error-show');
                return;
            }
        }

        this.clearForm();
        $('#newRoomModal').modal('hide');
    }

    loadRoom() {
        const $body = $('body');
        const forms = $body.find('form');


        $(".emoji-picker__wrapper").remove();

        if (forms.length > 1) {
            $(forms[forms.length - 1]).remove();
        }
    }

    generateRandomName(event) {
        const roomName = nameGenerator(' ');
        const roomNameInput = $('input:required');

        roomNameInput.val(this.titleize(roomName));

        event.preventDefault();
    }

    validateForm() {
        const invalidRegex = /[^\x20-\x7E]+/g;

        let tooLong = false;
        let tooShort = false;
        let invalidCharacters = false;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();

                const matches = field.value.trim().match(invalidRegex);

                tooShort = field.value.trim().length < 5;
                tooLong = field.value.trim().length > 16;
                invalidCharacters = !!matches && matches.length > 0
            }
        });


        return {
            tooLong, tooShort, invalidCharacters
        };
    }

    clearForm() {
        let fieldSelectors = 'input';
        let fields = this.element.querySelectorAll(fieldSelectors);

        fields.forEach((field) => {
            field.value = '';
        });
    }

    titleize(sentence) {
        if (!sentence.split) return sentence;
        const _titleizeWord = function (string) {
                return string[0].toUpperCase() + string.slice(1).toLowerCase();
            },
            result = [];
        sentence.split(" ").forEach(function (w) {
            result.push(_titleizeWord(w));
        });

        return result.join(" ");
    }
}